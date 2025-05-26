-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Terminal escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Copying
vim.keymap.set("v", "<Leader>y", "\"+y")
vim.keymap.set("n", "<Leader>p", "\"+p")

-- File explorer
vim.keymap.set("n", "<Leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Terminal
vim.keymap.set("n", "<Leader>ter", "<C-w>s10<C-w>+<C-w>j:terminal<CR>i")

-- Rust debug
vim.keymap.set("n", "<Leader>rrri", "<C-w>jicargo run<CR>")
vim.keymap.set("n", "<Leader>rrro", "<C-w>jicargo run<CR><C-\\><C-n><C-w>k")

-- C++ meson debug
vim.keymap.set("n", "<Leader>rrm", "<C-W>jimeson compile -Cbuilddir<CR><C-\\><C-n><C-w>k")
vim.keymap.set("n", "<Leader>rrex", "<C-W>jibuilddir\\program.exe<CR><C-\\><C-n><C-w>k")

-- Line numbers
vim.keymap.set("n", "<Leader>lr", function() vim.wo.relativenumber = true end)
vim.keymap.set("n", "<Leader>la", function() vim.wo.relativenumber = false end)
vim.wo.relativenumber = true
vim.wo.number = true

-- Scrolling
vim.o.scrolloff = 8

-- Set tabs to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    {"catppuccin/nvim", name = "catppuccin"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"stevearc/oil.nvim"}
  },
})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	}
})
require("catppuccin").setup({
	flavour = "mocha"
})

require("oil").setup()

vim.cmd.colorscheme("catppuccin")
