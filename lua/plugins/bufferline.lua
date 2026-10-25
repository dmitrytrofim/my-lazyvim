return {
    "akinsho/bufferline.nvim",
    opts = {
        options = {
            custom_filter = function(buf_number)
                -- Получаем тип буфера
                local buftype = vim.bo[buf_number].buftype
                -- Получаем имя файла/папки
                local name = vim.fn.bufname(buf_number)

                -- 1. Показываем только обычные файлы (buftype == "")
                -- Это отсеет все терминалы, проводники, дашборды и т.д.
                if buftype ~= "" then
                    return false
                end

                -- 2. Если буфер вообще без имени (пустой) - скрываем
                if name == "" then
                    return false
                end

                -- 3. Если имя буфера - это папка (проводник), скрываем
                if vim.fn.isdirectory(name) == 1 then
                    return false
                end

                return true
            end,
            always_show_bufferline = true,
            -- Переключаем режим на 'buffers', так как форматирование имени мы берем на себя
            mode = "buffers",
            padding = 1,
            max_name_length = 100,

            --- Функция кастомизации отображения имени буфера
            name_formatter = function(buf)
                -- Получаем корень текущего рабочего пространства (проекта) через Snacks (встроен в LazyVim v14)
                -- Если Snacks недоступен, фолбэкаемся на стандартный cwd
                local root = package.loaded["snacks"] and Snacks.git.get_root() or vim.fn.getcwd()

                -- Получаем относительный путь файла от корня проекта
                local relative_path = vim.api.nvim_buf_get_name(buf.bufnr)
                if relative_path == "" then
                    return buf.name
                end

                relative_path = vim.fn.fnamemodify(relative_path, ":.")

                -- Разбиваем путь на компоненты
                local parts = vim.split(relative_path, "/", {
                    trimempty = true
                })

                -- Если файл лежит в корне (частей <= 1, например, "main.go" или "README.md"),
                -- возвращаем только имя файла
                if #parts <= 1 then
                    return buf.name
                end

                -- Если файл лежит в подпапке, возвращаем "папка/файл" (берем предпоследний элемент)
                local parent_dir = parts[#parts - 1]
                return parent_dir .. "/" .. buf.name
            end
        }
    }
}
