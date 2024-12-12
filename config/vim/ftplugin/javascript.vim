if executable("prettier")
		setlocal  formatprg=prettier\ --write\ --stdin-filepath\ %
endif

