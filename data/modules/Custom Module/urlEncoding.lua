-- https://rosettacode.org/wiki/URL_encoding#Lua

function encodeChar(chr)
	return string.format("%%%X",string.byte(chr))
end
 
function urlEncode(str)
	local output, t = string.gsub(str,"[^%w]",encodeChar)
	return output
end