PROMPT='%{${fg_bold[cyan]}%}%n%{$reset_color%}%{${fg_bold[blue]}%}@%m%{$reset_color%}:%{$fg[green]%}%c%{$reset_color%} $(git_prompt_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )%{$fg[yellow]%}%#%{$reset_color%} '

RPROMPT='%{$fg[green]%}%~%{$reset_color%} %{$fg[yellow]%}[%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
