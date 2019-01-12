fpath=("$HOME/.zsh/prompt" $fpath)
autoload -Uz async
autoload -U promptinit
async
promptinit


SPACESHIP_PROMPT_ORDER=(
  dir
  git_branch
  git_status
#  kubecontext
#  azure
  exec_time
  line_sep
  jobs
  char
)

SPACESHIP_RPROMPT_ORDER=(
  time
)

# time
SPACESHIP_TIME_FORMAT="%D{%L:%M}"
SPACESHIP_TIME_SHOW=true

# dir
SPACESHIP_DIR_PREFIX=''
SPACESHIP_DIR_TRUNC='5'
SPACESHIP_DIR_TRUNC_PREFIX=".../"
SPACESHIP_DIR_TRUNC_REPO=false

# git
SPACESHIP_GIT_BRANCH_PREFIX=""
#SPACESHIP_GIT_BRANCH_SUFFIX=""
#SPACESHIP_GIT_STATUS_PREFIX="["
#SPACESHIP_GIT_STATUS_SUFFIX="]"

# kubecontext
SPACESHIP_KUBECONTEXT_PREFIX=""
#SPACESHIP_KUBECONTEXT_SUFFIX=""
export SPACESHIP_KUBECONTEXT_COLOR_GROUPS=(
 red -prod-
)

# symbols
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_JOBS_SYMBOL="»"

prompt spaceship
