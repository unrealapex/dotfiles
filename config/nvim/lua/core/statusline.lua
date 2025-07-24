local statusline = {
	"%<", -- truncate the filename if it's too long
	"%f", -- full path of the file
	"%h", -- help flag
	"%m", -- modified flag
	"%r", -- readonly flag
	"%=", -- separator
	"%{%v:lua.statusline_diagnostics()%}",
	"  ",
	"%-14.(%l,%c%V%)", -- line and column number with parentheses
	"%P", -- percentage through the file
}

function statusline_diagnostics()
	local count = vim.diagnostic.count(0)
	if #count == 0 then
		return ""
	end
	local infos = count[vim.diagnostic.severity.INFO] or 0
	local hints = count[vim.diagnostic.severity.HINT] or 0
	local errors = count[vim.diagnostic.severity.ERROR] or 0
	local warnings = count[vim.diagnostic.severity.WARN] or 0

	for _, hl in ipairs({ "DiagnosticInfo", "DiagnosticHint", "DiagnosticError", "DiagnosticWarn" }) do
		local def = vim.api.nvim_get_hl(0, { name = hl, link = false })
		vim.api.nvim_set_hl(0, "StatusLine" .. hl, {
			bg = def.fg,
			ctermbg = def.ctermfg,
		})
	end

	local infoicon = "%#StatusLineDiagnosticInfo#● %*"
	local hinticon = "%#StatusLineDiagnosticHint#● %*"
	local warnicon = "%#StatusLineDiagnosticWarn#● %*"
	local erroricon = "%#StatusLineDiagnosticError#● %*"
	local diagnostic_component = {}

	if hints > 0 then
		table.insert(diagnostic_component, hinticon .. hints)
	end
	if infos > 0 then
		table.insert(diagnostic_component, infoicon .. infos)
	end
	if warnings > 0 then
		table.insert(diagnostic_component, warnicon .. warnings)
	end
	if errors > 0 then
		table.insert(diagnostic_component, erroricon .. errors)
	end
	return table.concat(diagnostic_component, " ")
end

vim.o.statusline = table.concat(statusline, "")
