-- BASIC SETTINGS
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.background = "dark"

-- LEADER KEY
vim.g.mapleader = " "

-- LOAD LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS
require("lazy").setup({
  { "morhetz/gruvbox" },                         -- Theme
  { "tpope/vim-vinegar" },                       -- File explorer
  { "junegunn/fzf", build = "./install --bin", dir = "~/.fzf" },  -- fzf core
  { "junegunn/fzf.vim" },                        -- fzf for Vim
  { "itchyny/lightline.vim" },                   -- Statusline
  { "hrsh7th/nvim-cmp" },                        -- Completion engine
  { "hrsh7th/cmp-nvim-lsp" },                    -- LSP source
  { "hrsh7th/cmp-buffer" },                      -- Buffer source
  { "hrsh7th/cmp-path" },                        -- Path source
  { "neovim/nvim-lspconfig" },                   -- LSP configs
})

-- THEME
vim.cmd("colorscheme gruvbox")

-- LIGHTLINE
vim.g.lightline = {
  colorscheme = 'gruvbox',
  active = {
    left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' } }
  }
}

-- COMPLETION (nvim-cmp)
local cmp = require'cmp'
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' }
  })
})

-- LSP SETUP
local lspconfig = require('lspconfig')
lspconfig.clangd.setup({})
lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
