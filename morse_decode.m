function x = morse_decode(sir)
    x = morse();
    [m n] = size(sir);
    for i = 1 : n
        %if we already reached the end of the tree by this point,
        %the string is invalid
        if (isempty(x))
            x = '*';
            return
        endif
        %if not, we continue with the decoding
        if (sir(i) == '.')
            x = x{2};
        else
            if (sir(i) == '-')
                x = x{3};
            else %any character other than '.' or '-'
                x = '*';
                return
            endif
        endif
    endfor
    x = x{1};
endfunction