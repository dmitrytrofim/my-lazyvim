vim.opt.number = true
vim.opt.relativenumber = false

-- Глобальный выключатель плавности самого Neovim (убирает микро-лаги)
vim.opt.smoothscroll = false

-- 2. Специфичные настройки для графического интерфейса Neovide
if vim.g.neovide then
    -- Сглаживание отрисовки окон (Отключаем размытие фона и тени)
    -- Это главная причина фризов меню в Linux, так как GPU судорожно пересчитывает слои
    vim.g.neovide_floating_blur_amount_x = 0.0
    vim.g.neovide_floating_blur_amount_y = 0.0
    vim.g.neovide_floating_shadow = false

    -- Настройка частоты кадров под ваш монитор (Крайне важно в Linux)
    -- Укажите точную герцовку вашего экрана вместо автоматической
    vim.g.neovide_refresh_rate = 100 -- Поставьте 144 или 240, если у вас игровой монитор

    -- Позволяет Neovide засыпать и не насиловать видеокарту, когда на экране ничего не меняется
    vim.g.neovide_no_idle = false
    -- Абсолютный и жесткий ноль для скролла на уровне GUI
    vim.g.neovide_scroll_animation_length = 0.0
    vim.g.neovide_position_animation_length = 0.0
    vim.g.neovide_window_animation_length = 0.0

    -- Полное отключение анимации курсора (как в VS Code)
    vim.g.neovide_cursor_animation_length = 0.0
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_vfx_mode = "none"
    vim.g.neovide_cursor_animate_command_line = false

    -- Скорость прокрутки колесиком мыши
    vim.opt.mousescroll = "ver:7,hor:6"

    -- Полезные фичи для комфорта
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_progress_bar_enabled = false
end

vim.opt.path:append({".", "src"})
vim.opt.suffixesadd:append({".tsx", ".ts", ".jsx", ".js", ".vue", ".json"})
-- Строку с includeexpr (substitute...) удаляем!

-- Настройка встроенной диагностики (ошибок) Neovim
vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        source = "if_many", -- Показывать имя линтера (eslint/tsc), только если их несколько
        prefix = "●" -- Аккуратная точка вместо огромного текста ошибки на всю строку
    },
    severity_sort = true, -- Сначала показывать критические ошибки, потом варнинги
    float = {
        border = "rounded", -- Красивые скругленные углы окон (Neovide их плавно размывает)
        source = "always" -- Всегда писать, откуда ошибка (например, typescript или eslint)
    }
})

-- Автокоманда: при удержании курсора на строке с ошибкой 
-- автоматически покажет всплывающее окно с текстом (как Hover в VS Code)
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false
        })
    end
})

-- Снижаем задержку реакции редактора (по умолчанию 4000мс, сделаем 400мс)
-- Это ускорит появление подсказок об ошибках и уберет "тупняк" интерфейса
vim.opt.updatetime = 400

-- Время ожидания завершения комбинации клавиш (в миллисекундах)
-- По умолчанию 500мс, уменьшаем до 50мс для мгновенного отклика
vim.o.timeoutlen = 50

-- Время ожидания после нажатия ESC до перехода в нормальный режим
-- Важно для Linux, чтобы убрать задержку выхода из режимов
vim.o.ttimeoutlen = 10

-- Заставляет перезаписывать сам файл вместо его удаления и пересоздания.
-- Это решает проблемы с любыми внешними watch-инструментами (Node.js, Vite, Webpack)
vim.opt.backupcopy = "yes"

-- 2. При выходе из проводника — ЖЕЛЕЗНО возвращаем стандартную заводскую схему Neovim
vim.api.nvim_create_autocmd("BufLeave", {
    group = snacks_cursor_clean,
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "snacks_picker_list" or vim.bo.filetype == "snacks_picker_input" then
            -- Возвращаем официальную дефолтную строку Neovim (блок для normal/terminal, верт. линия для insert)
            -- Это гарантирует, что движок терминала не зависнет и автокоманды в autocmds.lua продолжат работать
            vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block"
        end
    end
})

vim.opt.mouse = "a" -- Мышь работает везде по умолчанию

-- Отключаем агрессивные инлайновые подсказки типов, которые ломают рендеринг в Neovide
vim.lsp.inlay_hint.enable(false)

-- Настраиваем дефолтное поведение для всех будущих LSP-серверов
local inlay_hints_group = vim.api.nvim_create_augroup("DisableInlayHints", {
    clear = true
})
vim.api.nvim_create_autocmd("LspAttach", {
    group = inlay_hints_group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            vim.lsp.inlay_hint.enable(false, {
                bufnr = args.buf
            })
        end
    end
})

vim.filetype.add({
    extension = {
        ejs = "ejs.html"
    }
})

-- Синхронизация с системным буфером обмена
vim.opt.clipboard = "unnamedplus"

