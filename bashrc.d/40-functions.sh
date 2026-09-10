mkcd() {
    if [[ -z ${1:-} ]]; then
        printf 'Uso: mkcd <diretório>\n' >&2
        return 2
    fi
    mkdir -p -- "$1" && cd -- "$1"
}


extract() {
    if [[ -z ${1:-} ]]; then
        printf 'Uso: extract <arquivo>\n' >&2
        return 2
    fi

    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar -xjf "$1"    ;;
            *.tar.gz)    tar -xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar -xf "$1"      ;;
            *.tbz2)      tar -xjf "$1"     ;;
            *.tgz)       tar -xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z -x "$1"        ;;
            *)           printf "'%s' não pode ser extraído por extract()\n" "$1" >&2 ;;
        esac
    else
        printf "'%s' não é um arquivo válido\n" "$1" >&2
        return 1
    fi
}
