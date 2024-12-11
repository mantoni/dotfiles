return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics = "",
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        separator_style = "slant",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },

        lualine_c = {
          LazyVim.lualine.root_dir(),
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path(), padding = { left = 0, right = 0 } },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = LazyVim.config.icons.diagnostics.Error,
              warn = LazyVim.config.icons.diagnostics.Warn,
              info = LazyVim.config.icons.diagnostics.Info,
              hint = LazyVim.config.icons.diagnostics.Hint,
            },
          },
          {
            "diff",
            symbols = {
              added = LazyVim.config.icons.git.added,
              modified = LazyVim.config.icons.git.modified,
              removed = LazyVim.config.icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = { "encoding" },
        lualine_z = {},
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
      appearance = {
        nerd_font_variant = "normal",
      },
      completion = {
        ghost_text = {
          enabled = false,
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
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = false,
      },
      scroll = {
        enabled = false,
      },
      words = {
        enabled = false,
      },
      notifier = {
        level = vim.log.levels.WARN,
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        keyword = "bg",
        pattern = [[.*<(KEYWORDS)\s*]],
      },
    },
  },
  {
    "github/copilot.vim",
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
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
        underline = true,
        virtual_text = false,
      },
    },
  },
  {
    "mason.nvim",
    ensure_installed = {
      "eslint_d",
      "prettier",
      "stylua",
    },
  },
  { "folke/tokyonight.nvim", enabled = false },
  { "folke/flash.nvim", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
}
