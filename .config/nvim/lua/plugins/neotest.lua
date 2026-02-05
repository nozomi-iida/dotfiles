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
      require("neotest").setup({
        adapters = {
          require("neotest-vitest"),
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
