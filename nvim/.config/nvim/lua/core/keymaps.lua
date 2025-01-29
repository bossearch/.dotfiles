local set = vim.keymap.set

set("n", "<leader><leader>r", "<cmd>w|source %<CR>", { desc = "Execute the current file" })

-- Resize window using <ctrl> arrow keys
set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
--
set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
set("n", "<leader>qq", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- windows
set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- tabs
set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
set("n", "<leader><tab>q", "<cmd>tabclose<cr>", { desc = "Close Tab" })
set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
set(
  "n",
  "<leader>hl",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- Add undo break-points
set("i", ",", ",<c-g>u")
set("i", ".", ".<c-g>u")
set("i", ";", ";<c-g>u")

--
--keywordprg
set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
set("v", "<", "<gv")
set("v", ">", ">gv")

-- commenting
set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
--
-- lazy
set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
--
-- new file
set("n", "<leader>nf", "<cmd>enew<cr>", { desc = "New File" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
-- set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
--
-- set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
-- set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Terminal Mappings
set("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- OIL
local oil = require("oil")
local detail = false

-- Set global variable when <leader>/ is pressed to indicate oil is opened in a new buffer
set("n", "<leader>/", function()
  vim.g.oil_open_in_buffer = true
  oil.open()
end, { desc = "Open parent directory with oil" })

-- For floating window, make sure the global variable is not set
set("n", "<leader>f/", function()
  vim.g.oil_open_in_buffer = false
  oil.toggle_float()
end, { desc = "Open parent directory with oil float" })

set("n", "<leader>d/", function()
  detail = not detail
  if detail then
    oil.set_columns({ "icon", "permissions", "size", "mtime" })
  else
    oil.set_columns({ "icon" })
  end
end, { desc = "Toggle file detail view" })
--
-- TELESCOPE
set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })
set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
set(
  "n",
  "<leader>fn",
  "<cmd>Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<cr>",
  { desc = "Fuzzy find files in config directory" }
)
set("n", "<space>fb", "<cmd>Telescope buffers<cr>", { desc = "Find available buffers" })

-- LSPCONFIG
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    opts.desc = "Show LSP references"
    set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to declaration"
    set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

    opts.desc = "Show LSP implementations"
    set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    opts.desc = "Show LSP type definitions"
    set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = "Go to next diagnostic"
    set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
  end,
})

-- SNACKS
local snacks = require("snacks")

set({ "n" }, "<leader>wm", function()
  snacks.zen.zoom()
end, { desc = "Toggle Window Zoom" })

set({ "n" }, "<leader>z", function()
  snacks.zen()
end, { desc = "Toggle Zen Mode" })

set({ "n" }, "<leader>lg", function()
  snacks.lazygit()
end, { desc = "Toggle Lazygit" })

set({ "n" }, "<leader>nn", function()
  snacks.notifier.show_history()
end, { desc = "Show Notification History" })

set({ "n" }, "<leader>nh", function()
  snacks.notifier.hide()
end, { desc = "Hide Notification" })

-- split terminal
set({ "n", "t" }, "<leader><CR>", function()
  snacks.terminal.toggle(nil, { win = { height = 0.5 } })
end, { desc = "Open Terminal On Split" })
-- floating terminal
set({ "n", "t" }, "<leader>f<CR>", function()
  snacks.terminal.toggle("zsh", {
    win = {
      width = 0.5, -- Width of the terminal
      height = 0.5, -- Height of the terminal
      border = "rounded", -- Sharp border style (use "double" if preferred)
    },
    cwd = vim.fn.getcwd(), -- Set the current working directory
  })
end, { desc = "Open Floating Terminal" })

if vim.lsp.inlay_hint then
  set({ "n" }, "<leader>ih", function()
    require("snacks").toggle.inlay_hints()
  end, { desc = "Toggle Inlay Hints" })
end

-- TROUBLE
set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open trouble workspace diagnostics" })
set(
  "n",
  "<leader>xd",
  "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
  { desc = "Open trouble document diagnostics" }
)
set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Open trouble quickfix list" })
set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" })
set("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" })

-- SUBSTITUTE
local substitute = require("substitute")

set("n", "s", substitute.operator, { desc = "Substitute with motion" })
set("n", "ss", substitute.line, { desc = "Substitute line" })
set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })

-- VIM-TMUX-NAVIGATOR
set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>")
