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

-- Netrw
vim.keymap.set("n", "<Leader>e", ":Ex<CR>")

-- Terminal
vim.keymap.set("n", "<Leader>ter", "<C-w>s10<C-w>+<C-w>j:terminal<CR>i")

-- Rust debug
vim.keymap.set("n", "<Leader>rri", "<C-w>jicargo run<CR>")
vim.keymap.set("n", "<Leader>rro", "<C-w>jicargo run<CR><C-\\><C-n><C-w>k")

-- Line numbers
vim.keymap.set("n", "<Leader>lr", function() vim.wo.relativenumber = true end)
vim.keymap.set("n", "<Leader>la", function() vim.wo.relativenumber = false end)
vim.wo.relativenumber = true
vim.wo.number = true

-- Scrolling
vim.o.scrolloff = 8

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

vim.cmd.colorscheme("catppuccin")
