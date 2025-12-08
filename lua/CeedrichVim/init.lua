local function init()
	require("CeedrichVim.theme")
	require("CeedrichVim.options")
	require("CeedrichVim.tools")
	require("CeedrichVim.plugins")
	require("CeedrichVim.keymaps")
	require("CeedrichVim.lsp")
	require("CeedrichVim.none-ls")
	require("CeedrichVim.completion")
end

return {
	init = init,
}
