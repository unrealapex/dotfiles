if executable("prettier")
		setlocal  formatprg=prettier\ --stdin-filepath\ %
endif

