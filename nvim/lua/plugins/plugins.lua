return {
  { "akinsho/bufferline.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },

  { "tpope/vim-commentary" },
  { "FabijanZulj/blame.nvim", keys = { { "<leader>gb", "<cmd>ToggleBlame<cr>", desc = "blame" } } },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-vinegar" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
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
