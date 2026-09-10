# Integrações com o sistema devem ser opcionais: esta configuração também pode
# ser usada em máquinas que não possuem o Homebrew instalado.
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
fi
