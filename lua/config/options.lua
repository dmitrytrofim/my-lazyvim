vim.opt.number = true
vim.opt.relativenumber = false

-- Глобальный выключатель плавности самого Neovim (убирает микро-лаги)
vim.opt.smoothscroll = false 

-- 2. Специфичные настройки для графического интерфейса Neovide
if vim.g.neovide then
  -- Абсолютный и жесткий ноль для скролла на уровне GUI
  vim.g.neovide_scroll_animation_length = 0.0
  vim.g.neovide_position_animation_length = 0.0
  
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

vim.opt.path:append({ ".", "src" })
vim.opt.suffixesadd:append({ ".tsx", ".ts", ".jsx", ".js", ".vue", ".json" })
-- Строку с includeexpr (substitute...) удаляем!

-- Настройка встроенной диагностики (ошибок) Neovim
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    source = "if_many", -- Показывать имя линтера (eslint/tsc), только если их несколько
    prefix = "●",       -- Аккуратная точка вместо огромного текста ошибки на всю строку
  },
  severity_sort = true, -- Сначала показывать критические ошибки, потом варнинги
  float = {
    border = "rounded", -- Красивые скругленные углы окон (Neovide их плавно размывает)
    source = "always",  -- Всегда писать, откуда ошибка (например, typescript или eslint)
  },
})

-- Автокоманда: при удержании курсора на строке с ошибкой 
-- автоматически покажет всплывающее окно с текстом (как Hover в VS Code)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Снижаем задержку реакции редактора (по умолчанию 4000мс, сделаем 400мс)
-- Это ускорит появление подсказок об ошибках и уберет "тупняк" интерфейса
vim.opt.updatetime = 400
