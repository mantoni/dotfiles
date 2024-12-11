return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_style = "atlantis"
      vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "vertical",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      diagnostics = {
        underline = false,
        virtual_text = {
          spacing = 0,
          prefix = "•",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "typescript",
        "javascript",
        "jsdoc",
        "json",
        "yaml",
        "html",
        "css",
        "scss",
        "styled",
        "sql",
        "lua",
        "regex",
        "markdown",
        "markdown_inline",
        "bash",
        "toml",
        "graphql",
        "terraform",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- options
      })
    end,
  },
  { "github/copilot.vim" },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
}
