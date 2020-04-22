
local print = function(a) DEFAULT_CHAT_FRAME:AddMessage(a) end;


local Actions ={
['sell'] = function(v)ConfigDB['Sell'] = (tostring(v) == 'on') and true or false;end,

['repair'] = function(v)ConfigDB['Repair'] = (tostring(v) == 'on') and true or false;end,

['useguildbank'] = function(v)ConfigDB['UseGuildBank'] = (tostring(v) == 'on') and true or false;end,

['durability'] = function(v)ConfigDB['Durability'] = (tostring(v) == 'on') and true or false;end,

['details'] = function(v)ConfigDB['Details'] = (tostring(v) == 'on') and true or false;end,

['buy'] = function(v1, v2)
	local str = tostring(v1);
	if(str == 'on' or str == 'off')then
		ConfigDB['Buy'] = (str == 'on') and true or false;
		return;
	end

	local count = tonumber(v2);
	local itemId = tonumber(str:match("item:(%d+):"));
	ConfigDB['Stuff'][itemId] = count;
end,

['help'] = function()
	print(XM_LOCALE['XMerchant']);
	print(XM_LOCALE["AutoRepair"] .. 'r on/off | repair on/off');
	print(XM_LOCALE["AutoSellJunk"] .. 's on/off | sell on/off');
	print(XM_LOCALE["UseGuildBank"] .. 'u on/off | useguildbank on/off');
	print(XM_LOCALE["AutoBuyStuff"] .. 'b on/off | buy on/off');
	print(XM_LOCALE["ShowDurability"] .. 'd on/off | durability on/off');
	print(XM_LOCALE["ShowDetailsInfo"] .. 'details on/off');
	print(XM_LOCALE["SetBuyStuff"] .. 'b ' .. XM_LOCALE['ItemLink'] .. ' ' .. XM_LOCALE['Count']);
end
}

Actions['s'] = Actions['sell'];
Actions['r'] = Actions['repair'];
Actions['u'] = Actions['useguildbank'];
Actions['d'] = Actions['durability'];
Actions['b'] = Actions['buy'];
Actions['h'] = Actions['help'];


-----------------------------------------------------------------------------
local function PrintInfo()
	print(XM_LOCALE['XMerchant']);
	print(XM_LOCALE["ShowHelp"]);
	print(XM_LOCALE["AutoRepair"] .. (ConfigDB['Repair'] and 'on' or 'off'));
	print(XM_LOCALE["AutoSellJunk"] .. (ConfigDB['Sell'] and 'on' or 'off'));
	print(XM_LOCALE["UseGuildBank"] .. (ConfigDB['UseGuildBank'] and 'on' or 'off'));
	print(XM_LOCALE["AutoBuyStuff"] .. (ConfigDB['Buy'] and 'on' or 'off'));
	print(XM_LOCALE["ShowDurability"] .. (ConfigDB['Durability'] and 'on' or 'off'));
	print(XM_LOCALE["ShowDetailsInfo"] .. (ConfigDB['Details'] and 'on' or 'off'));
end
-----------------------------------------------------------------------------
local function XM_SlashCommand(cmd)
	local gm = string.gmatch(string.lower(cmd), '[^ ]+');
	local cmd1 = gm();
	local cmd2 = gm();
	local cmd3 = gm();

	if(not Actions[cmd1]) then
		PrintInfo();
	else
		Actions[cmd1](cmd2, cmd3);
	end
end

-----------------------------------------------------------------------------
function XM_Cmd_OnLoad()
	print(XM_LOCALE["ShowHelp"]);
	SlashCmdList["XMERCHANT"] = XM_SlashCommand;
	SLASH_XMERCHANT1 = "/xmerchant";
	SLASH_XMERCHANT2 = "/xm";
	
end






