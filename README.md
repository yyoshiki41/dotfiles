dotfiles
========

## ★Recipe★
1, Make ~/.gitconfig_local  
  `$ vim ~/.gitconfig_local`
    
2, Clone dotfiles.git

3, Run the .sh File Shell Script  
  `$ sh ~/dotfiles/dotfilesLink.sh`  

### ■About gitconfig
*Edit gitUser's info*
> ex)　.gitconfig_local
  <pre>
    [user]
        name = gitUser
        email = dotfiles@gmail.com
  </pre>

### ■For vim-latex
*Load .vim.tex*
<pre>
" For vim-latex
if filereadable(expand('~/dotfiles/tex/.vimrc.tex'))
  source ~/dotfiles/.vimrc.tex
endif
</pre>