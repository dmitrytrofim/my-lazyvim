return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      left_trunc_marker = "",
      right_trunc_marker = "",
      enforce_regular_tabs = false,
      tab_size = 0,
      padding = 1,
      max_name_length = 100,

      -- ТОЧНАЯ НАСТРОЙКА ДЛЯ LINUX:
      name_formatter = function(buf)
        local bufnr = buf.bufnr
        if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then 
          return buf.name 
        end

        local path = vim.api.nvim_buf_get_name(bufnr)
        if path == "" then return buf.name end

        -- Ищем корень .git репозитория (возвращает абсолютный путь)
        local git_root = vim.fs.root(bufnr, ".git")
        if not git_root then
          git_root = vim.fn.getcwd()
        end

        -- Вырезаем из пути файла путь к git-корню
        -- Например: из /home/dimas/project/index.html останется /index.html
        local relative = path:sub(#git_root + 1)

        -- Разбиваем оставшийся путь по классическому слэшу /
        local parts = vim.split(relative, "/", { trimempty = true })

        -- Если элементов больше одного (например: ["src", "index.html"]) — значит есть подпапка
        if #parts > 1 then
          local parent_dir = parts[#parts - 1]
          return parent_dir .. "/" .. buf.name
        else
          -- Если файл лежит прямо рядом с .git (например: ["index.html"]) — выводим только имя файла
          return buf.name
        end
      end,
    },
  },
}
