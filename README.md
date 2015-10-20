## word2vec.torch7

WORD2VEC wrapper for Torch7.

### Installation
git clone https://github.com/rotmanmi/word2vec.torch

get the pre-trained word2vec binary file from:
https://code.google.com/p/word2vec/


Make sure you specify the location of the 'GoogleNews-vectors-negative300.bin' file in 'w2vutils.lua'. It is also suggested you specify a t7 file for fast access.



### [Tensor] word2vec(self,word,throwerror)
This function gets a word, and returns its word2vec representation, a tensor with the size 300. If throwerror is false (default) and the word doesn't exist it returns nil, otherwise, it will throw an exception.

### [table] distance(self,word,k)
This function returns the k-nearest neighbours to the given word. It returns a table with a list of words, and a corresponding list of cosine distances.


###Example
Getting the word2vec representation of the world 'Hello' and finding its k's nearest words.

```Lua

    local w2vutils = require 'w2vutils'
    local k = 3
    hellorep = w2vutils:word2vec('Hello')
    neighbors = w2vutils:distance(hellorep,k)
    

```