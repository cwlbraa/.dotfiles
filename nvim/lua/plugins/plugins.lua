local Util = require("lazyvim.util")

return {
  { "akinsho/bufferline.nvim", enabled = true },
  { "nvim-neo-tree/neo-tree.nvim", enabled = true },
  -- {
  --   "ray-x/go.nvim",
  --   requires = { -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("go").setup()
  --   end,
  --   event = { "CmdlineEnter" },
  --   ft = { "go", "gomod" },
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  -- },

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
      require("oil").setup()
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
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    keys = {
      { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    },
  },
}
