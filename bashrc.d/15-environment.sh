# Preferências de ambiente. Os valores já definidos pelo usuário têm prioridade.
export EDITOR="${EDITOR:-vi}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"
export LESS="${LESS:--FRX}"

# Ferramentas instaladas com uv neste diretório ficam disponíveis após 25-path.sh.
export UV_TOOL_BIN_DIR="${UV_TOOL_BIN_DIR:-$HOME/.projetos/bin}"
