
set -g theme_color_scheme dracula
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '
set -g theme_project_dir_length 0

set -g fish_prompt_pwd_dir_length 0

set -U FZF_LEGACY_KEYBINDINGS 0

function attach_tmux_session_if_needed
    set ID (tmux list-sessions)
    if test -z "$ID"
        tmux new-session
        return
    end

    set new_session "Create New Session" 
    set ID (string join \n $new_session (tmux list-sessions) | fzf | cut -d: -f1)
    if test "$ID" = "$new_session"
        tmux new-session
    else if test -n "$ID"
        tmux attach-session -t "$ID"
    end
end

if test -z $TMUX && status --is-login
    attach_tmux_session_if_needed
end
set -U PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
if command -v pyenv 1>/dev/null 2>&1
    pyenv init - | source
end

set -U TMUX_YANK_PATH $HOME/.tmux-yank
