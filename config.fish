# General-purpose functions
# (in fish, functions are like aliases)

#function l
  #ls $argv
#end

#function s
  #ls $argv
#end

#function c
	#cd $argv
#end

#function b
	#cd ..
#end	

function --wraps=mkdir mkcd
	mkdir -p $argv; and cd $argv
end

function --wraps=cd cl
  cd $argv; and ls
end

function --wraps=rg pg
	ps -ef | rg $argv
end

alias nv="nvim" # So flag completion is better
alias rgp="rg -p --no-heading " # ripgrep for piping

abbr -a l "ls"
abbr -a s "ls"
abbr -a c "cd"
abbr -a b "cd .."


function ev --wraps=evince
	evince $argv 2>/dev/null & disown
end

function tlog
  if [ -z "$argv" ]
    cat ~/Documents/Notes/techlog.txt
  else
    echo $argv >> ~/Documents/Notes/techlog.txt
  end
end

# It's a security thing
alias sudo='sudo'

alias cmaker='python3 ~/Joby/Joby/Tools/blue_sky/cmaker.py'
alias runpyenv='python3 ~/Joby/Joby/Tools/runpyenv.py'
alias udpflash='~/Joby/Joby/Tools/udp_image_loader/udp_image_loader_linux_exe'


set -gx EDITOR nvim
set -x PATH ~/.local/bin ~/go/bin ~/.cargo/bin /opt/Xilinx/SDK/2018.1/bin $PATH
