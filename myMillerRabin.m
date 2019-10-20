## Author: Dunbar Birnie <dubar@manjarobar>
## Created: 2019-10-19

#helper
function retval = myMillerRabin (n, k)
    if (n <= 2)
        retval = -1;
        return;
    endif
    d = n - 1;
    s = 0;
    while(mod(d,2)==0)
        d = d / 2;
        s = s + 1;
    endwhile
    assert((2**s)*d == n-1);
    for i = 1:k
        a = 2 + floor(rand*(n-3));
        x = powerMod(a, d, n); 
        if(x == 1 || x == n-1)
            retval = 1;
            return;
        endif
        while (d != n-1)
            x = mod( x*x, n );
            d = d * 2;
            if(x == 1)
              retval = 0;
              return;
            endif
            if(x == n-1)
              retval = 1;
              return;
            endif
        endwhile 
    endfor
    retval = 0;
endfunction

function ret = powerMod(x, y, p)
  ret = 1;
  x = mod(x, p);
  while( y > 0)
    if(mod(y, 2) == 1)
      ret = mod(ret * x,p);
      y = y - 1;
    endif
    y = y / 2;
    x = mod((x*x),p);
  endwhile 
endfunction
