setopt NULL_GLOB

export EDITOR=vim

export PATH=$PATH:$ZSH_CUSTOM/bin

if command -v "thefuck" >/dev/null 2>&1 ; then
	eval $(thefuck --alias)
	eval $(thefuck --alias FUCK)
fi
