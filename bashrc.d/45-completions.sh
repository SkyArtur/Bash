# Carrega bash-completion quando disponível, sem depender de um caminho fixo.
for _bashrc_completion in \
    /usr/share/bash-completion/bash_completion \
    /usr/local/share/bash-completion/bash_completion \
    "${HOMEBREW_PREFIX:-}/etc/profile.d/bash_completion.sh"; do
    [[ -r $_bashrc_completion ]] || continue
    # shellcheck source=/dev/null
    source "$_bashrc_completion"
    break
done
unset _bashrc_completion

# Completa nomes de diretórios para as funções desta configuração.
complete -d mkcd cproj 2>/dev/null || true
