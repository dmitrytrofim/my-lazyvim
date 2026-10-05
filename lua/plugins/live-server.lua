return {
  "selimacerbas/live-server.nvim",
  cmd = { "LiveServerStart", "LiveServerStop" },
  ft = { "html", "css", "javascript" },
  keys = {
    { "<F12>", "<cmd>LiveServerStart<cr>", desc = "Запустить Live Server" },
  },
  opts = {}, -- Оставляем настройки абсолютно пустыми, чтобы не было конфликтов
}
