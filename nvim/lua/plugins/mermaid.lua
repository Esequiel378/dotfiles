-- Hover a ```mermaid block to render it as ASCII (mermaid-ascii).
return {
  {
    "Esequiel378/mermaid-hover.nvim",
    ft = "markdown",
    config = function()
      require("mermaid-hover").setup()
    end,
  },
}
