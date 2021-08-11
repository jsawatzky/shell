alias refresh-shell="source ~/.zshrc"
alias zsh-config='$EDITOR ~/.zshrc'

alias grep="egrep"
alias ping="ping -c 5"

alias gs="git status -suall"

alias hg="history | grep"
alias alg="alias | grep"

mdcd() {
    mkdir -p $1
    cd $1
}
