#!/bin/zsh
if [[ $(uname) = "Darwin" ]]; then

  # Set Variables
  export BROWSER=safari
  export EDITOR="nvim"

  # Set Path
  export PATH="$HOME/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/sbin"
  export PATH="$PATH:$HOME/node_modules/.bin"
  export PATH="$PATH:$HOME/go/bin"
  export PATH="$PATH:/Users/soleblaze/.gem/ruby/2.6.0/bin"
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

  # Set fpath for zsh-completion (homebrew package)
  fpath=(/opt/homebrew/share/zsh/site-functions /usr/local/share/zsh-completions $fpath)

  # Use neovim instead of vim
  alias vim="nvim"
  alias vi="nvim"

  # Use ctags installed via brew instead of xcode
  alias ctags="/usr/local/bin/ctags"

  # Disable homebrew git token request
  export HOMEBREW_NO_GITHUB_API=TRUE

fi
