# Adiciona diretórios ao PATH somente uma vez. Eles podem ainda não existir;
# assim, um programa instalado mais tarde já estará disponível no próximo shell.
_bashrc_add_path() {
    local directory
    for directory in "$@"; do
        case ":$PATH:" in
            *":$directory:"*) ;;
            *) PATH="$PATH:$directory" ;;
        esac
    done
}

_bashrc_add_path "$HOME/.myenv/bin" "$HOME/.projetos/bin" "$UV_TOOL_BIN_DIR"
export PATH
unset -f _bashrc_add_path
