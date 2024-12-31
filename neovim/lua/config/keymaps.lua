vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.api.nvim_create_user_command("RestoreSession", function()
  require("persistence").load()
end, { range = true })

vim.keymap.set("n", "<leader>cf", ":Format<CR>", { desc = "Format buffer with conform" })

vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { noremap = true, silent = true })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>sh", builtin.search_history, { desc = "Telescope search history" })
vim.keymap.set("n", "<leader>fr", builtin.search_history, { desc = "Telescope recent files" })

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
