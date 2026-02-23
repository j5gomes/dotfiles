-- init.lua
vim.g.mapleader = " " -- Leader = Space
vim.opt.termguicolors = true -- Needed for modern themes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Set indentation to 4 spaces
vim.opt.tabstop = 4       -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4    -- Number of spaces used for autoindent
vim.opt.softtabstop = 4   -- Number of spaces per Tab when editing
vim.opt.expandtab = true  -- Use spaces instead of actual tab characters

-- Optional: enable autoindent
vim.opt.autoindent = true
vim.opt.smartindent = true

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
                view = { width = 30, side = "left", preserve_window_proportions = true },
                renderer = { icons = { show = { file = false, folder = false, git = false } } },
                update_focused_file = { enable = true, update_cwd = false },
                hijack_cursor = false,
                hijack_directories = { enable = true, auto_open = true },
                actions = { open_file = { quit_on_open = false, window_picker = { enable = false } } }
            }
        end
    },
    -- ===========================
    -- LazyGit integration
    -- ===========================
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = "LazyGit",
        config = function()
            vim.g.lazygit_floating_window_winblend = 0
            vim.g.lazygit_floating_window_scaling_factor = 0.9
        end
    },
    -- ===========================
    -- Persistence (auto session)
    -- ===========================
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {}, -- default options
        config = function()
            -- Automatically load last session if no file argument
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    if vim.fn.argc() == 0 then
                        require("persistence").load()
                    end
                end
            })
        end
    }
})

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

-- Toggle comment for selected lines (C/C++ style)
vim.keymap.set("v", "<leader>/", function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    -- Get the lines in the selection
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Determine if all lines are already commented
    local all_commented = true
    for _, line in ipairs(lines) do
        if not line:match("^%s*//") then
            all_commented = false
            break
        end
    end

    -- Toggle comment
    for i, line in ipairs(lines) do
        if all_commented then
            -- Uncomment
            lines[i] = line:gsub("^(%s*)//", "%1")
        else
            -- Comment
            lines[i] = "//" .. line
        end
    end

    -- Set the modified lines back
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end, {
    desc = "Toggle comment for selection"
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