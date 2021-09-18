-- TODO: proper gruvbox

return function(lush) 
  local hsl = lush.hsl
  return {
    -- Define Vim's Normal highlight group
    Normal { bg = hsl(20, 18, 9), fg = hsl(208, 80, 80) },

    -- Make whitespace slightly darker than normal.
    -- you must define Normal before deriving from it.
    Whitespace { fg = Normal.fg.darken(40) },

    -- Make comments look the same as whitespace, but with italic text
    Comment { Whitespace, gui="italic" },

    -- Clear all highlighting for CursorLine
    CursorLine { },
  }
end
