return {
    {
        "yetone/avante.nvim",
        init = function()
            require("avante_lib").load()
        end,
        event = "VeryLazy",
        lazy = false,
        -- build = "make BUILD_FROM_SOURCE=true",
        opts = {
            hints = { enabled = false },
            claude = { disable_tools = true },
        },
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
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
    {
        "saghen/blink.compat",
        lazy = true,
        opts = {},
        config = function()
            -- monkeypatch cmp.ConfirmBehavior for Avante
            require("cmp").ConfirmBehavior = {
                Insert = "insert",
                Replace = "replace",
            }
        end,
    },
    {
        "Saghen/blink.cmp",
        lazy = true,
        opts = {
            sources = {
                default = { "avante_commands", "avante_mentions", "avante_files" },
                providers = {
                    avante_commands = {
                        name = "avante_commands",
                        module = "blink.compat.source",
                        score_offset = 90, -- show at a higher priority than lsp
                        opts = {},
                    },
                    avante_files = {
                        name = "avante_commands",
                        module = "blink.compat.source",
                        score_offset = 100, -- show at a higher priority than lsp
                        opts = {},
                    },
                    avante_mentions = {
                        name = "avante_mentions",
                        module = "blink.compat.source",
                        score_offset = 1000, -- show at a higher priority than lsp
                        opts = {},
                    },
                },
            },
        },
    },
}
