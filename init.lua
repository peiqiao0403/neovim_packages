-- Load lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "morhetz/gruvbox" },
  { "tpope/vim-vinegar" },
  { "junegunn/fzf", build = "./install --bin" },
  { "junegunn/fzf.vim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "itchyny/lightline.vim" },
})

-- Color and UI
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("colorscheme gruvbox")

-- Status line
vim.g.lightline = { colorscheme = "gruvbox" }

-- Netrw settings (used by vinegar)
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- fzf mappings
vim.keymap.set("n", "<C-p>", ":Files<CR>")
vim.keymap.set("n", "<C-b>", ":Buffers<CR>")
vim.keymap.set("n", "<leader>rg", ":Rg<CR>")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  completion = {
    completeopt = "menu,menuone,noselect"
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = "" -- no icons
      return vim_item
    end
  },
  window = {
    documentation = cmp.config.disable
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" }
  }
})

-- LSP servers
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({ capabilities = require("cmp_nvim_lsp").default_capabilities() })
lspconfig.pyright.setup({ capabilities = require("cmp_nvim_lsp").default_capabilities() })
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.tsserver.setup({})
