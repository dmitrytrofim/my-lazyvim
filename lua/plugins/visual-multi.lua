return {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
        -- Объедините все настройки в одну таблицу
        vim.g.VM_maps = {
            ["Add Cursor Down"] = '\\j', -- Официально рекомендованная альтернатива, гарантированно работает
            ["Add Cursor Up"] = '\\k',
            ["I Return"] = "<S-CR>" -- Ваша настройка для blink.cmp
        }
        vim.g.VM_mouse_mappings = 1
    end
}
