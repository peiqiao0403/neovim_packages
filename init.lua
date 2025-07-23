-- init.lua for TTY-friendly Retro Neovim Setup

vim.opt.termguicolors = false -- disables truecolor for TTY
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.scrolloff = 4
vim.opt.wrap = false

-- Keymaps
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

vim.opt.rtp:prepend("~/.config/nvim/lazy/lazy.nvim")

require("lazy").setup({
  -- Colorscheme: Gruvbox
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = function()
      vim.cmd("colorscheme gruvbox")
    end
  },

  -- File Explorer
  { "nvim-tree/nvim-tree.lua", config = function()
      require("nvim-tree").setup({
        renderer = {
          icons = { show = { file = false, folder = false, folder_arrow = false } },
        },
        view = {
          width = 30,
          side = "left",
        }
      })
    end
  },

  -- Fuzzy Finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
          winblend = 0,
        }
      })
    end
  },

  -- Statusline
  { "nvim-lualine/lualine.nvim", config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          icons_enabled = false,
          section_separators = "",
          component_separators = "",
        }
      })
    end
  },

  -- Syntax Highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "python", "html", "css", "javascript", "lua" },
        highlight = { enable = true },
      })
    end
  },
})
