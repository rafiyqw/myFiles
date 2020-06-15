# enable mouse
set -g mouse on

# improve colors
set -g default-terminal 'screen-256color'

# set scrollback buffer to 500
set -g history-limit 500

# make window/pane index start with 1
set -g base-index 1
setw -g pane-base-index 1

# status bar
set -g status-bg colour234
set -g status-fg colour205

set -g status-left ' #[fg=colour250]#S '
setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
setw -g window-status-format ' #I#[fg=colour236]:#[fg=colour250]#W#[fg=colour244]#F '

set -g status-right '#[fg=colour233,bg=colour241,bold] %a %d %b #[fg=colour233,bg=colour245,bold] %I:%M %P '

# pane
set -g pane-active-border-style fg=colour205

#set -g status-left-length 20
#setw -g mode-keys vi