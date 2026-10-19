return {{
    "nvim-mini/mini.animate",
    -- Убираем enabled = false, чтобы дать lazy.nvim успокоиться
    opts = {
        -- Жестко выключаем все триггеры анимаций.
        -- Плагин лежит на диске, но его функции ФИЗИЧЕСКИ НЕ ВЫПОЛНЯЮТСЯ.
        cursor = {
            enable = false
        },
        scroll = {
            enable = false
        },
        resize = {
            enable = false
        },
        open = {
            enable = false
        },
        close = {
            enable = false
        }
    }
}}
