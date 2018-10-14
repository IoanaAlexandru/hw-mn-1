function Z = zigzag(n)
    Z = zeros(n);
    i = 1;
    j = 1;
    count = 0;
    %dir - direcţia: 1 dacă în sus, 0 dacă în jos
    while (count < n^2)
        Z(i, j) = count++;
        if (i == 1)
            if (mod(j, 2) != 0)
                j++;
                dir = 0;
            else
                i++;
                j--;
            endif
        else
            if (i == n)
                if (mod(j, 2) != 0)
                    j++;
                    dir = 1;
                else
                    i--;
                    j++;
                endif
            else
                if (j == 1)
                    if (mod(i, 2) == 0)
                        i++;
                        dir = 1;
                    else
                        i--;
                        j++;
                    endif
                else
                    if (j == n)
                        if (mod(i, 2) == 0)
                            i++;
                            dir = 0;
                        else
                            i++;
                            j--;
                        endif
                    else
                        if (dir) %sus
                            i--;
                            j++;
                        else %jos
                            i++;
                            j--;
                        endif
                    endif
                endif
            endif
        endif
    endwhile
endfunction