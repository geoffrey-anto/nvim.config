require("lazy").setup({
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"
      lspconfig.elixirls.setup {
        -- you need to specify the executable command mannualy for elixir-ls
        cmd = { "/home/geo/elixir-ls-v0.24.1/language_server.sh" },
      }
    end,
  },
  { "echasnovski/mini.nvim", version = "*" },
  {
    "AstroNvim/AstroNvim",
    version = "^4", -- Remove version tracking to elect for nighly AstroNvim
    import = "astronvim.plugins",
    opts = { -- AstroNvim options must be set here with the `import` key
      mapleader = " ", -- This ensures the leader key must be configured before Lazy is set up
      maplocalleader = ",", -- This ensures the localleader key must be configured before Lazy is set up
      icons_enabled = true, -- Set to false to disable icons (if no Nerd Font is available)
      pin_plugins = nil, -- Default will pin plugins when tracking `version` of AstroNvim, set to true/false to override
      update_notifications = true, -- Enable/disable notification about running `:Lazy update` twice to update pinned plugins
    },
  },
  {
    "google/executor.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function() require("executor").setup {} end,
  },
  { import = "community" },
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "astrotheme", "habamax" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])

require("executor").setup {
  -- View details of the task run in a split, rather than a popup window.
  -- Set this to `false` to use a popup.
  use_split = false,

  -- Configure the split. These are ignored if you are using a popup.
  split = {
    -- One of "top", "right", "bottom" or "left"
    position = "top",
    -- The number of columns to take up. This sets the split to 1/4 of the
    -- space. If you're using the split at the top or bottom, you could also
    -- use `vim.o.lines` to set this relative to the height of the window.
    size = math.floor(vim.o.columns * 1 / 4),
  },

  -- Configure the popup. These are ignored if you are using a split.
  popup = {
    -- Sets the width of the popup to 3/5ths of the screen's width.
    width = math.floor(vim.o.columns * 3 / 5),
    -- Sets the height to almost full height, allowing for some padding.
    height = vim.o.lines - 20,
    -- Border styles
    border = {
      padding = {
        top = 2,
        bottom = 2,
        left = 3,
        right = 3,
      },
      style = "rounded",
    },
  },
  -- Filter output from commands. See *filtering_output* below for more
  output_filter = function(command, lines) return lines end,

  notifications = {
    -- Show a popup notification when a task is started.
    task_started = true,
    -- Show a popup notification when a task is completed.
    task_completed = true,
    -- Border styles
    border = {
      padding = {
        top = 0,
        bottom = 0,
        left = 1,
        right = 1,
      },
      style = "rounded",
    },
  },
}

require("mini.icons").setup()

vim.api.nvim_set_keymap("n", "<leader>er", ":ExecutorRun<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ev", ":ExecutorToggleDetail<CR>", {})
