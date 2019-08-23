" Colors
" https://groups.google.com/a/chromium.org/forum/#!topic/chromium-hterm/ncWSu-hV7r8
"
set t_ut=                " fix 256 colors in tmux http://sunaku.github.io/vim-256color-bce.html

if has("termguicolors")  " set true colors
  " Italics support 
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  " Undercurl support.
  " https://github.com/vim/vim/pull/2405
  " https://github.com/vim/vim/issues/819
  " https://groups.google.com/a/chromium.org/forum/#!topic/chromium-hterm/ncWSu-hV7r8
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
  set termguicolors
endif
