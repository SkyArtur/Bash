# Arquivo de entrada para esta configuração modular.
# Use-o a partir do ~/.bashrc com:
#   source /caminho/para/Bash/bashrc

# Esta configuração usa recursos específicos do Bash.
[[ -n ${BASH_VERSION:-} ]] || return 0

# Não carregue aliases, prompt ou completions em shells não interativos.
[[ $- == *i* ]] || return 0

_bashrc_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)" || return 1
_bashrc_parts_dir="$_bashrc_dir/bashrc.d"

# Os prefixos numéricos definem a ordem. Arquivos ausentes ou não legíveis são
# ignorados, permitindo que esta árvore seja copiada entre máquinas.
if [[ -d $_bashrc_parts_dir ]]; then
    for _bashrc_part in "$_bashrc_parts_dir"/*.sh; do
        [[ -r $_bashrc_part && -f $_bashrc_part ]] || continue
        # shellcheck source=/dev/null
        source "$_bashrc_part"
    done
fi

unset _bashrc_dir _bashrc_parts_dir _bashrc_part
