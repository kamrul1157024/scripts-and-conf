  return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-_>]],
      shade_terminalk = true,
      auto_scroll = false,
      direction = "float",
      on_open = function(term)
        local winid = term.window
        vim.wo[winid].signcolumn = "no"
      end,
    },
  }
