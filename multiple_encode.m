function x = multiple_encode(sir)
	words = strsplit(sir);
	[m n] = size(words);
	x = '';
	for i = 1 : n
		for j = 1 : length(words{i})
			x = cstrcat(x, morse_encode(words{i}(j)));
			x = cstrcat(x, " ");
		endfor
		x = cstrcat(x, " ");
	endfor
endfunction