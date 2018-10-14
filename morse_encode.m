function x = morse_encode(c)
	c = upper(c);
	M = morse;
	x = findch(M, '', c);
endfunction