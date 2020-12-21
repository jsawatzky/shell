# oh-my-zsh options
ZSH_THEME="spaceship"
plugins=(git z zsh-syntax-highlighting zsh-autosuggestions docker)

# Theme options
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
SPACESHIP_PROMPT_ORDER=(
	# TODO
	#line_sep
	time
	user
	dir
	git
	char
)
SPACESHIP_RPROMPT_ORDER=(
	exit_code
	exec_time
)
SPACESHIP_TIME_PREFIX=""
SPACESHIP_TIME_SHOW=true
SPACESHIP_EXIT_CODE_SHOW=true

# Plugin options
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1