"let g:loaded_matchparen = 1
filetype plugin indent on
colorscheme wombat
set linespace=3
set fileencoding=utf8

au BufRead,BufNewFile *.less set ft=css

set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=b

if has("unix")
	"linux"
	set dir=/home/bart/vimtmp
	set guifont=Monospace\ 9
else
	set guifont=Consolas
	set dir=c:\\vimtmp
endif

set showcmd
set nonumber
syntax on
set hidden

set nocursorline
set nocursorcolumn

set tabstop=4
set shiftwidth=4
set ai

set backspace=indent,eol,start

set wrap
set linebreak
set incsearch
set ignorecase
set smartcase

"nnoremap ; :

"vimrc editing
if has("unix")
	nnoremap <F11> :tabnew ~/.vim/vimrc/_vimrc<CR>
else
	nnoremap <F11> :tabnew ~/vimfiles/vimrc/_vimrc<CR>
endif
"reload vimrc
nnoremap <F12> :source ~/.gvimrc<CR>


"my plugins
nnoremap <F1> :call HiTag()<CR>
nnoremap <F9> :call Bbuf2()<CR>

set hlsearch
set nolazyredraw

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>

nnoremap <F8> :noh<CR>:call clearmatches()<CR>

set laststatus=2
set statusline=%m\ %t\ [%{&l:fileformat}]\ %=%l/%L\ (%c)\ %P\ 

"paste from clipboard
inoremap <C-v> <C-r>*
nnoremap <C-v> "+p

"move character left/right
nnoremap <S-Right> xp
nnoremap <S-Left> xhhp

nnoremap <C-Down> :m+<CR>
nnoremap <C-Up> :m-2<CR>
inoremap <C-Down> <Esc>:m+<CR>gi
inoremap <C-Up> <Esc>:m-2<CR>gi
vnoremap <C-Down> :m'>+<CR>gv
vnoremap <C-Up> :m-2<CR>gv

"let mapleader = ","

"add/remove js comments
nnoremap <leader>cj _i//<Esc>
vnoremap <leader>ch c<!--<Esc>gpa--><Esc>

"close xml tags
inoremap <leader>/ </<C-x><C-o><Right>

"expand tag
inoremap <C-Space> <Left><C-o>viwc<<C-r>"></<C-r>"><Left><C-o>T>
"inoremap <S-Space> <Left><C-o>viwc<<C-r>"></<C-r>"><Left><C-o>T><CR><CR><Up>

"alt buffer
nnoremap <leader># :b#<CR>
nnoremap <C-k><C-k> :b#<CR>

"move by visual lines (when word wrapped)
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

"surround selection with common tags
vnoremap <C-p> c<p><C-o>gp</p><Esc>o<Esc>
vmap <C-b> S<strong>
inoremap <C-CR> <br />

"search/replace selected
vnoremap <leader>s y:%s/<C-r>0/

"<li> list
vnoremap <leader>li :s/\v(\s*)(.*)/\1<li>\2<\/li>/g<CR>:noh<CR>
vnoremap <leader>ul :s/\v(\s*)(.*)/\1<li>\2<\/li>/g<CR>:noh<CR>gvc<ul><Esc>pV']>']o</ul><Esc><<

set autochdir
set shellslash

"nnoremap <F5> :set ft=html<CR>
"nnoremap <F6> :set ft=php<CR>

nnoremap <leader>z zfat
nnoremap <leader>l _vg_
nnoremap vi_ F_lvf_h
nnoremap ci_ F_lvf_hc

nnoremap <leader>im :call Bimg()<CR>

"copy/paste to/from clipboard
nnoremap <leader>v ggVG
vnoremap <leader>y "+y

"some snippets
"nnoremap <leader>ks f>i style=""<Left> - PROBLEM if tag end in />

"- select <...> (va>)
"- substitute > or /> in visual selection (%V)
"- remove highlight and - place cursor inside quotes
command! -nargs=1 AddAttr :normal! va>:s/\%V>\|\%V \/>/ <args>&<CR>:noh<CR>gvf"<Esc>

nnoremap <leader>ks :AddAttr style=""<CR>a
nnoremap <leader>kc :AddAttr class=""<CR>a
nnoremap <leader>kw :AddAttr width=""<CR>a
nnoremap <leader>kb :AddAttr border="0"<CR>a

inoremap <leader>ki <img src="" border="0" alt="" /><Esc>F<f"a
inoremap <leader>kt <table cellpadding="0" cellspacing="0" border="0" width=""></table><C-O>7h<CR><CR><Up>
imap <leader>ktt <leader>kt tr<S-Space>td<S-Space>
vnoremap <leader>klm c<a href="mailto:<Esc>pa"><Esc>pa</a><Esc>
vnoremap <leader>kl c<a href="<Esc>pa"><Esc>pa</a><Esc>


"duplicate alt="" as a title=""
nnoremap <F7> :set nohls<CR>:s/alt="\(.\{-}\)"/& title="\1"/<CR>:let @/=""<CR>:set hls<CR>
"duplicate alt="" as a title="" FOR ALL IMGs without 'title'
nnoremap <F7><F7> :g/^\(.*title.*\)\@!.*<img.*$/execute "normal \<F7>"<CR>

"yank/delete atribute with values
nnoremap <F3> vawf";y
nnoremap <F4> vawf";d

"highlight TDs without width
nnoremap <F2>w /^\(.*width.*\)\@!.*<td.*$<CR>
"highlight IMGs without />
nnoremap <F2>i /^\(.*\/>.*\)\@!.*<img.*$<CR>

"remove trailing whitespace
nnoremap <leader>e :%s/\s\+$//<CR>

"unwrap style
nnoremap <leader>u :s/[{;]/&\r/g<CR>V%=:noh<CR>


"highlight #ABCDEF hex colour
function! HiCol()
	call clearmatches()

	" save cursor position
	let l:saved_cursor_pos = getpos(".")

	" select hex colour and get start/end position
	execute('normal! viw')
	let l:start_col = getpos("v")
	let l:end_col = getpos(".")
	execute('normal! "qy')
	let l:selection = @q

	" create new highlight colour and highlight selection
	execute('highlight ColHi guibg=#' . l:selection)
	call matchadd("ColHi", "\\%" . l:start_col[1] . "l\\%>" . (l:start_col[2]-1) . "c\\%<" . (l:end_col[2]+1) . "c")

	" restore cursor position
	call setpos(".", l:saved_cursor_pos)

endfunction

nnoremap <F1> :call HiCol()<CR>

"var_dump()
inoremap <leader>p var_dump();<LEFT><LEFT>
vnoremap <leader>p cvar_dump(<Esc>pa);
nnoremap <leader>p viwohyovar_dump(<Esc>pa); die;
nnoremap <leader>P viwohyOvar_dump(<Esc>pa); die;

"<?= ?>
inoremap <leader>i <?= ?><LEFT><LEFT><LEFT><SPACE>

"translate <?= _t() ?>
vnoremap <C-t> c<?= _t('<Esc>pa') ?><Esc>

"no more dissapearing files
set nowritebackup

"show syntax errors on .php save
au! BufWritePost *.php call PhpSyntax()

fun! PhpSyntax()
	redir => l:php_syntax_output
	silent execute '!php -l %'
	redir END
	let l:sphp = split(l:php_syntax_output, "\n")

	if (l:sphp[1] !~ "No syntax errors detected")
		let l:line_number = split(substitute(l:sphp[2], "\r", "", ""), " ")[-1]
		execute "normal " . (l:line_number) . "gg"
		for l:line in l:sphp
			let l:line = substitute(l:line, "\r", "", "")
			echom l:line
		endfor
	endif
endfun



nnoremap <F5> :call PhpArraySpacing()<CR>
inoremap <F5> <Esc>:call PhpArraySpacing()<CR>
vnoremap <F5> <Esc>:call PhpArraySpacing()<CR>

fun! PhpArraySpacing()
	let l:n = 0
	exe "'<,'>g/=/call search('=') | :if col('.') > l:n | :let l:n = col('.') | :endif"
	exe "'<,'>s/['\"]\\zs\\s\\+//g"
	exe "'<,'>g/=/call search('=') | :let x = " . l:n  . " - col('.') | :exe 'normal ' . x . 'i '"
endfun

