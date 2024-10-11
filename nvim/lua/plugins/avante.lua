return {
  {
    "yetone/avante.nvim",
    init = function()
      require("avante_lib").load()
    end,
    event = "VeryLazy",
    opts = {
      hints = { enabled = false },
    },
    build = "make BUILD_FROM_SOURCE=true",
    dependencies = "stevearc/dressing.nvim",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "Avante" })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
}
