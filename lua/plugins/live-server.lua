return {
  "selimacerbas/live-server.nvim",
  cmd = { "LiveServerStart", "LiveServerStop" },
  ft = { "html", "css", "javascript" },
  keys = {
    -- Нажатие на F12 запускает сервер и открывает браузер
    { "<F12>", "<cmd>LiveServerStart<cr>", desc = "Запустить Live Server" },
  },
  opts = {
    port = 8000,
    browser = true,
    css_inject = true,
  },
}
