function x = multiple_decode(sir)
	letters = strsplit(sir);
	[m n] = size(letters);
	x = '';
	for i = 1 : n
		x = strcat(x, morse_decode(letters{i}));
	endfor
endfunction