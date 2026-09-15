# Show user@host only on remote (SSH) sessions, otherwise a plain $
if [[ -n "$SSH_CONNECTION$SSH_CLIENT$SSH_TTY" ]]; then
  TURTLE_ID='%n@%m'
else
  TURTLE_ID='$'
fi

PROMPT='
'
PROMPT+='%B%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})'"$TURTLE_ID"' %{$fg_bold[white]%}%~$(git_prompt_info) %{%F{8}%}%t%{%f%}%b%{$reset_color%}
%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[magenta]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[magenta]%}*"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[magenta]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}»"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[magenta]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[magenta]%}?"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[magenta]%}\$"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[magenta]%}↓"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg_bold[magenta]%}↕"
