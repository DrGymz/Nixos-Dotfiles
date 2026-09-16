vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.diagnostic.config({
	virtual_text     = true,
	update_in_insert = false,
	severity_sort    = true,
	signs            = {
		text = {
			[vim.diagnostic.severity.ERROR] = '✘',
			[vim.diagnostic.severity.WARN]  = '▲',
			[vim.diagnostic.severity.HINT]  = '⚑',
			[vim.diagnostic.severity.INFO]  = '»',
		},
	},
})

local orig = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts            = opts or {}
	opts.border     = opts.border or 'rounded'
	opts.max_width  = opts.max_width or 80
	opts.max_height = opts.max_height or 24
	opts.wrap       = opts.wrap ~= false
	return orig(contents, syntax, opts, ...)
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then return end

		local buf = args.buf
		local map = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf })
		end

		map('n', 'K', vim.lsp.buf.hover)
		map('n', 'gd', vim.lsp.buf.definition)
		map('n', 'gD', vim.lsp.buf.declaration)
		map('n', 'gi', vim.lsp.buf.implementation)
		map('n', 'go', vim.lsp.buf.type_definition)
		map('n', 'gr', vim.lsp.buf.references)
		map('n', 'gs', vim.lsp.buf.signature_help)
		map('n', 'gl', vim.diagnostic.open_float)
		map('n', '<F2>', vim.lsp.buf.rename)
		map({ 'n', 'x' }, '<F3>', function()
			vim.lsp.buf.format({ async = true })
		end)
		map('n', '<F4>', vim.lsp.buf.code_action)

		if client:supports_method('textDocument/inlayHint') then
			vim.lsp.inlay_hint.enable(true, { bufnr = buf })
			map('n', '<F5>', function()
				vim.lsp.inlay_hint.enable(
					not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }),
					{ bufnr = buf }
				)
			end)
		end

		if client:supports_method('textDocument/documentHighlight') then
			local hl = vim.api.nvim_create_augroup('my.lsp.highlight', { clear = false })

			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				buffer = buf,
				group = hl,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = buf,
				group = hl,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = buf,
				group = vim.api.nvim_create_augroup('my.lsp.format', { clear = false }),
				callback = function()
					vim.lsp.buf.format({
						bufnr = buf,
						id = client.id,
						timeout_ms = 1000,
					})
				end,
			})
		end
	end,
})

-- Lua
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			hint = { enable = true },
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file('', true),
			},
			telemetry = { enable = false },
		},
	},
}

-- C / C++
vim.lsp.config.clangd = {
	init_options = {
		fallbackFlags = { '-std=c++23' },
	},
}

-- Nix
vim.lsp.config.nil_ls = {
	settings = {
		['nil'] = {
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
}

vim.lsp.enable({
	'lua_ls',
	'clangd',
	'pyright',
	'nil_ls',
	'jdtls',
	'rust_analyzer',
})
