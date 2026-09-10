# Configuração modular do Bash

Este repositório reúne uma configuração pessoal de Bash dividida em arquivos pequenos. A ideia é manter os ajustes fora do `~/.bashrc` principal e facilitar a manutenção: cada assunto fica no seu próprio arquivo.

Use como referência e adapte antes de copiar. Caminhos, nomes de servidores, editor padrão, ferramentas instaladas e preferências de prompt são pessoais. Rodar tudo sem revisar pode sobrescrever variáveis, aliases ou o prompt que você já usa.

## Como usar

Clone ou copie este diretório para um local permanente e acrescente a linha abaixo ao final do seu `~/.bashrc`:

```bash
source /caminho/para/Bash/bashrc
```

Depois, abra um novo terminal ou recarregue a configuração atual:

```bash
source ~/.bashrc
```

O arquivo `bashrc` deste projeto só atua em sessões interativas do Bash. Assim, scripts executados por Bash não recebem aliases, prompt e inicializações que não fazem sentido fora do terminal.

## Como a estrutura funciona

O arquivo de entrada é `bashrc`, na raiz do projeto. Ele descobre o próprio diretório e carrega todos os arquivos `*.sh` dentro de `bashrc.d/` em ordem alfabética. Por isso os nomes começam com números: `10-...` roda antes de `15-...`, que roda antes de `20-...`, e assim por diante.

```text
bashrc
└── bashrc.d/
    ├── 10-system.sh
    ├── 15-environment.sh
    ├── 20-projects.sh
    ├── 25-path.sh
    ├── 30-aliases.sh
    ├── 35-git.sh
    ├── 40-functions.sh
    ├── 45-completions.sh
    ├── 50-prompt.sh
    ├── 55-tools.sh
    └── 95-local.sh
```

Arquivos ausentes, não legíveis ou ferramentas que não estiverem instaladas são ignorados quando possível. Isso permite usar a mesma base em computadores diferentes sem travar a abertura do terminal.

> Os nomes `bashrc` e `bashrc.d` não têm ponto de propósito. Eles são exemplos versionáveis; quem decide se o carregamento fará parte do `~/.bashrc` é a linha `source` adicionada por você.

## Arquivos e camadas

### `bashrc`

É o carregador principal. Confere se o shell é Bash e interativo, localiza a pasta `bashrc.d` e executa seus arquivos `.sh` na sequência numérica. Não edite esse arquivo para colocar aliases do dia a dia; prefira a camada correspondente.

### `10-system.sh`

Guarda integrações ligadas ao sistema. Hoje ele configura o Homebrew para Linux quando o executável existe em `/home/linuxbrew/.linuxbrew/bin/brew`. Se o Homebrew estiver em outro lugar, ajuste esse caminho. Se você não usa Homebrew, o arquivo pode ficar como está: ele não faz nada nesse caso.

### `15-environment.sh`

Define variáveis de ambiente com valores-padrão, sem atropelar valores que já vieram do sistema ou do seu terminal:

- `EDITOR` e `VISUAL`: editor usado por programas como Git; o padrão é `vi`.
- `PAGER`: paginador padrão; o padrão é `less`.
- `LESS`: opções para o `less` (`-FRX`).
- `UV_TOOL_BIN_DIR`: diretório dos comandos instalados via `uv`; por padrão, `$HOME/.projetos/bin`.

Troque os valores aqui se quiser, por exemplo `export EDITOR=nvim`.

### `20-projects.sh`

Centraliza caminhos dos seus projetos:

- `PROJECTS_DIR` aponta para `$HOME/Projetos`.
- `FILES_DIR` aponta para `$HOME/Projetos/files`.

Também oferece o comando `cproj`, que entra em um projeto:

```bash
cproj              # entra em ~/Projetos
cproj meu-projeto  # entra em ~/Projetos/meu-projeto
```

Se o diretório informado não existir, o comando mostra uma mensagem e não muda de pasta.

### `25-path.sh`

Acrescenta diretórios pessoais ao `PATH`, sem duplicá-los. Com isso, executáveis em `$HOME/.myenv/bin`, `$HOME/.projetos/bin` e `$UV_TOOL_BIN_DIR` podem ser chamados pelo nome, sem informar o caminho completo. A ordem preserva os diretórios já existentes no `PATH` e adiciona os novos ao final.

### `30-aliases.sh`

Reúne atalhos para o terminal:

| Alias | Equivale a |
| --- | --- |
| `mkp pasta` | `mkdir -p pasta` |
| `lsa` | `ls -la` |
| `py` | `python3` |
| `ubuntu-server-01` | `ssh ubuntu-server-01` |
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `grep` | `grep --color=auto` |

O alias de SSH depende de existir uma entrada chamada `ubuntu-server-01` no seu `~/.ssh/config` ou de o seu DNS conhecer esse nome. Ajuste ou remova esse alias se ele não for seu.

### `35-git.sh`

Cria atalhos de Git somente se o comando `git` estiver instalado:

| Alias | Equivale a |
| --- | --- |
| `gs` | `git status --short --branch` |
| `gl` | `git log --oneline --decorate -10` |
| `gd` | `git diff` |

São atalhos de consulta; nenhum deles cria commit, envia alterações ou muda o repositório.

### `40-functions.sh`

Mantém funções que precisam receber argumentos:

- `mkcd <diretório>` cria a pasta, incluindo diretórios intermediários, e entra nela. Exemplo: `mkcd projetos/api`.
- `extract <arquivo>` extrai arquivos comuns, como `.tar.gz`, `.zip`, `.7z` e `.rar`. Exemplo: `extract backup.tar.gz`.

Alguns formatos dependem de programas externos, como `unzip`, `unrar` ou `7z`. Instale a ferramenta correspondente se o formato for aceito, mas o comando não estiver disponível na sua máquina.

### `45-completions.sh`

Tenta carregar o `bash-completion` nos caminhos mais comuns do Linux e do Homebrew. Quando ele estiver instalado, o terminal ganha autocompletar para vários comandos. O arquivo também permite completar nomes de diretório com `Tab` ao usar `mkcd` e `cproj`.

### `50-prompt.sh`

Monta o prompt do terminal. Ele mostra:

- o código de erro anterior, em vermelho, quando um comando falhar;
- usuário e máquina, em verde;
- diretório atual, em azul;
- ramificação Git atual, em amarelo, quando você estiver em um repositório;
- o símbolo `$` para usuário comum ou `#` para root.

Essa camada define `PROMPT_COMMAND`. Se você já usa uma função nessa variável para outro fim, una as duas configurações ou mantenha seu próprio prompt em `95-local.sh`.

### `55-tools.sh`

Inicializa o `fnm` (Fast Node Manager), se ele estiver instalado. A opção `--use-on-cd` faz o `fnm` trocar automaticamente a versão do Node ao entrar em diretórios que tenham configuração compatível, como um arquivo `.node-version`.

### `95-local.sh`

É o lugar para ajustes exclusivos do computador atual. Ele roda por último e pode sobrescrever variáveis, aliases ou opções anteriores. Um exemplo:

```bash
export API_URL='http://localhost:3000'
alias trabalho='cd ~/Projetos/cliente'
```

Evite compartilhar segredos nesse arquivo. Se ele for usado para tokens, senhas ou URLs privadas, mantenha-o fora do Git ou adicione-o ao `.gitignore`.

## Adicionando uma camada nova

Crie um arquivo com número e nome claro dentro de `bashrc.d`. Por exemplo, para configurações de Docker:

```bash
# bashrc.d/60-docker.sh
alias dc='docker compose'
```

Ao abrir um novo terminal, `60-docker.sh` será carregado depois de `55-tools.sh` e antes de `95-local.sh`. Use intervalos numéricos para encaixar novas etapas sem precisar renomear os arquivos existentes.

## Teste rápido

Para conferir se os arquivos têm sintaxe Bash válida sem abrir um shell novo, execute na raiz do projeto:

```bash
bash -n bashrc bashrc.d/*.sh
```

Para testar o carregamento em um terminal interativo, use:

```bash
bash --noprofile --norc -i
source /caminho/para/Bash/bashrc
```

Use `type cproj`, `type mkcd`, `alias gs` ou `echo "$PATH"` para confirmar que a parte esperada foi carregada.

Configurações pessoais básicas do bash para meu ambiente Linux. Recomenda-se cautela ao reproduzir o conteúdo deste repositório.
