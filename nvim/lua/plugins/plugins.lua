local Util = require("lazyvim.util")

return {
  { "akinsho/bufferline.nvim", enabled = true },
  { "nvim-neo-tree/neo-tree.nvim", enabled = true },
  { "tpope/vim-commentary" },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },
  -- {
  --   "chrisgrieser/nvim-lsp-endhints",
  --   event = "LspAttach",
  --   lazy = false,
  --   config = function()
  --     require("lsp-endhints").setup({
  --       label = {
  --         truncateAtChars = 100,
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "felpafel/inlay-hint.nvim",
  --   event = "LspAttach",
  --   config = function()
  --     require("inlay-hint").setup({
  --       virt_text_pos = "right_align",
  --     })
  --   end,
  -- },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup()
    end,
    keys = {
      {
        "<leader>gb",
        "<cmd>BlameToggle<cr>",
        desc = "blame",
      },
    },
  },
  { "tpope/vim-rhubarb" },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
      })
    end,
    keys = {
      { "-", "<CMD>Oil<CR>", mode = { "n" }, desc = "file explorer" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {},
    },
  },
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      },
    },
  },
}
