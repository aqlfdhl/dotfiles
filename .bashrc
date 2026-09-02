#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ff='fastfetch'
alias zz='zsh'
PS1='\W \$ '
#PS1='[\u@\h \W]\$ '
export PATH=$PATH:/home/fadhil/.spicetify
