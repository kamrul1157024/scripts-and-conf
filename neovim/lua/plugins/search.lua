return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")
      telescope.setup({
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "ivy",
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
              n = {
                ["dd"] = "delete_buffer",
              },
            },
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = false, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                -- freeze the current list and start a fuzzy search in the frozen list
                ["<C-space>"] = lga_actions.to_fuzzy_refine,
              },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
          },
        },
      })
      telescope.load_extension("live_grep_args")
      local builtin = require("telescope.builtin")
      local opts = require("telescope.themes").get_ivy({
        layout_config = {
          height = 40,
        },
      })
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files(opts)
      end, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>/", function()
        builtin.live_grep(opts)
      end, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>sw", function()
        builtin.grep_string(opts)
      end, { noremap = true })
      vim.keymap.set("v", "<leader>sw", function()
        builtin.grep_string(opts)
      end, { noremap = true })
      vim.keymap.set("n", "<leader>,", function()
        builtin.buffers(opts)
      end, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", function()
        builtin.help_tags(opts)
      end, { desc = "Telescope help tags" })
      vim.keymap.set("n", "<leader>sh", function()
        builtin.search_history(opts)
      end, { desc = "Telescope search history" })
      vim.keymap.set("n", "<leader>fr", function()
        builtin.search_history(opts)
      end, { desc = "Telescope recent files" })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  },
}
