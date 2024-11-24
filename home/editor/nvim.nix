{ config, pkgs, ... }:

#let nvim = "programs.neovim";
#in
{
# Normal options
	programs.neovim.defaultEditor = true;
	programs.neovim.enable = true;

# Extra options
	programs.neovim.extraConfig = ''
		set tabstop=2
		set shiftwidth=2
		set number
		set relativenumber
		set clipboard+=unnamedplus

		let mapleader=" "
		" " Copy to clipboard
		vnoremap  <leader>y  "+y
		nnoremap  <leader>Y  "+yg_
		nnoremap  <leader>y  "+y
		nnoremap  <leader>yy  "+yy

		" " Paste from clipboard
		nnoremap <leader>p "+p
		nnoremap <leader>P "+P
		vnoremap <leader>p "+p
		vnoremap <leader>P "+P
		'';
}
