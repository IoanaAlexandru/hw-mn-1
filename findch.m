function x = findch(M, s, c)
    if (isempty(M))
        x = '*';
        return
    endif
    if (strcmp(M, c)(1))
        x = s;
        return
    endif
	s1 = strcat(s, '.');
	x = findch(M{2}, s1, c) ;
	if (x != '*')
		return
	endif
	s = strcat(s, '-');
	x = findch(M{3}, s, c) ;
endfunction