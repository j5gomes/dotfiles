-- init.lua
-- ===========================
-- Basic Windows Neovim Setup
-- ===========================
vim.g.mapleader = " " -- Leader = Space
vim.opt.termguicolors = true -- Needed for modern themes

-- ===========================
-- lazy.nvim setup
-- ===========================
local lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ -- ===========================
-- Theme: naysayer-colors
-- ===========================
{
    "whizikxd/naysayer-colors.nvim",
    lazy = false,
    config = function()
        vim.cmd.colorscheme("naysayer")
    end
}, -- ===========================
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
}, -- ===========================
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

-- Window navigation (Emacs style)
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

-- Optional: open a file in vertical split from anywhere
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", {
    desc = "Vertical split current buffer"
})

-- LazyGit keymap
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", {
    desc = "Open LazyGit"
})

-- ===========================
-- nvim-tree split behavior
-- ===========================
-- Press 'v' or 's' in the explorer to open new files in vertical/horizontal split
-- They will open **to the right or below your main buffer**, not next to the explorer

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
