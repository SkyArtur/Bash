# Atalhos só são definidos quando o Git está disponível.
if command -v git >/dev/null 2>&1; then
    alias gs='git status --short --branch'
    alias gl='git log --oneline --decorate -10'
    alias gd='git diff'
fi
