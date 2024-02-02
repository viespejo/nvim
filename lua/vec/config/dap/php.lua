local ok, dap = pcall(require, "dap")
if not ok then
	return
end

dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { vim.fn.stdpath("data") .. "/dap-adapters/vscode-php-debug/out/phpDebug.js" },
}

dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for Xdebug",
		port = 9000,
		stopOnEntry = false,
		serverSourceRoot = "/usr/share/nginx",
		localSourceRoot = "/home/its32ve1/code/www",
	},
}
