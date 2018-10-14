%mod without 0
function x = nmod(m, n)
  x = mod(m,n);
  if (!x)
    x = n;
  endif
endfunction