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
}
