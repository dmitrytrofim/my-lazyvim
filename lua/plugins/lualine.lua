return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Полностью очищаем правую угловую секцию, где выводится время
      opts.sections.lualine_z = {}
    end,
  },
}

