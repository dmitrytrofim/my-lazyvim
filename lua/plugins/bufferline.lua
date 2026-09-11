-- Выносим кэш в глобальную область файла, чтобы он жил между перерисовками
local git_root_cache = {}

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

      -- Оптимизированный формат отображения имени "папка/файл"
      name_formatter = function(buf)
        local bufnr = buf.bufnr
        if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then 
          return buf.name 
        end

        local path = vim.api.nvim_buf_get_name(bufnr)
        if path == "" then return buf.name end

        -- Ищем корень репозитория на диске ОДИН раз, потом берем мгновенно из памяти
        local git_root = git_root_cache[bufnr]
        if not git_root then
          git_root = vim.fs.root(bufnr, ".git") or vim.fn.getcwd()
          git_root_cache[bufnr] = git_root
        end

        -- Безопасная проверка: если путь к файлу почему-то короче корня, просто отдаем имя
        if #path <= #git_root then return buf.name end

        local relative = path:sub(#git_root + 1)
        local parts = vim.split(relative, "/", { trimempty = true })

        if #parts > 1 then
          local parent_dir = parts[#parts - 1]
          return parent_dir .. "/" .. buf.name
        else
          return buf.name
        end
      end,
    },
  },
}
