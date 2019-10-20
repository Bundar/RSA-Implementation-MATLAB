## Author: Dunbar Birnie <dubar@manjarobar>
## Created: 2019-10-19

function twoPrimes = findTwoPrimes()
  i = 1;
  twoPrimes = [0, 0];
  while(i < 3)
    p = floor(rand()*10000);
    if(myMillerRabin(p, 6) == 1)
      #p is a prime
      twoPrimes(i) = p;
      i = i + 1;
    endif
  endwhile
endfunction

