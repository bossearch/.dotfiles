return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*", -- Enable colorizer for all file types
    }, {
      RGB = true, -- Enable #RGB hex codes
      RRGGBB = true, -- Enable #RRGGBB hex codes
      names = true, -- Enable color names like Blue, Red, etc.
      RRGGBBAA = true, -- Enable #RRGGBBAA hex codes with alpha
      rgb_fn = true, -- Enable CSS rgb() and rgba() functions
      hsl_fn = true, -- Enable CSS hsl() and hsla() functions
      css = true, -- Enable all CSS color features
      css_fn = true, -- Enable CSS *functions* like rgb() and hsl()
      mode = "background", -- Set the display mode to background
    })
  end,
}
