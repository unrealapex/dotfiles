if executable("black")
		" NOTE: this only works on the whole file instead of ranges 
		setlocal formatprg=black\ -q\ -\ <\ %
endif
