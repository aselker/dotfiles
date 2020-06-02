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

# Safety!
alias cp "cp -i"
alias mv "mv -i"

abbr -a l "ls"
abbr -a s "ls"
abbr -a c "cd"
abbr -a b "cd .."

function xterm
	 command xterm -bg black -fg white
end

function ev --wraps=evince
	evince $argv 2>/dev/null & disown
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


function tlog
  if [ -z "$argv" ]
    cat ~/Notes/techlog.txt
  else
    echo $argv >> ~/Notes/techlog.txt
  end
end

# It's a security thing
alias sudo='sudo'

alias cmaker='python3 ~/Joby/Joby/Tools/blue_sky/cmaker.py'
alias udpflash='~/Joby/Joby/Tools/udp_image_loader/udp_image_loader_linux_exe'
alias runpyenv='python3 ~/Joby/Joby/Tools/runpyenv.py'



#Settings for color output in man pages
set -x LESS_TERMCAP_mb (printf "\033[01;31m")  
set -x LESS_TERMCAP_md (printf "\033[01;31m")  
set -x LESS_TERMCAP_me (printf "\033[0m")  
set -x LESS_TERMCAP_se (printf "\033[0m")  
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")  
set -x LESS_TERMCAP_ue (printf "\033[0m")  
set -x LESS_TERMCAP_us (printf "\033[01;32m")  

set -gx EDITOR nvim

set -x PATH ~/.local/bin ~/.cabal /usr/local/cuda/bin /opt/microchip/xc16/v1.41/bin ~/Install/STM32CubeProgrammer/bin $PATH 
set -x PATH ~/go/bin ~/.cargo/bin /opt/Xilinx/SDK/2018.1/bin $PATH

# source ~/ros_catkin_ws/install_isolated/share/rosbash/rosfish
# bass source ~/catkin_ws/devel/setup.bash
source ~/.cargo/env

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '~/Install/google-cloud-sdk/google-cloud-sdk/path.fish.inc' ]; . '~/Install/google-cloud-sdk/google-cloud-sdk/path.fish.inc'; end
