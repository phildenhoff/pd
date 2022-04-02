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
  " Plug 'preservim/nerdtree'
  Plug 'vifm/vifm.vim'
  " Plug 'chipsenkbeil/distant.nvim'
  " ??
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/goyo.vim'
  " Autocomplete
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip' " Provides snippets. Required by nvim-cmp (or an alt)
  Plug 'saadparwaiz1/cmp_luasnip' " Required for nvim-cmp
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'
  " Searchability
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'rmagatti/session-lens'
  " IDE features
  Plug 'sidebar-nvim/sidebar.nvim'
  " Utilities
  Plug 'nvim-lua/plenary.nvim'
  Plug 'rmagatti/auto-session'
  Plug 'github/copilot.vim'
  Plug 'wakatime/vim-wakatime'
  " Shortcuts &c.
  Plug 'tpope/vim-abolish'
  " Themes
  Plug 'projekt0n/github-nvim-theme'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'git@github.com:rakr/vim-one.git'
  " LSPs & Languages
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'jparise/vim-graphql'
  Plug 'elixir-editors/vim-elixir'
  " Colorization
  Plug 'gko/vim-coloresque'
  " Git
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
call plug#end()

" LSP stuff
lua << EOF
local nvim_lsp = require('lspconfig')

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
  capabilities = capabilities,
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
  capabilities = capabilities,
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
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern("mix.exs"),
  cmd = {"/Users/phil/.local/share/elixir-ls/language_server.sh"}
}
EOF

" nvim-cmp provides autocomplete prompts
lua <<EOF

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- LuaSnip setup
local luasnip = require('luasnip')

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    -- Tab jumps to the next item in the menu
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        -- Support GitHub copilot tab-completion when there isn't
        -- a snippet available.
        local copilot_keys = vim.fn["copilot#Accept"]("")
          if copilot_keys ~= "" then
              vim.api.nvim_feedkeys(copilot_keys, "i", true)
          else
              fallback()
          end
      end
    end, { "i", "s" }),
    -- And Shift-Tab jumps back
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
}

-- Disable Copilot's defaut tab-takeover
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
EOF

" THEME
lua << EOF
-- Enable, but don't use, the github theme
--require('github-theme').setup()

-- You can change the theme by using :NightfoxLoad <fox>
require('nightfox')
vim.cmd('colorscheme dayfox')
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

" Auto-session setup
lua << EOF
require('auto-session').setup {
  log_level = 'info',
  auto_session_suppress_dirs = {'~/'},
  pre_save_cmds = {"tabdo SidebarNvimClose"},
  post_save_cmds = {"tabdo SidebarNvimOpen"},
  post_restore_cmds = {"tabdo SidebarNvimOpen"},
}

-- Add Session search
require("telescope").load_extension("session-lens")
EOF

nnoremap <leader>nve <cmd>tabnew ~/.config/nvim/init.vim<CR>
" or :so %
nnoremap <leader>nvs <cmd>source ~/.config/nvim/init.vim<CR>

nnoremap <leader>td <cmd>colorscheme dayfox<cr>
nnoremap <leader>tu <cmd>colorscheme duskfox<cr>
nnoremap <leader>tn <cmd>colorscheme nightfox<cr>

nnoremap <leader>tgd <cmd>colorscheme github_light<cr>
nnoremap <leader>tgn <cmd>colorscheme github_dark<cr>

nnoremap <leader>p <cmd>write<cr> <cmd>! prettier --write %<cr>

nnoremap <C-6> <C-^>

" Make Y act like C or D (from cursor to EOL)
nnoremap Y y$

" Keep your cursor vertically centered when jumping & merging lines
" nzz jump & recenter, zv is open folds
nnoremap n nzzzv
nnoremap N Nzzzv
" Mark the spot, join, then jump back
nnoremap J mzJ`z

" Add undo break points to punctuation
" Ctrl-g U adds an undo breakpoint
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Move text and re-indent
" I can't even explain this.
" https://www.youtube.com/watch?v=hSHATqh8svM
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-J> <esc>:m .+1<CR>==a
inoremap <C-K> <esc>:m .-2<CR>==a
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
