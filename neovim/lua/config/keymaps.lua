vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gb", ":Neotree buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ge", ":Neotree git_status<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gd", function()
  if next(require("diffview.lib").views) == nil then
    vim.cmd("DiffviewOpen")
  else
    vim.cmd("DiffviewClose")
  end
end, { desc = "Toggle git diff " })

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
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>/", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>sw", live_grep_args_shortcuts.grep_word_under_cursor, { noremap = true })
vim.keymap.set("v", "<leader>sw", live_grep_args_shortcuts.grep_visual_selection, { noremap = true })
vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>sh", builtin.search_history, { desc = "Telescope search history" })
vim.keymap.set("n", "<leader>fr", builtin.search_history, { desc = "Telescope recent files" })

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<leader>cq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { desc = "CopilotChat - Quick chat" })

vim.keymap.set("n", "<leader>aq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { desc = "CopilotChat - Quick chat" })

vim.keymap.set("n", "<leader>ap", function()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end, { desc = "CopilotChat - Prompt actions" })

local function switch_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand("<cword>")
  local word_start = vim.fn.matchstrpos(vim.fn.getline("."), "\\k*\\%" .. (col + 1) .. "c\\k*")[2]

  -- Detect camelCase
  if word:find("[a-z][A-Z]") then
    -- Convert camelCase to snake_case
    local snake_case_word = word:gsub("([a-z])([A-Z])", "%1_%2"):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
  -- Detect snake_case
  elseif word:find("_[a-z]") then
    -- Convert snake_case to camelCase
    local camel_case_word = word:gsub("(_)([a-z])", function(_, l)
      return l:upper()
    end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
  else
    print("Not a snake_case or camelCase word")
  end
end

vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy relative path of current file" })

vim.keymap.set("n", "<leader>yr", vim.cmd.Cppath, { desc = "Copy relative path of current file", noremap = false })
vim.keymap.set("v", "<leader>cs", "'<, '>sort")
vim.keymap.set("n", "<leader>ctc", switch_case, { desc = "Toggle between snake_case and camelCase", noremap = true, silent = true })

vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

vim.keymap.set("n", "<leader>sr", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>hl", function()  harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon" })
vim.keymap.set("n", "<leader>ha", function()  harpoon:list():add() end, { desc = "Add current file to harpoon" })
vim.keymap.set("n", "<leader>hq", function()  harpoon:list():select(1) end, { desc = "Select harpoon 1" })
vim.keymap.set("n", "<leader>hw", function()  harpoon:list():select(2) end, { desc = "Select harpoon 2" })
vim.keymap.set("n", "<leader>he", function()  harpoon:list():select(3) end, { desc = "Select harpoon 3" })
vim.keymap.set("n", "<leader>hr", function()  harpoon:list():select(4) end, { desc = "Select harpoon 4" })

vim.keymap.set("n", "<leader>hp", function()  harpoon:list():prev() end, { desc = "Previous harpoon" })
vim.keymap.set("n", "<leader>hn", function()  harpoon:list():next() end, { desc = "Next harpoon" })
