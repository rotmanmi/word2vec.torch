torch.setdefaulttensortype('torch.FloatTensor')

cmd = torch.CmdLine()
cmd:text('Options')
cmd:option('-binfilename','/home/rotmanmi/Data/GoogleNews-vectors-negative300.bin','Name of the bin file.')
cmd:option('-outfilename','/home/rotmanmi/Data/word2vec.t7','Name of the output t7 file.')
opt = cmd:parse(arg)
w2vutils = {}
if not paths.filep(opt.outfilename) then
	w2vutils = require('bintot7.lua')
else
	w2vutils = torch.load(opt.outfilename)
	print('Done reading word2vec data.')
end


w2vutils.distance = function (self,vec,k)
	local k = k or 1	
	self.zeros = self.zeros or torch.zeros(self.M:size(1));
	local distances = torch.addmv(self.zeros,self.M ,vec)
	local norm = vec:norm(2)
	distances:div(norm)
	distances , oldindex = torch.sort(distances,1,true)
	local returnwords = {}
	local returndistances = {}
	for i = 1,k do
		table.insert(returnwords, w2vutils.v2wvocab[oldindex[i]])
		table.insert(returndistances, distances[i])
	end
	return returndistances, returnwords
end


return w2vutils
