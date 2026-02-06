return {
  -- Testing Framework
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Vitest Adapter
      "marilari88/neotest-vitest",
      -- Playwright Adapter
      "thenbe/neotest-playwright",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end,                     desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Run current file" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Toggle test summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
    },
    config = function()
      local vitest_adapter = require("neotest-vitest")({})

      vitest_adapter.is_test_file = function(file_path)
        if file_path == nil then return false end
        for _, pattern in ipairs({
          "%.e2e%-spec%.ts$",
          "%.e2e%.ts$",
          "%.spec%.ts$",
          "%.test%.ts$",
        }) do
          if string.match(file_path, pattern) then
            return true
          end
        end
        return false
      end

      require("neotest").setup({
        adapters = {
          vitest_adapter,
          require("neotest-playwright").adapter({
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            },
          }),
        },
      })
    end,
  },
}
