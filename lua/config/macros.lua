-- ~/.config/nvim/lua/config/macros.lua
local M = {}

function M.copy_class_to_right_window()
    -- Получаем строку и позицию курсора
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]

    -- Ищем слово, включающее буквы, цифры, дефисы и подчеркивания, в котором стоит курсор
    local word = ""
    for w in line:gmatch("[%w%-_]+") do
        local start_pos = line:find(w, 1, true)
        -- Грубая проверка, что курсор попал в это слово
        if col >= start_pos - 1 and col <= start_pos + #w - 1 then
            word = w
            break
        end
    end

    if word == "" then
        return
    end

    word = word:match("([^%.]+)$") or word

    -- 1. Запоминаем текущее (HTML) окно
    local current_win = vim.api.nvim_get_current_win()

    -- 2. Переключаемся вправо
    vim.cmd("wincmd l")

    -- Если окна справа нет — выходим
    if vim.api.nvim_get_current_win() == current_win then
        vim.notify("Окно справа не найдено", vim.log.levels.WARN)
        return
    end

    -- 3. Вставляем блок в конец файла
    local buf = vim.api.nvim_get_current_buf()
    local line_count = vim.api.nvim_buf_line_count(buf)

    vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, {"", "." .. word .. " {}"})

    -- 4. Возвращаем фокус обратно в исходное (HTML) окно
    vim.api.nvim_set_current_win(current_win)
end

return M
