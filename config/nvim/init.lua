-- Neovim Lua-based init.lua migrated from your Vim config
-- ================================
-- Keith's Modern Neovim Config
-- ================================

-- Set leader key
vim.g.mapleader = ' '

-- Encoding
vim.opt.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'

-- General Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.spelllang = 'en_us'
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.colorcolumn = '88'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.wildmode = { 'list:longest', 'list:full' }
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.swapfile = false

-- Plugin manager: lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- UI
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto'
        }
      }
    end
  },
  'luochen1990/rainbow',
  'joshdick/onedark.vim',
  {
    'danilo-augusto/vim-afterglow',
    lazy = false,
    priority = 1000,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1001,
  },
  -- Utilities
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-ragtag',
  'jiangmiao/auto-pairs',
  'dense-analysis/ale',
  'PeterRincker/vim-argumentative',
  'raingo/vim-matlab',
  'jelera/vim-javascript-syntax',

  -- REPL with iron.nvim
  {
    'hkupty/iron.nvim',
    config = function()
      local iron = require('iron.core')
      iron.setup {
        config = {
          repl_definition = {
            python = {
              command = { "ipython" }
            },
            matlab = {
              command = { "matlab", "-nosplash", "-nodesktop" }
            },
          },
          repl_open_cmd = require('iron.view').split.vertical.botright('50%'),
        },
        keymaps = {
          send_motion = "<leader>rs",
          visual_send = "<leader>rs",
          send_file = "<leader>rf",
          send_line = "<leader>rl",
          send_mark = "<leader>rm",
          mark_motion = "<leader>rc",
          mark_visual = "<leader>rc",
          remove_mark = "<leader>rd",
          cr = "<leader>rr",
          interrupt = "<leader>r<leader>",
          exit = "<leader>rq",
          clear = "<leader>rclear",
        },
      }
    end
  },

  -- Tree-sitter for better syntax
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "python", "javascript", "html", "lua", "markdown", "matlab", "json" },
        highlight = { enable = true },
      }
    end
  },

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    ft = { 'markdown' },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
      local uname = vim.fn.system('uname')
      if uname:find('Darwin') then
        vim.g.mkdp_path_to_chrome = 'open -a firefox'
      else
        vim.g.mkdp_path_to_chrome = 'firefox'
      end
    end,
  },
})

vim.cmd('colorscheme afterglow')
-- UI Theme Options
vim.g.afterglow_inherit_background = 1
vim.g.rainbow_active = 1

-- ALE config
vim.g.ale_linters = {
  python = { 'flake8', 'pydocstyle' },
  matlab = { 'mlint' },
  javascript = { 'eslint' },
}
vim.g.ale_fixers = {
  ['*'] = { 'trim_whitespace', 'remove_trailing_lines' },
  python = { 'black', 'isort' },
  javascript = { 'prettier' },
  html = { 'prettier' },
}
vim.g.ale_lint_on_insert_leave = 1
vim.g.ale_lint_on_text_changed = 0
vim.g.ale_lint_on_save = 1
vim.g.ale_fix_on_save = 0
vim.cmd([[command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"]])

-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<Leader>p', ':set paste<CR><Esc>"*p:set nopaste<CR>', opts)
map('n', '<Leader>y', '"*y', opts)
map('n', '<Leader><Leader>', ':w<CR>', opts)
map('n', '<Leader>q', ':wq<CR>', opts)
map('n', '<Leader>j', '<Plug>(ale_next_wrap)', {})
map('n', '<Leader>k', '<Plug>(ale_previous_wrap)', {})
map('n', '<Leader>c', '/%%<CR>', opts)
map('n', '<Leader>C', '?%%<CR>', opts)
map('n', '<Leader>~', 'bi~<Esc>', opts)
map('n', '<Leader>to', 'i**TODO**:', opts)
map('n', '<Leader>td', [[:sno/**TODO**:/~~**TODO**:~~/<CR>]], opts)
map('n', '<Leader>f', ':ALEFix<CR>', opts)
map('i', 'jj', '<ESC>:w<CR>', opts)
map('i', ';;', '<Esc>m`A;<Esc>``', opts)
map('n', ';;', "@='<C-V><Esc>A;<C-V><Esc>j'<CR>", {})
map('i', '<C-E>', '<Esc>A', opts)
map('i', '<C-A>', '<Esc>^i', opts)
map('n', '<Leader><ESC>', ':noh<CR>', opts)
map('n', '<Leader>h', ':center 80<CR>0r#<Esc>60A <Esc>a#<Esc>hd78<bar>YppVr#kk.', {})
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '˙', 'gT', opts)
map('n', '¬', 'gt', opts)
map('n', 'T', ':tabnew<CR>', opts)
map('n', 'Te', ':tabedit ', opts)
map('n', 'K', 'i<CR><Esc>', opts)
map('n', '<CR>', 'o<Esc>', opts)
map('n', '<Up>', '<Nop>', opts)
map('n', '<Down>', '<Nop>', opts)
map('n', '<Left>', '<Nop>', opts)
map('n', '<Right>', '<Nop>', opts)
map('n', '<Leader>ev', ':tabedit $MYVIMRC<CR>', opts)
map('n', '<Leader>sv', ':source $MYVIMRC<CR>', opts)

-- FileType autocommands
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'matlab',
  callback = function()
    vim.opt_local.commentstring = '% %s'
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript',
  callback = function()
    vim.opt_local.commentstring = '% %s'
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.html',
  command = 'syntax sync fromstart'
})
