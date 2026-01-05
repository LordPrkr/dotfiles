# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    tmux
    volta
)
ZSH_TMUX_AUTOSTART=true

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"

# fzf config
export FZF_DEFAULT_OPTS='--tmux'
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

eval "$(starship init zsh)"

export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="/Users/parker/.local/bin:$PATH:${GOPATH}/bin:${GOROOT}/bin"
export EDITOR="nvim"

alias vim="nvim"
alias vi="nvim"
alias ls="eza"
alias cat="bat"
alias zshcfg="nvim ~/.zshrc"
alias sourcezsh="source ~/.zshrc"
alias starshipcfg="nvim ~/.config/starship.toml"
alias ghosttycfg="nvim ~/.config/ghostty/config"
alias tmuxcfg="nvim ~/.config/tmux/tmux.conf"
alias sourcetmux="tmux source ~/.config/tmux/tmux.conf"
alias dev="cd ~/dev"

[ -f "/Users/parker/.ghcup/env" ] && source "/Users/parker/.ghcup/env" # ghcup-env

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

nerdfetch
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH="/opt/homebrew/opt/ansible@9/bin:$PATH"

export GIT_ROOT="/Users/parlandon/git"
export GIT_APP_CORE="/Users/parlandon/git/app-core"
alias fdm="cd /Users/parlandon/git/web-app-ui/apps/legacy-react-app && GIT_ROOT=/Users/parlandon/git yarn devMode"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# AWS login function
function aws-login() {
    # Check if the profile name is provided
    if [ -z "$1" ]; then
        echo "Please provide the profile name."
        return 1
    fi
    # Log in to the AWS SSO profile
    aws sso login --profile $1
    # Extract the region from the config file
    region=$(aws configure get region --profile $1)
    # Export the variables as environment variables
    export AWS_REGION=$region
    export AWS_DEFAULT_REGION=$region
    export AWS_PROFILE=$1
}

alias aws-sso-ai-sandbox='aws-login prod-eng-ai-sandbox'

# Set up Claude Code to use Bedrock/AWS
function claude-bedrock() {
    export CLAUDE_CODE_USE_BEDROCK=1
    export AWS_PROFILE=prod-eng-ai-sandbox
    export AWS_REGION=us-west-2
    # Uncomment below if you want to DISABLE prompt caching
    # export DISABLE_PROMPT_CACHING=1
    # Pass all arguments directly to the claude command
    claude "$@"
}


function mr-summarize() {
    echo "Summarizing your MR with AI..."
    summary=$(echo "Use @agent-mr-reviewer agent to generate a MR summary. Provide the MR summary as your only output." | claude-bedrock --print --output-format json | jq -r '.result')
    echo "\n\nSummarization complete:\n\n$summary\n\n"
    reply=$(bash -c "read -n 1 -s -r -p \"Copy to clipboard? (y/n) \" key; echo \$key")
    if [[ $reply == "y" ]]; then
        echo "$summary" | pbcopy
        echo "\nSummary copied to clipboard!"
    else
        echo "\nSummary not copied."
    fi
}

# Added by Ultimate Bug Scanner Installer
alias bash='/opt/homebrew/bin/bash'
