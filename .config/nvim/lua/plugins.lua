local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- "j-hui/fidget.nvim",
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "Bilal2453/luvit-meta", lazy = true
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  { "nvim-treesitter/nvim-treesitter",          build = ":TSUpdate" },
  {
    -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter",
  },
  -- {
  --   -- Show context
  --   "nvim-treesitter/nvim-treesitter-context",
  --   dependencies = "nvim-treesitter",
  -- },

  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Fuzzy Finder (files, lsp, etc)
  { "nvim-telescope/telescope.nvim",            branch = "0.1.x",   dependencies = { "nvim-lua/plenary.nvim" } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make",     cond = vim.fn.executable("make") == 1 },

  -- Fancier statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",                              opts = {} }, -- Add indentation guides even on blank lines
  "numToStr/Comment.nvim",                                                                         -- "gc" to comment visual regions/lines
  "tpope/vim-sleuth",                                                                              -- Detect tabstop and shiftwidth automatically
  "tpope/vim-surround",                                                                            -- Surround visual regions with brackets

  -- Catppuccin Theme
  { "catppuccin/nvim",                     name = "catppuccin",                       priority = 1000 },

  -- Tokyo Night Theme
  { "folke/tokyonight.nvim",               lazy = false,                              priority = 1000, opts = {} },

  -- Metals Scala LSP
  { "scalameta/nvim-metals",               dependencies = { "nvim-lua/plenary.nvim" } },

  -- Haskell LSP
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    version = "^2", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },
  -- Auto-close parentheses
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Debug Adapter Protocol
  "mfussenegger/nvim-dap",

  -- For formatting
  { "stevearc/conform.nvim",   opts = {} },
  "lukas-reineke/lsp-format.nvim",

  -- Pretty symbols in completion
  "onsails/lspkind.nvim",

  -- Terminal in Neovim!
  { "akinsho/toggleterm.nvim", version = "*" },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },

  -- ToDo Highlighter
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  },
  { "RRethy/vim-illuminate" },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        python = { "mypy", "flake8" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  }
})
