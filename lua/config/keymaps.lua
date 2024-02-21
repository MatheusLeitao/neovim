-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local discipline = require("mathleitao.discipline")
-- discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- keymap.del("n", "<A-j>") -- Delete lazyvim mapping
keymap.del("n", "s") -- Delete lazyvim mapping
-- keymap.del("n", "<F2>") -- Delete lazyvim mapping
--
-- keymap.set("n", "<A-k>", ":m .1<CR>==") -- move line down(n)
-- keymap.set("n", "<A-j>", ":m .+4<CR>==") -- move line up(n)
-- keymap.set("v", "<A-j>", ":m '>+4<CR>gv=gv") -- move line up(v)
-- keymap.set("v", "<A-k>", ":m '<1<CR>gv=gv") -- move line down(v)

keymap.set("n", "<C-b>", vim.cmd.Ex)
keymap.set("v", "<C-b>", vim.cmd.Ex)
keymap.set("i", "<C-b>", vim.cmd.Ex)

keymap.set("n", "J", "mzJ`z")

keymap.set("n", "<F2>", "haa")

keymap.set("n", "db", "vb_d") -- Delete Backwards

keymap.set("n", "<C-a>", "gg<S-v>G") -- Select all

keymap.set("n", "<C-m>", "<C-i>", opts) -- Jumplist

-- Increment/Decrement
keymap.set({ "n" }, "+", "<C-a>")
keymap.set({ "n" }, "-", "<C-x>")

-- Tab management
keymap.set("n", "<C-t>", ":tabedit<CR>", opts)
keymap.set("n", "<s-tab>", ":tabnext<CR>", opts)
-- keymap.set("n", "<C-S-Tab>", ":tabprev<CR>", opts)

-- Split window
keymap.set("n", "sS", ":vsplit<CR>", opts)
keymap.set("n", "<A-q>", "<C-w>h", opts)
keymap.set("n", "<A-e>", "<C-w>l", opts)

-- Diagnostis
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end)

keymap.set("i", "<C-BS>", "db")
-- keymap.set("i", "<C-s>", "<C-o>:w<CR>")
-- keymap.set("n", "<C-s>", "<C-o>:w<CR>")

-- keymap.set("n", "<C-t>", ":lua ToggleQuotes()<CR>", { desc = "Apenas um teste" })
