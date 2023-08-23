return {
	setup = function(lspconfig, lsp)
		lspconfig.clangd.setup({
			on_attach = function()
			end,
			cmd = { 'clangd', '--background-index' },
			filetypes = { 'c', 'cpp' },
		})
	end
}
