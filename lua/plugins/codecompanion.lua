pcall(require, "config.local_env")

return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"},
    opts = {
        -- Настройка адаптера для OpenRouter
        adapters = {
            openrouter = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        url = "https://openrouter.ai/api/v1",
                        api_key = "OPENROUTER_API_KEY"
                    },
                    schema = {
                        model = {
                            default = "deepseek/deepseek-v4.1-flash-1017"
                        }
                    }
                })
            end
        },
        -- Указываем, где использовать этот адаптер
        interactions = {
            chat = {
                adapter = "openrouter"
            },
            inline = {
                adapter = "openrouter"
            }
        }
    },
    keys = {{
        "<leader>ai",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "AI: Chat"
    }, {
        "<leader>aa",
        "<cmd>CodeCompanionActions<cr>",
        desc = "AI: Actions"
    }, {
        "<leader>ae",
        ":CodeCompanion<cr>",
        mode = {"n", "v"},
        desc = "AI: Inline Edit"
    }}
}
