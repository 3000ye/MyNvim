"################################## 插件管理 ##################################
" 关闭文件类型自动检测功能,这个功能被filetype plugin indent on代替          
filetype off 

"设置vim-plug路径
call plug#begin('~/.vim/plugged')

"terminal下输入nvim,你将看到一个酷酷的启动界面
Plug 'mhinz/vim-startify'



Plug 'arcticicestudio/nord-vim'



"vim-airline 底部状态栏优化
Plug 'bling/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"let g:airline_theme = 'nord' " 设置airline使用的主题
"let g:airline_powerline_fonts = 1 " 使airline正常显示箭头

" 设置 neovim 或者 vim 的 tabline
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1


"*************代码补全******************

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 " 激活rainbow


"*************效率工具*******************
"vim-autopep8,自动格式化
Plug 'tell-k/vim-autopep8'



"自动引号/括号
Plug 'jiangmiao/auto-pairs'


"*************其他工具******************
"nerdtree 文件树

Plug 'scrooloose/nerdtree'





"#################################自动补全################
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}




"##############################wakatime###############
Plug 'wakatime/vim-wakatime'




call plug#end()


"#############自动保存#########
au InsertLeave * write

"###########################################
"set background=dark
colorscheme nord
let g:nord_cursor_line_number_background = 1
let g:nord_bold_vertical_split_line = 1


"####################################coc
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"##################################按键设置##################################

" F3 开启关闭文件树
nnoremap <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" F6自动格式化
autocmd FileType python noremap <buffer> <F6> :call Autopep8()<CR>

" ctrl-j/k/l/h  分屏窗口移动 Normal mode
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" F5 自动编译文件 Normal+Visual mode
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "!clear":
                exec "!time python3 %"
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'go'
                " exec "!go build %<"
                exec "!time go run %"
        elseif &filetype == 'mkd'
                exec "!~/.vim/markdown.pl % > %.html &"
                exec "!firefox %.html &"
        endif
endfunc


"##################################插件设置##################################

" *********** NERDTree插件配置 ***********
" 默认打开NERDTree
let NERDTreeChDirMode=2                                         " 设置当前目录为nerdtree的起始目录
let NERDChristmasTree=1                                         " 使得窗口有更好看的效果
let NERDTreeMouseMode=1                                         " 双击鼠标左键打开文件
let NERDTreeWinSize=25                                          " 设置窗口宽度为25
let NERDTreeQuitOnOpen=1                                        " 打开一个文件时nerdtree分栏自动关闭
" 打开文件默认开启文件树
"autocmd VimEnter * NERDTree


"#################################vim设置##################################
"************常规设置****************
"设置历史操作记录为1000条
set history=1000  
" 不启用vi的键盘模式,而是vim自己的
set nocompatible
" 语法高亮支持
syntax on
" 载入文件类型插件,代替filetype off 
filetype plugin indent on

"************搜索设置***************
" 搜索的时候不区分大小写,是set ignorecase缩写.如果你想启用,输入:set noic(noignorecase缩写)
set ic
" 搜索的时候随字符高亮
set hlsearch


"************编码设置***************
" 设置编码格式为utf-8
set encoding=utf-8
" 自动判断编码时,依次尝试下编码
set fileencodings=utf-8,ucs-bom,GB2312,big5

"************行和列设置***************
" 显示行横线
set cursorline
" 显示行号
set nu

"************缩进设置***************
" 自动套用上一行的缩进方式
set autoindent
" 开智能缩进
set smartindent
" 光标移动到buffer的顶部和底部保持4行继续
set scrolloff=4
" 当光标移动到一个括号时,高亮显示对应的另一个括号
set showmatch

" 对退格键提供更好帮助
set backspace=indent,eol,start   
"自动保存
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHoldI", "CompleteDone"]

"------------------- python 文件设置--------------------
" 开启语法高亮
let python_highlight_all=1
" 设定tab的格数为4
au Filetype python set tabstop=4
" 设置编辑模式下tab的宽度
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99







" 插入模式下,光标变成细线
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif









" ####################################定义SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
	if &filetype == ‘sh‘
         call setline(1,"\#########################################################################")

        call append(("."), "\# File Name: ".("%"))

         call append(line(".")+1, "\# Author: Stilesyu")

         call append(line(".")+2, "\# mail: yuxiaochen886@gmail.com")

     
    "call append((".")+3, "\# Created Time: ".strftime("%c"))
         call append(line(".")+3, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))

         call append(line(".")+4, "\#########################################################################")

         call append(line(".")+5, "\#!/bin/bash")

         call append(line(".")+6, "")

     else

        call setline(1, "/*************************************************************************")

        call append(line("."), "    > File Name: ".("%"))

        call append(line(".")+1, "    > Author: YourName")

        call append(line(".")+2, "    > Mail: YourEmail ")

       " 同样的 改变时间格式
        "call append((".")+3, "    > Created Time: ".strftime("%c"))
        call append((".")+3, "    > Created Time: ".strftime("%Y-%m-%d",localtime()))

        call append((".")+4, " ************************************************************************/")

        call append(line(".")+5, "")

     endif

     if &filetype == ‘‘

        call append(line(".")+6, "#include<iostream>")

         call append(line(".")+7, "using namespace std;")

        call append(line(".")+8, "")

    endif

    if &filetype == ‘c‘

         call append(line(".")+6, "#include<stdio.h>")

       call append(line(".")+7, "")

    endif
 
   "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
 endfunc

" Python自动插入文件标题
 autocmd BufNewFile *py exec ":call SetPythonTitle()"
 
 func SetPythonTitle()
  call setline(1,"#!/usr/bin/python3.8")
  call append(line("."), "\# Author: ye_3000")
  call append(line(".")+1, "\# Email: ye_3000@163.com")
  call append(line(".")+2, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))
 endfunc
 
 
"新建文件后，自动定位到文件末尾
 autocmd BufNewFile * normal G o
 
 "自动给文件添加可执行权限
 autocmd BufWritePost * silent !chmod +x <afile>

 "打开文件自动跳转最后一行
 autocmd BufEnter * normal G
