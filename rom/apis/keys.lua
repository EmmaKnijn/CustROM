if string.match(string.lower(_HOST),"craftos") then

-- Minecraft key code bindings
-- See http://www.minecraftwiki.net/wiki/Key_codes for more info

local tKeys = {
	nil,	 	"one", 		"two", 		"three", 	"four",			-- 1
	"five", 	"six", 		"seven", 	"eight", 	"nine",			-- 6
	"zero", 	"minus", 	"equals", 	"backspace","tab",			-- 11
	"q", 		"w", 		"e", 		"r",		"t",			-- 16
	"y",		"u",		"i",		"o",		"p",			-- 21
	"leftBracket","rightBracket","enter","leftCtrl","a",			-- 26
	"s",		"d",		"f",		"g",		"h",			-- 31
	"j",		"k",		"l",		"semiColon","apostrophe",	-- 36
	"grave",	"leftShift","backslash","z",		"x",			-- 41
	"c",		"v",		"b",		"n",		"m",			-- 46
	"comma",	"period",	"slash",	"rightShift","multiply",	-- 51
	"leftAlt",	"space",	"capsLock",	"f1",		"f2",			-- 56
	"f3",		"f4",		"f5",		"f6",		"f7",			-- 61
	"f8",		"f9",		"f10",		"numLock",	"scrollLock",	-- 66
	"numPad7",	"numPad8",	"numPad9",	"numPadSubtract","numPad4",	-- 71
	"numPad5",	"numPad6",	"numPadAdd","numPad1",	"numPad2",		-- 76
	"numPad3",	"numPad0",	"numPadDecimal",nil,	nil,			-- 81
	nil,	 	"f11",		"f12",		nil,		nil,			-- 86
	nil,		nil,		nil,		nil,		nil,			-- 91
	nil,		nil,		nil,		nil,		"f13",			-- 96
	"f14",		"f15",		nil,		nil,		nil,			-- 101
	nil,		nil,		nil,		nil,		nil,			-- 106
	nil,		"kana",		nil,		nil,		nil,			-- 111
	nil,		nil,		nil,		nil,		nil,			-- 116
	"convert",	nil,		"noconvert",nil,		"yen",			-- 121
	nil,		nil,		nil,		nil,		nil,			-- 126
	nil,		nil,		nil,		nil,		nil,			-- 131
	nil,		nil,		nil,		nil,		nil,			-- 136
	"numPadEquals",nil,		nil,		"circumflex","at",			-- 141
	"colon",	"underscore","kanji",	"stop",		"ax",			-- 146
	nil,		nil,		nil,		nil,		nil,			-- 151
	"numPadEnter","rightCtrl",nil,      nil,		nil,			-- 156
	nil,		nil,		nil,		nil,		nil,			-- 161
	nil,		nil,		nil,		nil,		nil,			-- 166
	nil,		nil,		nil,		nil,		nil,			-- 171
	nil,		nil,		nil,		"numPadComma",nil,			-- 176
	"numPadDivide",nil,		nil,		"rightAlt",	nil,			-- 181
	nil,		nil,		nil,		nil,		nil,			-- 186
	nil,		nil,		nil,		nil,		nil,			-- 191
	nil,		"pause",	nil,		"home",		"up",			-- 196
	"pageUp",	nil,		"left",		nil,		"right",		-- 201
	nil,		"end",		"down",		"pageDown",	"insert",		-- 206
	"delete"														-- 211
}

local keys = _ENV
for nKey, sKey in pairs( tKeys ) do
	keys[sKey] = nKey
end
keys["return"] = keys.enter
-- (Un-)fix some misspellings
keys.scollLock = keys.scrollLock
keys.cimcumflex = keys.circumflex

function getName( _nKey )
    if type( _nKey ) ~= "number" then
        error( "bad argument #1 (expected number, got " .. type( _nKey ) .. ")", 2 ) 
    end
	return tKeys[ _nKey ]
end

else

--- Constants for all keyboard "key codes", as queued by the @{key} event.
--
-- These values are not guaranteed to remain the same between versions. It is
-- recommended that you use the constants provided by this file, rather than
-- the underlying numerical values.
--
-- @module keys
-- @since 1.4

local expect = dofile("rom/modules/main/cc/expect.lua").expect

local tKeys = {}
tKeys[32] = 'space'
tKeys[39] = 'apostrophe'
tKeys[44] = 'comma'
tKeys[45] = 'minus'
tKeys[46] = 'period'
tKeys[47] = 'slash'
tKeys[48] = 'zero'
tKeys[49] = 'one'
tKeys[50] = 'two'
tKeys[51] = 'three'
tKeys[52] = 'four'
tKeys[53] = 'five'
tKeys[54] = 'six'
tKeys[55] = 'seven'
tKeys[56] = 'eight'
tKeys[57] = 'nine'
tKeys[59] = 'semicolon'
tKeys[61] = 'equals'
tKeys[65] = 'a'
tKeys[66] = 'b'
tKeys[67] = 'c'
tKeys[68] = 'd'
tKeys[69] = 'e'
tKeys[70] = 'f'
tKeys[71] = 'g'
tKeys[72] = 'h'
tKeys[73] = 'i'
tKeys[74] = 'j'
tKeys[75] = 'k'
tKeys[76] = 'l'
tKeys[77] = 'm'
tKeys[78] = 'n'
tKeys[79] = 'o'
tKeys[80] = 'p'
tKeys[81] = 'q'
tKeys[82] = 'r'
tKeys[83] = 's'
tKeys[84] = 't'
tKeys[85] = 'u'
tKeys[86] = 'v'
tKeys[87] = 'w'
tKeys[88] = 'x'
tKeys[89] = 'y'
tKeys[90] = 'z'
tKeys[91] = 'leftBracket'
tKeys[92] = 'backslash'
tKeys[93] = 'rightBracket'
tKeys[96] = 'grave'
-- tKeys[161] = 'world1'
-- tKeys[162] = 'world2'
tKeys[257] = 'enter'
tKeys[258] = 'tab'
tKeys[259] = 'backspace'
tKeys[260] = 'insert'
tKeys[261] = 'delete'
tKeys[262] = 'right'
tKeys[263] = 'left'
tKeys[264] = 'down'
tKeys[265] = 'up'
tKeys[266] = 'pageUp'
tKeys[267] = 'pageDown'
tKeys[268] = 'home'
tKeys[269] = 'end'
tKeys[280] = 'capsLock'
tKeys[281] = 'scrollLock'
tKeys[282] = 'numLock'
tKeys[283] = 'printScreen'
tKeys[284] = 'pause'
tKeys[290] = 'f1'
tKeys[291] = 'f2'
tKeys[292] = 'f3'
tKeys[293] = 'f4'
tKeys[294] = 'f5'
tKeys[295] = 'f6'
tKeys[296] = 'f7'
tKeys[297] = 'f8'
tKeys[298] = 'f9'
tKeys[299] = 'f10'
tKeys[300] = 'f11'
tKeys[301] = 'f12'
tKeys[302] = 'f13'
tKeys[303] = 'f14'
tKeys[304] = 'f15'
tKeys[305] = 'f16'
tKeys[306] = 'f17'
tKeys[307] = 'f18'
tKeys[308] = 'f19'
tKeys[309] = 'f20'
tKeys[310] = 'f21'
tKeys[311] = 'f22'
tKeys[312] = 'f23'
tKeys[313] = 'f24'
tKeys[314] = 'f25'
tKeys[320] = 'numPad0'
tKeys[321] = 'numPad1'
tKeys[322] = 'numPad2'
tKeys[323] = 'numPad3'
tKeys[324] = 'numPad4'
tKeys[325] = 'numPad5'
tKeys[326] = 'numPad6'
tKeys[327] = 'numPad7'
tKeys[328] = 'numPad8'
tKeys[329] = 'numPad9'
tKeys[330] = 'numPadDecimal'
tKeys[331] = 'numPadDivide'
tKeys[332] = 'numPadMultiply'
tKeys[333] = 'numPadSubtract'
tKeys[334] = 'numPadAdd'
tKeys[335] = 'numPadEnter'
tKeys[336] = 'numPadEqual'
tKeys[340] = 'leftShift'
tKeys[341] = 'leftCtrl'
tKeys[342] = 'leftAlt'
tKeys[343] = 'leftSuper'
tKeys[344] = 'rightShift'
tKeys[345] = 'rightCtrl'
tKeys[346] = 'rightAlt'
-- tKeys[347] = 'rightSuper'
tKeys[348] = 'menu'

local keys = _ENV
for nKey, sKey in pairs(tKeys) do
    keys[sKey] = nKey
end

-- Alias some keys for ease-of-use and backwards compatibility
keys["return"] = keys.enter --- @local
keys.scollLock = keys.scrollLock --- @local
keys.cimcumflex = keys.circumflex --- @local

--- Translates a numerical key code to a human-readable name. The human-readable
-- name is one of the constants in the keys API.
--
-- @tparam number code The key code to look up.
-- @treturn string|nil The name of the key, or `nil` if not a valid key code.
-- @usage keys.getName(keys.enter)
function getName(_nKey)
    expect(1, _nKey, "number")
    return tKeys[_nKey]
end
end
