setlocal expandtab

if executable("prettier")
		setlocal formatprg="prettier --write --prose-wrap always --stdin-filepath %"
endif

