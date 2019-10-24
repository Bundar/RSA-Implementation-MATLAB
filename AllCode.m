%% Project CP 1 NetSec
%% Dunbar B and Philip J
%Driver Code for the encryption service.
function AllCode ()
  keys = getKeys();
  plainText = input("What is the original plain text to be encrypted?\n", 's');
  publicKey = keys(1, 1:2);
  privateKey = keys(2, 1:2);
  cipherText = encryption(publicKey, plainText);
  fprintf("The encrypted Message is: \n");
  for i = 1:length(cipherText)
    fprintf("%i ", cipherText(i));
  end
  select = input("\nWould you like to decrypt back? \n", 's');
  if select == "yes"
    pt = decryption(privateKey, cipherText);
    fprintf("The decrypted cipher text is: %s\n", char(pt));
  end
end

%% Returns Public and Private Keys
function keys = getKeys()
  pq = findTwoPrimes();
  p = pq(1);
  q = pq(2);
  n = p*q;
  ed = computeEandD(p, q);
  e = ed(1);
  d = ed(2);
  publicKey = [e, n];
  privateKey = [d, n];
  keys = [publicKey; privateKey];
end

%% Encrypts the given plain text using the generated public key.
function cipherArr = encryption ( publicKey, plainText)
  pt = double(plainText);
  e = publicKey(1);
  n = publicKey(2);
  cipherArr = zeros(length(plainText));
  for i = 1:length(pt)
    m = pt(i);
    cipherArr(i) = powerMod(m, e, n);
  end
end

%% Decrypts the given cipher text using the generated private key.
function plainText = decryption ( privateKey, cipherArr)
  d = privateKey(1);
  n = privateKey(2);
  plainText = zeros(length(cipherArr));
  for i = 1:length(cipherArr)
    m = cipherArr(i);
    plainText(i) = powerMod(m, d, n);
  end
end

%% Computes encrypt and decrypt exponents for public and private key gen.
function retval = computeEandD(p , q)
  totient = (p-1)*(q-1);
  e = 0;
  for k = 2:totient
    if(gcd(k, totient) == 1)
      e = k;
      break;
    end
  end
  
  d = extendedEuclidianAlgorithm(e, totient);
  retval = [e, d];
end

%% used to solve inverse mod problem to get d.
function inv = extendedEuclidianAlgorithm(e, totient)
  [~, ~, B] = gcd(totient, e);
  inv = totient + B;
  assert(mod(e*inv, totient) == 1);
  %printf("mod(e*inv, totient) == %i\n", mod(e*inv, totient));
end

%% Code to generate two random primes using miller rabin method.
function twoPrimes = findTwoPrimes()
  i = 1;
  %max = sqrt(realmax())-1;
  max = prevprime(sqrt(realmax()));
  twoPrimes = [0, 0];
  while(i < 3) 
    p = floor(rand()*max);
    if(myMillerRabin(p, 6) == 1)
      %p is a prime
      twoPrimes(i) = p;
      i = i + 1;
    end
  end
end

%% Miller Rabin code to check if a number is prime... probably.
function retval = myMillerRabin (n, k)
    if (n <= 2)
        retval = -1;
        return;
    end
    d = n - 1;
    s = 0;
    while(mod(d,2)==0)
        d = d / 2;
        s = s + 1;
    end
    assert((2^s)*d == n-1);
    for i = 1:k
        a = 2 + floor(rand*(n-3));
        x = powerMod(a, d, n); 
        if(x == 1 || x == n-1)
            retval = 1;
            return;
        end
        while (d ~= n-1)
            x = mod( x*x, n );
            d = d * 2;
            if(x == 1)
              retval = 0;
              return;
            end
            if(x == n-1)
              retval = 1;
              return;
            end
        end
    end
    retval = 0;
end

%% power mod function calculates powers of a base mod n so that it doesnt over flow the double precision.
function ret = powerMod(x, y, p)
  ret = 1;
  x = mod(x, p);
  while( y > 0)
    if(mod(y, 2) == 1)
      ret = mod(ret * x,p);
      y = y - 1;
    end
    y = y / 2;
    x = mod((x*x),p);
  end
end

