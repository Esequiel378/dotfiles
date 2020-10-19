" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" === Editing Plugins === "

" Highlighting yaked text
Plug 'machakann/vim-highlightedyank'

" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" auto-close brackera plugin
Plug 'rstacruz/vim-closer'

" Vim surround
Plug 'tpope/vim-surround'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim'

" === Git Plugins === "

" Sweet Sweet FuGITive
Plug 'tpope/vim-fugitive'

" Show differences with style
Plug 'mhinz/vim-signify'

" Display line and author and datetime
Plug 'APZelos/blamer.nvim'

" === Python Plugins === "

" Python formater
Plug 'psf/black', { 'tag': '19.10b0' }

" Use python virtualenvs
" Plug 'jmcantrell/vim-virtualenv'

" django support
Plug 'tweekmonster/django-plus.vim'

" === Golang Plugins === "

" Go formater
Plug 'tweekmonster/gofmt.vim'

" Go language support
Plug 'fatih/vim-go'

" === Javascript Plugins === "

" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'

" Vim vuetify
Plug 'albanm/vuetify-vim'

" ReactJS JSX syntax highlighting
Plug 'mxw/vim-jsx'

" === Syntax Highlighting === "

" NERDTree syntax highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" === UI === "

" File explorer
Plug 'scrooloose/nerdtree'

" Undo tree
Plug 'mbbill/undotree'

" Colorscheme
Plug 'gruvbox-community/gruvbox'

" Customized vim status line
Plug 'vim-airline/vim-airline'

" Icons
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()
