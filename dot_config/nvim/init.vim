"rbar/ Hybrid numbering with relative numbers around absolute number on current line
set number relativenumber

" Show position in file (row, col)
set ruler
set showcmd

set scrolloff=30

""""""
" >> COLORS AND FONTS <<
""""""
" enable syntax highlighting
syntax enable
set termguicolors

" Set the ruler column
set colorcolumn=80

" Font
set guifont=FiraCode\ Nerd\ Font:h14

" Spaces, not tabs
set expandtab
set smarttab

set shiftwidth=2
set tabstop=2

" Remove trailing whitespaces on save
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Incremental searching
set incsearch
" Highlight search terms
set hlsearch

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" Auto close nerdtree if it's the last buffer
function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \ bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
"autocmd BufEnter * call CheckLeftBuffers()

call plug#begin()
  Plug 'git@github.com:rakr/vim-one.git'
  Plug 'preservim/nerdtree'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'maxmellon/vim-jsx-pretty'
  " Plug 'styled-components/vim-styled-components'
  Plug 'jparise/vim-graphql'
  Plug 'elixir-editors/vim-elixir'
  Plug 'itchyny/lightline.vim'
  Plug 'vifm/vifm.vim'
  Plug 'tpope/vim-abolish'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'projekt0n/github-nvim-theme'
  Plug 'github/copilot.vim'
  Plug 'wakatime/vim-wakatime'
  Plug 'junegunn/goyo.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'chipsenkbeil/distant.nvim'
  Plug 'sidebar-nvim/sidebar.nvim'
call plug#end()

" LSP stuff
lua << EOF
local nvim_lsp = require('lspconfig')


vim.o.completeopt = "menuone,noselect"
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader><F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- Not Prettier formatting, so it's useless to me
  -- buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Add Deno LSP
require'lspconfig'.denols.setup{
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json"),
  init_options = {
    lint = true
  }
}

-- Organize imports for Typescript files
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {
      vim.api.nvim_buf_get_name(0)
    },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

-- Add TS Server
require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  filetypes = {"javascript", "typescript", "typescriptreact", "javascriptreact"},
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  commands = {
    OrganizeImports = {
     organize_imports,
     description = "Organize Imports"
    }
  },
  init_options = {
    lint = true,
  },
  flags = {
    debounce_text_changes = 150,
  }
}

-- eslint?
local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}
local util = require "lspconfig".util

require "lspconfig".efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"javascript", "typescript"},
  root_dir = function(fname)
    return util.root_pattern("tsconfig.json")(fname) or
    util.root_pattern(".eslintrc.js", ".git")(fname);
  end,
  settings = {
    rootMarkers = {".eslintrc.js", ".git/"},
    languages = {
      javascript = {eslint},
      typescript = {eslint}
    }
  }
}

-- Elixir
require'lspconfig'.elixirls.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("mix.exs"),
  cmd = {"/Users/phil/.local/share/elixir-ls/language_server.sh"}
}
EOF

" nvim-compe
lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
EOF

" THEME
lua << EOF
-- Enable, but don't use, the github theme
require('github-theme').setup()

-- You can change the theme by using :NightfoxLoad <fox>
require('nightfox').load("dayfox")
EOF

lua << EOF
require('gitsigns').setup()
EOF

" Find files using Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fw <cmd>Telescope file_browser<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>fi <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>

set noshowmode
"autocmd BufWinEnter * NERDTreeMirror

" Disable lspconfig messages from notifying us
" This prevents "Autostart for <> failed" messages
" https://neovim.discourse.group/t/lsp-disable-autostart-message/1490/9
lua << EOF
local notify = vim.notify
vim.notify = function(msg, ...)
    -- or whatever condition you want to check
    if msg:match("[lspconfig]") then
        return
    end

    notify(msg, ...)
end
EOF

" Sidebar
lua << EOF
local sidebar = require("sidebar-nvim")
sidebar.setup({
  open = true,
  sections = { "datetime", "git", "diagnostics", "buffers", "todos", "files"},
  disable_closing_prompt = true,
})
EOF

nnoremap <leader>nve <cmd>tabnew ~/.config/nvim/init.vim<CR>
nnoremap <leader>nvs <cmd>source ~/.config/nvim/init.vim<CR>

nnoremap <leader>td <cmd>NightfoxLoad dayfox<cr>
nnoremap <leader>tu <cmd>NightfoxLoad duskfox<cr>
nnoremap <leader>tn <cmd>NightfoxLoad nightfox<cr>

nnoremap <leader>tgd <cmd>colorscheme github_light<cr>
nnoremap <leader>tgn <cmd>colorscheme github_dark<cr>

nnoremap <C-6> <C-^>
