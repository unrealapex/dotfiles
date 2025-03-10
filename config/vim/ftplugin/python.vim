if executable("black")
		" TODO: make this work on ranges instead of the whole file
		setlocal formatprg=black\ -q\ -\ <\ %
endif
