setlocal cindent
setlocal cinoptions=(0
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
" setlocal path+=/usr/include/**,/usr/local/include/**"

if executable("clang-format")
		setlocal formatprg=clang-format
endif

