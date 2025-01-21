vim.opt.number = true
vim.opt.relativenumber = true
vim.g.autoformat = false
vim.opt.spelllang = 'en_us'
vim.opt.spell = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "ExtraGroup" })
vim.api.nvim_set_option("clipboard","unnamed") -- To connect clipboard to default yank and paste register
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
