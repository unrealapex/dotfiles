setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" FIXME: stylua does not work well with gq formatting
if executable("stylua")
		setlocal formatprg=stylua\ %
endif
