## Author: Dunbar Birnie <dubar@manjarobar>
## Created: 2019-10-20

function keys = getKeys()
  pq = findTwoPrimes();
  p = pq(1)
  q = pq(2)
  n = p*q
  ed = computeEandD(p, q)
  e = ed(1);
  d = ed(2);
  publicKey = [e, n];
  privateKey = [d, n];
  keys = [publicKey, privateKey];
endfunction

function cipherArr = encryption ( publicKey, plainText)
  pt = double(plainText);
  e = publicKey(1);
  n = publicKey(2);
  for i = 1:length(pt)
    m = pt(i);
    cipherArr(i) = mod(m**e, n);
  endfor
endfunction

function plainText = decryption ( privateKey, cipherArr)
  d = privateKey(1);
  n = publicKey(2);
  for i = 1:length(cipherArr)
    m = cipherArr(i);
    plainText(i) = mod(m**d, n);
  endfor
endfunction
