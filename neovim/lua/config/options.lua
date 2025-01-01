vim.opt.number = true
vim.opt.relativenumber = true
vim.g.autoformat = false
vim.opt.spelllang = 'en_us'
vim.opt.spell = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
vim.api.nvim_set_option("clipboard","unnamed") -- To connect clipboard to default yank and paste register
