# Ctrl-delete to delete a word forward
bind \e\[3\;5~ kill-word

# Ctrl-bksp to delete backward
bind \cH backward-kill-word

function mkcd --wraps=mkdir 
	mkdir -p $argv; and cd $argv
end

function cl --wraps=cd 
  cd $argv; and ls
end

function pg --wraps=rg 
	ps -ef | rg (echo $argv | sed -e "s/^\(.\)/[\\0]/g")
end

alias nv="nvim" # So flag completion is better
alias rgp="rg -p --no-heading " # ripgrep for piping
alias rgc="rg --no-ignore -tcpp" # ripgrep for c++
alias frg="find | rg"

# Safety!
alias cp "cp -i"
alias mv "mv -i"

abbr -a l "ls"
abbr -a s "ls"
abbr -a c "cd"
abbr -a b "cd .."
abbr -a -- - "cd -"
abbr -a dr "docker"
abbr -a p "pushd"
abbr -a po "popd"
abbr -a gits "git s"
abbr -a which "command -v"
abbr -a g "git"

function xterm
	command xterm -bg black -fg white
end

function ev --wraps=evince
	evince $argv 2>/dev/null & disown
end

function loc --wraps=locate
	locate $argv | rg -v $argv[1].\*/ | rg -v \^$HOME/.local/share/nvim/ | rg -v \^$HOME/alt-Joby/ | rg -v \^$HOME/backup-Joby/
end

function xcl --wraps=xclip
	xclip -sel clip
end

function ipd --wraps=ipdb3
    python3.8 -Werror (command -v ipdb3) -cc $argv
end

function rr
  set PREV_CMD (history | head -1)
  set PREV_OUTPUT (eval $PREV_CMD)
  set CMD $argv[1]
  echo "Running '$CMD $PREV_OUTPUT'"
  eval "$CMD $PREV_OUTPUT"
end

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function switch-comment-commandline --description 'Comment/Uncomment the current or every line'
    set -l cmdlines (commandline)
    set -l cmdlines2 (commandline -c)
    if test "$cmdlines" = "$cmdlines2"
        commandline -r (printf '%s\n' '#'$cmdlines | string replace -r '^##' '')
    else
        set -l linenum (count $cmdlines2)
        set cmdlines[$linenum] (string replace -r '^##' '' -- '#'$cmdlines[$linenum])
        commandline -r $cmdlines
    end
end

#function comment-run-commandline --description 'Comment the current line, then run'
#    set -l cmdlines (commandline)
#    set -l cmdlines2 (commandline -c)
#    if test "$cmdlines" = "$cmdlines2"
#        commandline -r (printf '%s\n' '#'$cmdlines)
#    else
#        set -l linenum (count $cmdlines2)
#        echo $linenum
#        set cmdlines[$linenum] ('#'$cmdlines[$linenum])
#        commandline -r $cmdlines
#    end
#    commandline -f execute
#end

function comment-run-commandline --description 'Comment the current line, then run'
   set -l cmdlines (commandline)
   commandline -r (printf '%s\n' '#'$cmdlines)
   commandline -f execute
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
    bind \e\[3\;5~ kill-word
    bind \cH backward-kill-path-component
    bind \cU comment-run-commandline
end

function show_color 
    perl -e 'foreach $a(@ARGV){print "\e[48:2::".join(":",unpack("C*",pack("H*",$a)))."m \e[49m "};print "\n"' $argv
end

#function fuck -d 'Correct your previous console command'
#    set -l exit_code $status
#    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
#    set -l fucked_up_commandd $history[1]
#    thefuck $fucked_up_commandd > $eval_script
#    . $eval_script
#    rm $eval_script
#    if test $exit_code -ne 0
#        history --delete $fucked_up_commandd
#    end
#end


function makeDocsBackup
	 #Currently no 'Old', 'Wolfram Mathematica', or 'Backup' (of course)
	 #tar -cvzf ~/Documents/Backup/DocsBackup-(date -Idate).tar.gz ~/Documents/School ~/Documents/Projects ~/Documents/Programming/ ~/Documents/Assorted ~/Documents/Old ~/Documents/Recentia ~/Documents/Models
	 tar -cvf - ~/Documents/Notes ~/Documents/School ~/Documents/Projects ~/Documents/Programming/ ~/Documents/Assorted ~/Documents/Models ~/Documents/Old | pigz > ~/Documents/Backup/DocsBackup-(date -Idate).tar.gz #Parallelizes compression using pigz
end


function sendtopeachstone
  rsync -zlr --progress $argv[1] 192.168.0.184:\"$argv[2]\"
end


function protontricks-flat
  flatpak run --command=protontricks com.valvesoftware.Steam --no-runtime $argv
end


function tlog
  if [ -z "$argv" ]
    cat ~/Notes/techlog.txt
  else
    echo \[(hostname) \| (date)\] $argv >> ~/Notes/techlog.txt
  end
end

function meeting_notes
  nv ~/Notes/joby/meetings/$argv"_"(date +"%Y-%m-%d %H.%M.%S").txt
end

# a security thing
alias sudo='sudo'

# Save history without deduplication
function savehist --on-event fish_preexec
    echo (hostname)'|'(date)'|'(echo $argv | string collect)'|'>> ~/Notes/cmd_history
end

#Settings for color output in man pages
set -x LESS_TERMCAP_mb (printf "\033[01;31m")  
set -x LESS_TERMCAP_md (printf "\033[01;31m")  
set -x LESS_TERMCAP_me (printf "\033[0m")  
set -x LESS_TERMCAP_se (printf "\033[0m")  
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")  
set -x LESS_TERMCAP_ue (printf "\033[0m")  
set -x LESS_TERMCAP_us (printf "\033[01;32m")  

set -gx EDITOR nvim
set -gx RIPGREP_CONFIG_PATH ~/.dotfiles/ripgreprc

set -x PATH $PATH ~/.local/bin ~/.cabal /usr/local/cuda/bin /opt/microchip/xc16/v1.41/bin ~/Install/STM32CubeProgrammer/bin /usr/lib/ccache ~/go/bin ~/.cargo/bin /opt/Xilinx/SDK/2018.1/bin 
# set -x PATH $PATH  ~/Projects/ecp5/ecp5-toolchain-linux_x86_64-v1.6.9/bin
set -x PATH $PATH ~/Projects/ecp5/litex/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin/

set -x DOTNET_CLI_TELEMETRY_OPTOUT 1

# In Python 3.7+, have breakpoint() trigger ipdb instead of pdb
set -x PYTHONBREAKPOINT ipdb.set_trace


# source ~/ros_catkin_ws/install_isolated/share/rosbash/rosfish
# bass source ~/catkin_ws/devel/setup.bash
# source ~/.cargo/env

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '~/Install/google-cloud-sdk/google-cloud-sdk/path.fish.inc' ]; . '~/Install/google-cloud-sdk/google-cloud-sdk/path.fish.inc'; end
