return {
  "kevinhwang91/nvim-bqf",
  dependencies = {
    { "junegunn/fzf" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    vim.fn["fzf#install"]()
    vim.cmd("TSUpdate")
  end,
}
