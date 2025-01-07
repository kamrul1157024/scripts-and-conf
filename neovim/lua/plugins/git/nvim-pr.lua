return {
  "kamrul1157024/nvim-pr",
  dir = "~/plugins.nvim/nvim-pr",
  config = function()
    require("nvim-pr").setup()
    vim.keymap.set("n", "<leader>gprv", ":PR open<CR>", { desc = "View PR in the editor" })
    vim.keymap.set("n", "<leader>gprb", ":PR open_in_browser<CR>", { desc = "Open PR in the browser" })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
  },
}
