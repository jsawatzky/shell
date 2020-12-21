#!/bin/sh

export ZSH=${ZSH:-$HOME/.oh-my-zsh}
export ZSH_CUSTOM=$HOME/.jacob-zsh-custom

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

error() {
	echo ${RED}"Error: $@"${RESET} >&2
}

setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

clone_repo() {
	umask g-w,o-w

	echo "${BLUE}Cloning jsawatzky/shell...${RESET}"

	if [ "$OSTYPE" = cygwin ] && git --version | grep -q msysgit; then
		fmt_error "Windows/MSYS Git is not supported on Cygwin"
		fmt_error "Make sure the Cygwin git package is installed and is first on the \$PATH"
		exit 1
	fi

	git clone -c core.eol=lf -c core.autocrlf=false \
	  -c fsck.zeroPaddedFilemode=ignore \
	  -c fetch.fsck.zeroPaddedFilemode=ignore \
	  -c receive.fsck.zeroPaddedFilemode=ignore \
	  --depth=1 --recurse-submodules \
	  "https://github.com/jsawatzky/shell.git" "$ZSH_CUSTOM" || {
		error "git clone of shell repo failed"
		exit 1
	}

	echo
}

intall_powerline() {
	echo "${BLUE}Installing powerline fonts...${RESET}"
	git clone https://github.com/powerline/fonts.git --depth=1 || {
		error "Failed to clone powerline fonts"
		exit 1
	}
	cd fonts
	./install.sh || {
		error "Failed to install powerline fonts"
		exit 1
	}
	cd ..
	rm -rf fonts
	echo "${GREEN}Powerline fonts has been installed${RESET}"
	echo
}

install_oh_my_zsh() {
	if [ -d "$ZSH" ]; then
		cat <<-EOF
			${YELLOW}It looks like you already have Oh My Zsh installed.
			Skipping this step.${RESET}
		EOF
		return
	fi

	echo "${BLUE}Installing Oh My Zsh...${RESET}"

	RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	echo "${GREEN}Oh My Zsh has been installed${RESET}"
	echo
}

setup_zshrc() {
	echo "${BLUE}Setting up .zshrc file...${RESET}"
	
	if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
		echo "${YELLOW}Found ~/.zshrc.${RESET} ${GREEN}Backing up to ~/.zshrc.pre-jacob${RESET}"
		mv ~/.zshrc ~/.zshrc.pre-jacob
	fi

	if command_exists envsubst ; then
		envsubst < ~/.jacob-zsh-custom/zshrc.template > ~/.zshrc
	else
		cp /.jacob-zsh-custom/zshrc.template ~/.zshrc
	fi
}

main() {

	setup_color

	command_exists zsh || {
		echo "${YELLOW}zsh is not installed.${RESET} Please install zsh first."
		exit 1
	}

	command_exists git || {
		error "git is not installed"
		exit 1
	}

	clone_repo
	intall_powerline
	~/.jacob-zsh-custom/themes/setup_themes.sh
	~/.jacob-zsh-custom/plugins/setup_plugins.sh
	setup_zshrc

	printf "$GREEN"
	cat <<-'EOF'
		Shell has been setup! Launching ZSH

	EOF
	printf "$RESET"

	exec zsh -l

}

main "$@"
