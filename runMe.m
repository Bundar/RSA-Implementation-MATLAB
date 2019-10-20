keys = getKeys();
plainText = input('What is the original plain text to be encrypted?\n');
publicKey = keys(1);
privateKey = keys(2);
cipherText = encryption(publicKey, plainText);
printf("The encrypted Message is: %s\n", char(cipherText));

select = input("Would you like to decrypt back? \n");
if (select == 'yes')
  pt = decryption(privateKey, cipherText);
  printf("The decrypted cipher text is: %s\n", char(pt));
endif
