function x = baza(sursa, b1, b2)
	if (b1 < 2 || b1 > 30 || b2 < 2 || b2 > 30)
		disp("Cel puţin una din bazele introduse nu este validă.")
		return
	endif
    if (b1 != 10)
        n = length(sursa);
        s_10 = 0; %sursa în bază 10
        p = 0; %putere
        for i = n : -1 : 1
			cifra = sursa(i);
			if isstrprop(cifra, 'alpha')
				cifra = toascii(upper(cifra)) - 55;
			else
				cifra = str2num(cifra);
			endif
            s_10 += cifra * (b1 ^ p);
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
    r = num2str(mod(s_10, b2));
    c = s_10;
    do
        x = strcat(x,r);
        c = idivide(c, b2);
        r = mod(c,b2);
        if (r >= 10)
        	r = char(r + 55);
        endif
        r = num2str(r);
    until(!c)
    x = flip(x);
endfunction