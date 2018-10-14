function S = suma(A, B)
	if (length(B) > length(A))
		aux = B;
		B = A;
		A = aux;
	endif
	if (length(A) > length(B))
		n = (length(A) - length(B));
		B([(n + 1) : length(A)]) = B;
		B([1 : n]) = '0';
	endif
	T = 0; %transport
	for i = [length(A) : -1 : 1]
		aux = str2num(B(i)) + str2num(A(i)) + T;
		A(i) = num2str(mod(aux, 10));
		T = idivide(aux, 10);
	endfor
	if (T)
		A = strcat(num2str(T), A);
	endif
	S = A;
endfunction