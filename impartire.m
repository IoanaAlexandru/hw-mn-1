function [C r] = impartire(S, nr)
	r = 0; C = '';
	for i = [1 : length(S)]
		r = 10 * r + str2num(S(i));
		C(i) = num2str(idivide(r, nr));
		r = mod(r, nr);
	endfor
	%eliminarea zerourilor nesemnificative
	while (length(C) >= 1)
		if (C(1) == '0')
			C = C([2 : length(C)]);
		else
			break
		endif
	endwhile
endfunction