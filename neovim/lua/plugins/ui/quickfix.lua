return {
  "kevinhwang91/nvim-bqf",
  dependencies = {
    { "junegunn/fzf" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    vim.cmd("TSUpdate")
  end,
}
