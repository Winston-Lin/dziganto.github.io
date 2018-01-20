---
published: false
title: Caesar Cipher
categories: [Cipher, Cryptography, Python]
---

![image](/assets/images/code_talkers.png?raw=true){: .center-image }

## Introduction
There are myriad ways to encrypt text. One of the simplest and easiest to understand is the **Caesar cipher**. It's extremely easy to crack but it's a great place to start for the purposes of introducing ciphers.

## A Bit of Terminology
The setup is pretty simple. You start with a message that you want to codify so someone else cannot read it. Say the message is `I hope you cannot read this`. This is called the **plaintext**. Now we need to apply some algorithm to our text so the output is incoherent. For example, the output may be `O nuvk eua igttuz xkgj znoy`. This is called the **ciphertext**. Mapping the plaintext to ciphertext is called **encryption**. Mapping the ciphertext back to plaintext is called **decryption**. The algorithm used to encrypt or decrypt is called a **cipher**. 

## Caesar Cipher: How it Works
Mapping `I hope you cannot read this` to `O nuvk eua igttuz xkgj znoy` with the Caesar cipher works like this. First, you start by deciding how much you want to shift the alphabet. Say you choose a shift of six so A becomes G, B becomes H, C becomes I, and so on until you get to the end where Z becomes F. Now you have a way to map any plaintext character to ciphertext. In fact, that's exactly how I encoded this message: 

> plaintext: I hope you cannot read this.  
> ciphertext: O nuvk eua igttuz xkgj znoy.

Here's a gif that shows the various mappings:

![Caesar Cipher gif](https://i.stack.imgur.com/D3ypD.gif){: .center-image }

The outer circle represents plaintext letters while the inner circle represents the ciphertext equivalent. 

Hopefully you can see right away why this particular cipher is very easy to crack. It includes capitalization and the words are clearly split. By converting all the text to lowercase and removing all spaces, we can make it a bit more difficult. But that barely increases the challenge. There are only 25 different ways to shift the letters, which means a brute force attack is trivial.

Let's see what this looks like in code. 

## The Code 

We'll create a class called **CaesarCipher** that can encrypt or decrypt text.

```
class CaesarCipher:
    
    
    def _clean_text(self, text):
        '''converts text to lowercase, removes spaces, and removes punctuation.'''
        import string
        assert type(text) == str, 'input needs to be a string!'
        text = text.lower()
        text = text.replace(' ', '')
        self.clean_text = "".join(character for character in text 
                                  if character not in string.punctuation)
        return self.clean_text
    
    
    def _string2characters(self, text):
        '''converts a string to individual characters.'''
        assert type(text) == str, 'input needs to be a string!'
        self.str2char = list(text)
        return self.str2char
    
    
    def _chars2nums(self, characters):
        '''converts individual characters to integers.'''
        assert type(characters) == list, 'input needs to be a list of characters!'
        codebook = {'a':0, 'b':1, 'c':2, 'd':3, 'e':4, 'f':5, 'g':6, 'h':7, 'i':8, 'j':9,
               'k':10, 'l':11, 'm':12, 'n':13, 'o':14, 'p':15, 'q':16, 'r':17, 's':18,
               't':19, 'u':20, 'v':21, 'w':22, 'x':23, 'y':24, 'z':25}
        for i, char in enumerate(characters):
            try:
                characters[i] = codebook[char]
            except:
                pass
        self.char2num = characters
        return self.char2num
    
    
    def _nums2chars(self, numbers):
        '''converts individual integers to characters .'''
        assert type(numbers) == list, 'input needs to be a list of numbers!'
        codebook = {0:'a', 1:'b', 2:'c', 3:'d', 4:'e', 5:'f', 6:'g', 7:'h', 8:'i', 9:'j',
               10:'k', 11:'l', 12:'m', 13:'n', 14:'o', 15:'p', 16:'q', 17:'r', 18:'s',
               19:'t', 20:'u', 21:'v', 22:'w', 23:'x', 24:'y', 25:'z'}
        for i, num in enumerate(numbers):
            try:
                numbers[i] = codebook[num]
            except:
                pass
        self.num2chars = numbers
        return self.num2chars
    
    
    def _preprocessing(self, text):
        ''''''
        clean_text = self._clean_text(text)
        list_of_chars = self._string2characters(clean_text)
        list_of_nums = self._chars2nums(list_of_chars)
        return list_of_nums
   
   
    def encrypt(self, text, shift=3):
        '''return text that is shifted according to user's input.'''
        import numpy as np
        preprocess = self._preprocessing(text)
        nums_shifted = list((np.array(preprocess) + shift) % 26)
        return ''.join(self._nums2chars(nums_shifted))
    
    
    def decrypt(self, text, shift=3):
        '''returns text shifted by user-defined shift length.'''
        import numpy as np
        preprocess = self._preprocessing(text)
        nums = self._chars2nums(preprocess)
        num_shift = list((np.array(nums) - shift) % 26)
        return ''.join(self._nums2chars(num_shift))
```

## Code Breakdown
The **CaesarCipher** class contains a number of methods. The first is a method called **_clean_text** which makes all letters lower case, removes spaces, and removes punctuation. The second, third, and fourth methods called **_string2characters**, **_chars2nums**, and **_nums2chars** should be self-explanatory. The **_preprocessing** method is a meta-function that incorporates and applies all the aforementioned methods in one sequential process. The last two methods are the most interesting: **encrypt** and **decrypt**. They perform as advertised. 

## Setup

Great, now let's instantiate our class and put it through its paces. 

To instantiate, we're merely type `cc = CaesarCipher()`. 

Noew to encrypt a message: `print(cc.encrypt('I hope you cannot read this.', shift=6))`.

The *shift* parameter tells the class by how much to shift the letters to encrypt the plaintext. In this case I arbitrarily chose 6. The output is `onuvkeuaigttuzxkgjznoy`. That sure doesn't look like anything I can make out. 

Let's try another one for fun. This one will showcase the preprocessing method in all its glory.

```
text = 'the QuIcK brown fox jumps over the lazy dog!'
encrypted = cc.encrypt(text, shift=5)
print(encrypted)
```

The output is `ymjvznhpgwtbsktcozruxtajwymjqfeditl`.

## Discussion

Now if you've given this a little thought, you can still see a way to crack this cipher wide open. Did you notice that certain letters repeat more often. With a little knowledge of the English language, for example the frequency of each letter, we can deduce plaintext-to-ciphertext letter mappings. 

![Letter Frequency](/assets/images/letter_frequency.png?raw=true){: .center-image }

The letter *e* is the most common letter in the English language. Using that fact alone can help us break the Caesar cipher given enough text. Another giveaway is double letters. Only so many double letter pairings exist, so that's yet another way of deducing plaintext-to-cipher mappings. If all else fails or you just want to find the answer very quickly, a brute force search will expose the plaintext with little effort. 

Let's see how that works.

```
# show all decryption possibilities
for i in range(1,26):
    print('shift{:2}: {}'.format(i, cc.decrypt(encrypted, shift=i)))
    print('')
```

Which outputs:

```
shift 1: xliuymgofvsarjsbnyqtwszivxlipedchsk

shift 2: wkhtxlfneurzqiramxpsvryhuwkhodcbgrj

shift 3: vjgswkemdtqyphqzlworuqxgtvjgncbafqi

shift 4: uifrvjdlcspxogpykvnqtpwfsuifmbazeph

shift 5: thequickbrownfoxjumpsoverthelazydog

shift 6: sgdpthbjaqnvmenwitlornudqsgdkzyxcnf

shift 7: rfcosgaizpmuldmvhsknqmtcprfcjyxwbme

shift 8: qebnrfzhyoltkclugrjmplsboqebixwvald

shift 9: pdamqeygxnksjbktfqilokranpdahwvuzkc

shift10: oczlpdxfwmjriajsephknjqzmoczgvutyjb

shift11: nbykocwevliqhzirdogjmipylnbyfutsxia

shift12: maxjnbvdukhpgyhqcnfilhoxkmaxetsrwhz

shift13: lzwimauctjgofxgpbmehkgnwjlzwdsrqvgy

shift14: kyvhlztbsifnewfoaldgjfmvikyvcrqpufx

shift15: jxugkysarhemdvenzkcfieluhjxubqpotew

shift16: iwtfjxrzqgdlcudmyjbehdktgiwtaponsdv

shift17: hvseiwqypfckbtclxiadgcjsfhvszonmrcu

shift18: gurdhvpxoebjasbkwhzcfbiregurynmlqbt

shift19: ftqcguowndaizrajvgybeahqdftqxmlkpas

shift20: espbftnvmczhyqziufxadzgpcespwlkjozr

shift21: droaesmulbygxpyhtewzcyfobdrovkjinyq

shift22: cqnzdrltkaxfwoxgsdvybxenacqnujihmxp

shift23: bpmycqksjzwevnwfrcuxawdmzbpmtihglwo

shift24: aolxbpjriyvdumveqbtwzvclyaolshgfkvn

shift25: znkwaoiqhxuctludpasvyubkxznkrgfejum

```

A quick scan gives away the plaintext: `shift 5: thequickbrownfoxjumpsoverthelazydog`. 

## Wrap Up

Hopefully you found this a fun introduction to cryptography. It's a rich and rewarding field with endless applications. Next time, we'll build upon what we learned here as we explore a more challenging cipher known as the **Vigenere cipher**.
