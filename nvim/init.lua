-- init.lua
vim.g.mapleader = " " -- Leader = Space
vim.opt.termguicolors = true -- Needed for modern themes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- ===========================
-- lazy.nvim setup
-- ===========================
local lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ 
-- ===========================
-- Theme: naysayer-colors
-- ===========================
{
    "whizikxd/naysayer-colors.nvim",
    lazy = false,
    config = function()
        vim.cmd.colorscheme("naysayer")
    end
}, 
-- ===========================
-- File Explorer: nvim-tree
-- ===========================
{
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup {
            view = {
                width = 30,
                side = "left", -- sidebar on left
                preserve_window_proportions = true
            },
            renderer = {
                icons = {
                    show = {
                        file = false,
                        folder = false,
                        git = false
                    }
                }
            },
            update_focused_file = {
                enable = true,
                update_cwd = false
            },
            hijack_cursor = false,
            hijack_directories = {
                enable = true,
                auto_open = true
            },
            actions = {
                open_file = {
                    quit_on_open = false, -- keep explorer open
                    window_picker = {
                        enable = false
                    } -- avoid picking explorer
                }
            }
        }
    end
}, 
-- ===========================
-- LazyGit integration
-- ===========================
{
    "kdheepak/lazygit.nvim",
    lazy = true, -- load on demand
    cmd = "LazyGit",
    config = function()
        vim.g.lazygit_floating_window_winblend = 0
        vim.g.lazygit_floating_window_scaling_factor = 0.9
    end
}})

-- ===========================
-- Keymaps
-- ===========================

-- Toggle explorer
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {
    desc = "Toggle file explorer"
})

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {
    desc = "Focus left"
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
    desc = "Focus down"
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
    desc = "Focus up"
})
vim.keymap.set("n", "<C-l>", "<C-w>l", {
    desc = "Focus right"
})

-- Splitting windows with leader + w
vim.keymap.set("n", "<leader>w", "<cmd>vsplit<cr>", {
    desc = "Vertical split"
})

-- Close buffer with leader + q
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>", {
    desc = "Close current buffer"
})

-- LazyGit keymap
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", {
    desc = "Open LazyGit"
})

-- <leader>h → go to first non-blank character (_)
vim.keymap.set("n", "<leader>h", "_", {
    desc = "Go to first non-blank character"
})

-- <leader>l → go to end of line ($)
vim.keymap.set("n", "<leader>l", "$", {
    desc = "Go to end of line"
})

-- <leader>H → show LSP hover (definition preview equivalent)
vim.keymap.set("n", "<leader>H", vim.lsp.buf.hover, {
    desc = "Show hover documentation"
})

-- j → gj (move by visual line when wrapped)
vim.keymap.set("n", "j", "gj", {
    desc = "Move down by visual line"
})

-- k → gk (move up by visual line when wrapped)
vim.keymap.set("n", "k", "gk", {
    desc = "Move up by visual line"
})

-- ===========================
-- Auto header for new C++ files with filename and date
-- ===========================
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = {"*.cpp", "*.h"},
    callback = function()
        local filename = vim.fn.expand("%:t") -- current file name
        local today = os.date("%Y-%m-%d") -- current date

        local header = string.format([[
/*======================================================================
 * $File: %s $
 * $Date: %s $
 * $Revision: $
 * $Creator: j5gomes $
 * $Notice: (C) Copyright 2026 by j5gomes, Inc. All Rights Reserved. $
======================================================================== */
]], filename, today)

        vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(header, "\n"))

        -- Move cursor to $Revision: $ line for editing
        vim.api.nvim_win_set_cursor(0, {4, 12})
    end
})
