

-- default
XM_LOCALE = {
	["XMerchant"]			= "|cffff8800XMerchant|r";
	["AutoSellJunk"]		= "Auto sell junk";
	["AutoRepair"]			= "Auto repair";
	["UseGuildBank"]		= "Use guild bank";
	["AutoBuyStuff"]		= "Auto buy stuff";
	["SetBuyStuff"]			= "Set buy stuff";
	["ShowDurability"]		= "Show durability";
	["ShowDetailsInfo"]		= "Show details info";
	["CostofRepair"]		= "Cost of repair";
	["CostofBuy"]			= "Cost of buy";
	["ShowHelp"]			= "help Show help";
	["ItemLink"]			= "ItemLink";
	["Count"]				= "Count";
};
local locale = GetLocale();

if(locale == "zhCN")then
	XM_LOCALE = {
		["XMerchant"]			= "|cffff8800XMerchant|r";
		["AutoSellJunk"]		= "自动贩卖：";
		["AutoRepair"]			= "自动修理：";
		["UseGuildBank"]		= "优先使用公会修理：";
		["AutoBuyStuff"]		= "自动购买物品：";
		["SetBuyStuff"]			= "设置自动购买的材料：";
		["ShowDurability"]		= "显示装备耐久度：";
		["ShowDetailsInfo"]		= "显示详细信息：";
		["CostofRepair"]		= "修理花费了：";
		["CostofBuy"]			= "购买材料花费了：";
		["ShowHelp"]			= "命令幫助 /xm help";
		["ItemLink"]			= "物品链接";
		["Count"]				= "数量";
	};
elseif(locale == "zhTW")then
	XM_LOCALE = {
		["XMerchant"]			= "|cffff8800XMerchant|r";
		["AutoSellJunk"]		= "自動賣廢品：";
		["AutoRepair"]			= "自動修理：";
		["UseGuildBank"]		= "優先使用公會修理：";
		["AutoBuyStuff"]		= "自動購買物品：";
		["SetBuyStuff"]			= "設置自動購買的材料：";
		["ShowDurability"]		= "顯示裝備耐久度：";
		["ShowDetailsInfo"]		= "顯示詳細信息：";
		["CostofRepair"]		= "修理花費了：";
		["CostofBuy"]			= "購買材料花費了：";
		["ShowHelp"]			= "命令幫助 /xm help";
		["ItemLink"]			= "物品鏈接";
		["Count"]				= "數量";
	};
end

--......
