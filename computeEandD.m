## Author: Dunbar Birnie <dubar@manjarobar>
## Created: 2019-10-19

function retval = computeEandD (p , q)
  n = p*q;
  
  totient = (p-1)*(q-1);
  e = 0;
  for k = 2:totient
    if(gcd(k, totient) == 1)
      e = k;
      break;
    endif
  endfor
  
  d = extendedEuclidianAlgorithm(e, totient);
  retval = [e, d];
endfunction


function inv = extendedEuclidianAlgorithm(e, totient)
  [G, A, B] = gcd(totient, e)
##  if(B < 0)
##    inv = totient + B
##  else
##    inv = totient - B
##  endif
  inv = totient + B
  assert(mod(e*inv, totient) == 1)
  printf("mod(e*inv, totient) == %i\n", mod(e*inv, totient))
  
endfunction


