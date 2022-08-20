# dotfiles

## ★Recipe★

### 1. Create ~/.gitconfig_local

> ex)　~/.gitconfig_local

  <pre>
    [user]
        name = gitUser
        email = dotfiles@gmail.com
  </pre>

### 2. Clone dotfiles.git

```bash
$ git clone git@github.com:yyoshiki41/dotfiles.git
```

### 3. Run the `make` command

```bash
$ cd dotfiles
$ make init
```

## Appendix

### ■ For vim-latex

_Load .vimrc.tex_

```bash
" For vim-latex
if filereadable(expand('~/dotfiles/home/tex/.vimrc.tex'))
  source ~/dotfiles/home/tex/.vimrc.tex
endif
```
