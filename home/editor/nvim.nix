{ config, pkgs, ... }:

let nvim = "programs.neovim";
in
{
	# Normal options
	programs.neovim.defaultEditor = true;
	programs.neovim.enable = true;

	# Custom lua lines
	programs.neovim.extraLuaConfig = ''
		-- General neovim settings and config

		local g = vim.g            -- Global variables
		local kmset = vim.keymap.set -- Sets keymap
		local opt = vim.opt        -- Set options (global/buffer/windows-scoped)		
		------------------------
		-- Global variables
		------------------------
		g.have_nerd_font = true			-- Enable nerdfont support	
		g.mapleader = " "						-- Map leader to space

		------------------------
		-- General
		------------------------
		opt.expandtab = true				-- Use spaces instead of tabs 
		opt.shiftwidth = 2					-- Shift 4 spaces when tab
		opt.smartindent = true			-- Autoindent new lines
		opt.tabstop = 2							-- One tab == 2 spaces

		opt.clipboard = 'unnamedplus'		-- Enable clipboard support
		opt.mouse = 'a'									-- Enable mouse support

		------------------------
		-- Neovim UI
		------------------------
		opt.colorcolumn = '80'      -- Line length marker at 80 columns
		opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
    opt.hlsearch = false        -- Disable highlight search staying
		opt.ignorecase = true       -- Ignore case letters when search
    opt.incsearch = true        -- Enable incremental search
		opt.laststatus=3            -- Set global statusline	
		opt.linebreak = true        -- Wrap on word boundary
		opt.number = true           -- Show line number
		opt.relativenumber = true   -- Set relative line number
    opt.scrolloff = 8           -- Always have X scrolled lines at bottom
		opt.showmatch = true        -- Highlight matching parenthesis
    opt.signcolumn = "yes"      -- Enables signs in the column
		opt.smartcase = true        -- Ignore lowercase for the whole pattern
		opt.splitbelow = true       -- Horizontal split to the bottom
		opt.splitright = true       -- Vertical split to the right
		opt.termguicolors = true    -- Enable 24-bit RGB colors
    opt.updatetime = 200        -- ms to wait for trigger an event
	
		------------------------
		-- Mappings
		------------------------
		-- Copy to clipboard
		kmset('n', '<leader>Y', '"+yg_')
		kmset('n', '<leader>y', '"+y')
		kmset('n', '<leader>yy', '"+yy')
		kmset('v', '<leader>y', '"+y')	

		-- Paste from clipboard
		kmset('n', '<leader>P', '"+P')
		kmset('v', '<leader>P', '"+P')

    -- Keep copied word in buffer when pasting, send overwritten word to void register
    kmset("x", "<leader>p", [["_dP]])

    -- Delete word to void register, don't override buffer
		kmset('n', '<leader>d', [["_d]])
		kmset('v', '<leader>d', [["_d]])

    -- When in visual mode, allows moving highlighted lines
    kmset("v", "J", ":m '>+1<CR>gv=gv")
    kmset("v", "K", ":m '<-2<CR>gv=gv")

    -- Keep cursor centered when half page jumping
    kmset("n", "<C-d>", "<C-d>zz")
    kmset("n", "<C-u>", "<C-u>zz")

    -- Keep cursor in the middle when searching
    kmset("n", "n", "nzzzv")
    kmset("n", "N", "Nzzzv")

	''; 
}
