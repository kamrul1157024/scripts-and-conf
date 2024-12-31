return {
  "stevearc/dressing.nvim",
  config = function()
    require("dressing").setup({
      input = {
        win_options = {
          winhighlight = "NormalFloat:DiagnosticError",
        },
      },
    })
  end,
}
