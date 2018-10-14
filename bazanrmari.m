function x = bazanrmari(sursa, b1, b2)
	if (b1 < 2 || b1 > 30 || b2 < 2 || b2 > 30)
		disp("Cel puţin una din bazele introduse nu este validă.")
		return
	endif
    if (b1 != 10)
        n = length(sursa);
        s_10 = '0'; %sursa în bază 10
        p = 0; %putere
        for i = n : -1 : 1
			cifra = sursa(i);
			if isstrprop(cifra, 'alpha')
				cifra = toascii(upper(cifra)) - 55;
			else
				cifra = str2num(cifra);
			endif
			s = num2str(cifra);
			for j = [1 : p]
				s = inmultire(s, b1);
			endfor
			s_10 = suma(s_10, s);
            p++;
        endfor
    else
        s_10 = str2num(sursa);
    endif
    if (b2 == 10)
        x = s_10;
        return
    endif
    x = '';
    c = s_10
    do
        [c r] = impartire(c, b2);
        if (r >= 10)
        	r = char(r + 55);
        endif
        r = num2str(r);
        x = strcat(x,r);
    until(c == '0')
    x = flip(x);
endfunction