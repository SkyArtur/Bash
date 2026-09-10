# Prompt compacto: código de saída, usuário, diretório e ramificação Git atual.
_bashrc_git_branch() {
    local branch
    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || return 0
    printf ' (%s)' "$branch"
}

_bashrc_prompt_command() {
    local status=$?
    local status_part=''
    (( status == 0 )) || status_part="\\[\\e[31m\\][$status] "
    PS1="${status_part}\\[\\e[1;32m\\]\\u@\\h\\[\\e[0m\\]:\\[\\e[1;34m\\]\\w\\[\\e[0m\\]\\[\\e[33m\\]\\$(_bashrc_git_branch)\\[\\e[0m\\]\\$ "
}

PROMPT_COMMAND=_bashrc_prompt_command
