function X = inmultire(S, nr)
	T = 0;
	for i = [length(S) : -1 : 1]
		aux = nr * str2num(S(i)) + T;
		X(i) = num2str(mod(aux, 10));
		T = idivide(aux, 10);
	endfor
	if (T)
		X = strcat(num2str(T), X);
	endif
endfunction