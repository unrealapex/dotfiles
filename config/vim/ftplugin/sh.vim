setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

if executable("shfmt")
		setlocal formatprg="shfmt --indent 2"
endif
