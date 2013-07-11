if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH=~/bin:$PATH:~/opensource/redis-2.6.14
export EDITOR=subl

# Aliases!!
alias subl='open -a "Sublime Text 2"'
alias ..='cd ..'
alias ls="ls -lsa"
alias start_pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias stop_pg="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias start_redis="redis-server /usr/local/etc/redis.conf"
alias res="touch tmp/restart.txt"
alias start_mysql='mysql.server start'
alias stop_mysql='mysql.server stop'
alias start_es='elasticsearch -f -D es.config=/usr/local/Cellar/elasticsearch/0.19.9/config/elasticsearch.yml'
alias fordev='foreman start -f Procfile.dev'
alias rake='bundle exec rake'
alias sidekiq='bundle exec sidekiq'
alias guard='bundle exec guard'
alias dropbox="cd ~/Dropbox"
alias redis="nohup ~/opensource/redis-2.6.14/src/redis-server /usr/local/etc/redis.conf > /tmp/redis.out 2> /tmp/redis.err < /dev/null &"
source ~/.local/bin/bashmarks.sh

# Taken from https://gist.github.com/1688857
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

# git
alias gst='git status' # Warning: gst conflicts with gnu-smalltalk (when used).
alias gb='git branch'
alias gco='git checkout'
alias gcob='git checkout -b '
alias ga='git add '
alias gc='git commit'
alias gg='git grep ' #  A great very FAST search option, easier then `find`


RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

function parse_git_branch {
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"

  state="${GREEN}"

  if [[ ! ${git_status} =~ "working directory clean" ]]; then
    state="${RED}"
  fi

  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " ${state}(${branch})"
  fi
}

function prompt_func() {
  git rev-parse --git-dir &> /dev/null
  previous_return_value=$?
  prompt="\u:\w${state}$(parse_git_branch)${COLOR_NONE} "
  if [[ $previous_return_value == 0 ]]; then
    PS1="${prompt}$ "
  else
    PS1=$PS1_DEFAULT
  fi
}
PS1_DEFAULT=$PS1
PROMPT_COMMAND=prompt_func