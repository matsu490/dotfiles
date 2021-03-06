#===============================================================================
# For Mac OS X in laboratory
#===============================================================================
case ${OSTYPE} in
    darwin*)
#*********************************************************************
# Path and aliases
#*********************************************************************
        if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
          alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
          alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
        fi
        export PATH="/usr/local/bin:$PATH"
        export PATH="/usr/local/Cellar:$PATH"
        export PYTHONPATH="/usr/local/lib/wxPython/lib/python2.7/site-packages/wx-3.0-osx_cocoa:/usr/local/lib/wxPython/lib/python2.7/site-packages:$PYTHONPATH"
        export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/1.7.0"
        eval $(/usr/local/bin/gdircolors /Users/matsu/Downloads/dircolors-solarized-master/dircolors.ansi-universal)
        alias ls='gls -al --color=auto'
        alias -s py='python'
        alias -s html='google-chrome'
        alias -s {gif,jpg,jpeg,png,bmp}='display'

#*********************************************************************
# VCS settings
#*********************************************************************
        # see http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
        autoload -Uz vcs_info
        setopt prompt_subst
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
        zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
        zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
        zstyle ':vcs_info:*' actionformats '[%b|%a]'
        precmd () { vcs_info }
        RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

#*********************************************************************
# TMUX functions
#*********************************************************************
        function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
        function is_osx() { [[ $OSTYPE == darwin* ]]; }
        function is_screen_running() { [ ! -z "$STY" ]; }
        function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
        function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
        function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
        function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

        function tmux_automatically_attach_session()
        {
            if is_screen_or_tmux_running; then
                ! is_exists 'tmux' && return 1

                if is_tmux_runnning; then
                    echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
                    echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
                    echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
                    echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
                    echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
                elif is_screen_running; then
                    echo "This is on screen."
                fi
            else
                if shell_has_started_interactively && ! is_ssh_running; then
                    if ! is_exists 'tmux'; then
                        echo 'Error: tmux command not found' 2>&1
                        return 1
                    fi

                    if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                        # detached session exists
                        tmux list-sessions
                        echo -n "Tmux: attach? (y/N/num) "
                        read
                        if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                            tmux attach-session
                            if [ $? -eq 0 ]; then
                                echo "$(tmux -V) attached session"
                                return 0
                            fi
                        elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                            tmux attach -t "$REPLY"
                            if [ $? -eq 0 ]; then
                                echo "$(tmux -V) attached session"
                                return 0
                            fi
                        fi
                    fi

                    if is_osx && is_exists 'reattach-to-user-namespace'; then
                        # on OS X force tmux's default command
                        # to spawn a shell in the user's namespace
                        tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                        tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
                    else
                        tmux new-session && echo "tmux created new session"
                    fi
                fi
            fi
        }
        tmux_automatically_attach_session
        ;;
#===============================================================================
# For Unix
#===============================================================================
    linux-gnu)
#*********************************************************************
# Path and aliases
#*********************************************************************
        alias ls='ls -al'

#*********************************************************************
# TMUX functions
#*********************************************************************
        function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
        function is_osx() { [[ $OSTYPE == darwin* ]]; }
        function is_screen_running() { [ ! -z "$STY" ]; }
        function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
        function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
        function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
        function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

        function tmux_automatically_attach_session()
        {
            if is_screen_or_tmux_running; then
                ! is_exists 'tmux' && return 1

                if is_tmux_runnning; then
                    echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
                    echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
                    echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
                    echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
                    echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
                elif is_screen_running; then
                    echo "This is on screen."
                fi
            else
                if shell_has_started_interactively && ! is_ssh_running; then
                    if ! is_exists 'tmux'; then
                        echo 'Error: tmux command not found' 2>&1
                        return 1
                    fi

                    if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                        # detached session exists
                        tmux list-sessions
                        echo -n "Tmux: attach? (y/N/num) "
                        read
                        if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                            tmux attach-session
                            if [ $? -eq 0 ]; then
                                echo "$(tmux -V) attached session"
                                return 0
                            fi
                        elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                            tmux attach -t "$REPLY"
                            if [ $? -eq 0 ]; then
                                echo "$(tmux -V) attached session"
                                return 0
                            fi
                        fi
                    fi

                    if is_osx && is_exists 'reattach-to-user-namespace'; then
                        # on OS X force tmux's default command
                        # to spawn a shell in the user's namespace
                        tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                        tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
                    else
                        tmux new-session && echo "tmux created new session"
                    fi
                fi
            fi
        }
        tmux_automatically_attach_session
        ;;
esac
