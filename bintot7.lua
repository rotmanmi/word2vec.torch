file = torch.DiskFile(opt.binfilename,'r')
local max_w = 50


function readStringv2(file)  
	local str = {}
	for i = 1,max_w do
		local char = file:readChar()
		
		if char == 32 or char == 10 or char == 0 then
			break
		else
			str[#str+1] = char
		end
	end
	str = torch.CharStorage(str)
	return str:string()
end





--Reading Header
file:ascii()
words = file:readInt()
size = file:readInt()


local w2vvocab = {}
local v2wvocab = {}
local M = torch.FloatTensor(words,size)

--Reading Contents
file:binary()
for i = 1,words do
	local str = readStringv2(file)
	local vecrep = file:readFloat(300)
	vecrep = torch.FloatTensor(vecrep)
	local norm = torch.norm(vecrep,2)
	if norm ~= 0 then vecrep:div(norm) end
	w2vvocab[str] = i
	v2wvocab[i] = str
	M[{{i},{}}] = vecrep
end


--Writing Files
word2vec = {}
word2vec.M = M
word2vec.w2vvocab = w2vvocab
word2vec.v2wvocab = v2wvocab
torch.save(opt.outfilename,word2vec)
print('Writing t7 File for future usage.')



return word2vec


