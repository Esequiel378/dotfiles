return {
  {
    "kevalin/mermaid.nvim",
    ft = "mermaid",
    cmd = { "MermaidPreview", "MermaidFormat" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("mermaid").setup()
    end,
  },
}
