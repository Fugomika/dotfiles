# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.

### ---------------------------------------------
###  OS DETECTION
### ---------------------------------------------
IS_MAC=false
if [[ "$OSTYPE" == "darwin"* ]]; then
    IS_MAC=true
fi

### ---------------------------------------------
###  ALIASES
### ---------------------------------------------
alias lh="ls -lah"
alias hyprconf="nvim ~/.config/hypr/hyprland.conf"

alias waybarconf="nvim ~/.config/waybar/config"
alias relwaybar="killall waybar && waybar &"

alias grubconf="sudo nvim /etc/default/grub"
alias relgrub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias zshconfig="nvim ~/.zshrc"
alias relzsh="source ~/.zshrc"

alias air='~/go/bin/air'

if $IS_MAC && command -v brew >/dev/null 2>&1; then
    alias brewrefresh="brew update && brew upgrade && brew cleanup && brew autoremove"
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_FORCE_BOTTLES=1
fi

### ---------------------------------------------
###  PHP SWITCH (Only Mac w/ Homebrew)
### ---------------------------------------------
# if $IS_MAC && command -v brew >/dev/null 2>&1; then
# php-switch() {
#     local version=$1
#     if [ -z "$version" ]; then
#         echo "Usage: php-switch <version> (e.g. php-switch 7.4)"
#         return 1
#     fi

#     if brew list php@"$version" >/dev/null 2>&1; then
#         current_php=$(php -v | head -n1)
#         echo "Switching from $current_php to PHP $version..."

#         brew unlink php@$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
#         brew link php@"$version" --force --overwrite

#         php -v | head -n1
#     else
#         echo "Undefined: PHP $version is not installed via Homebrew."
#     fi
# }
# fi
#fuck homebrew im using macports

### ---------------------------------------------
###  TOOLS
### ---------------------------------------------
# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ZSH Plugins
plugin_paths=(
    "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for plugin in "${plugin_paths[@]}"; do
    if [ -f "$plugin" ]; then
        source "$plugin"
    else
        echo "⚠️ Plugin not found: $plugin"
    fi
done

# Starship
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
else
    echo "⚠️ Starship is not installed."
fi

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
else
    echo "⚠️ Zoxide is not installed."
fi

### ---------------------------------------------
###  PATH EXTENSIONS
### ---------------------------------------------
# if $IS_MAC; then
#     [ -d "/usr/local/opt/mysql@8.4/bin" ] && export PATH="/usr/local/opt/mysql@8.4/bin:$PATH"
#     [ -d "/usr/local/mysql/bin" ] && export PATH="/usr/local/mysql/bin:$PATH"
# fi