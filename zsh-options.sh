# oh-my-zsh options
ZSH_THEME="spaceship"
plugins=(git z zsh-syntax-highlighting zsh-autosuggestions docker)

# Theme options
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
SPACESHIP_PROMPT_ORDER=(
	venv
	golang
	node
	docker
	aws
	line_sep
	time
	#user
	host
	dir
	git
	battery
	char
)
SPACESHIP_RPROMPT_ORDER=(
	exit_code
	exec_time
)
SPACESHIP_PROMPT_DEFAULT_PREFIX="["
SPACESHIP_PROMPT_DEFAULT_SUFFIX="]"
SPACESHIP_VENV_SYMBOL="🐍 "
SPACESHIP_DOCKER_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
SPACESHIP_TIME_PREFIX=""
SPACESHIP_TIME_SUFFIX=" "
SPACESHIP_TIME_SHOW=true
SPACESHIP_USER_PREFIX="as "
SPACESHIP_USER_SUFFIX=" "
SPACESHIP_HOST_PREFIX="on "
SPACESHIP_HOST_SUFFIX=" "
SPACESHIP_DIR_SUFFIX=" "
SPACESHIP_GIT_SUFFIX=" "
SPACESHIP_BATTERY_SHOW="charged"
SPACESHIP_BATTERY_THRESHOLD="20"
SPACESHIP_BATTERY_PREFIX=""
SPACESHIP_BATTERY_SUFFIX=" "
SPACESHIP_EXEC_TIME_SUFFIX=""
SPACESHIP_EXIT_CODE_SHOW=true


# Plugin options
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1