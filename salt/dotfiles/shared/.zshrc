export TERM="xterm-256color"

source $HOME/.connect-ssh-agent
source $HOME/src/github.com/zsh-users/antigen/antigen.zsh

# Note: you can use the "cat" command to determine what various keystrokes get
# converted to magical computer codes.

# This binds Alt-left/right to move the cursor backward/forward one word.
# To find out what these magical commands are, run one of the following (they
# each work on different systems):
#   cat
#   sed -n l
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load standard plugins.
antigen bundle brew
antigen bundle dircycle
antigen bundle docker
antigen bundle encode64
antigen bundle git
antigen bundle python
antigen bundle vagrant

# Load plugins from github.
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme bhilburn/powerlevel9k powerlevel9k

# Miscellaneous theme settings.
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$ "

# Use this command to see lots of colors and their codes:
# for code ({0..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
# There's also this: https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg

# Set left prompt colors.
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="000"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="015"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="000"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_BACKGROUND="000"
POWERLEVEL9K_DIR_HOME_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="000"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="007"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="000"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="045"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='000'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='045'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='000'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='045'

# Set right prompt colors.
POWERLEVEL9K_PYENV_FOREGROUND='007'
POWERLEVEL9K_PYENV_BACKGROUND='000'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='007'
POWERLEVEL9K_VIRTUALENV_BACKGROUND='000'
POWERLEVEL9K_TIME_FOREGROUND='007'
POWERLEVEL9K_TIME_BACKGROUND='000'
POWERLEVEL9K_STATUS_OK_BACKGROUND='000'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='000'

# Set up prompts.
POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs pyenv virtualenv time)

# Don't show the VCS info on vagrant boxes, due to performance issues that can
# be caused by mounted git repos.
if [[ "${USER}" == vagrant ]]; then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv)
fi

# Miscellaneous zsh settings.
DISABLE_AUTO_TITLE="true"

# PoC screenshot settings. This makes the left prompt extremely simple for the
# purpose of screenshotting the terminal. Uncomment these to use the
# settings. They will overwrite settings above.
# POWERLEVEL9K_PROMPT_ON_NEWLINE=false
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\n$"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=()

# Tell Antigen that you're done.
antigen apply

# Disable glob highlighting.
ZSH_HIGHLIGHT_STYLES[globbing]='none'

# Disable adding a percent sign after printing to standard out without a
# trailing newline.
PROMPT_EOL_MARK=""

# Load external files.
source $HOME/.aliases
source $HOME/.exports
source $HOME/.functions

# Source any private settings not tracked in this repo.
if [ -f ~/.private ]; then
   source ~/.private
fi

# Set up virtualenv.
source $HOME/.venv_setup

# Set up Google Cloud SDK.
if [ -f "$HOME/bin/google-cloud-sdk/path.zsh.inc" ]; then
    . "$HOME/bin/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/bin/google-cloud-sdk/completion.zsh.inc" ]; then
    . "$HOME/bin/google-cloud-sdk/completion.zsh.inc"
fi
