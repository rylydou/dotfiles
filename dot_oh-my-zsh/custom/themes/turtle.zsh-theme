PROMPT='
'
PROMPT+='%B%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%n@%m %{$fg_bold[cyan]%}%~ $(git_prompt_info) %{$fg_white%}%t %{$reset_color%}
%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[magenta]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%}↑%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[magenta]%}↓%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg_bold[magenta]%}↕%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg_bold[magenta]%}$%{$fg[green]%}"
