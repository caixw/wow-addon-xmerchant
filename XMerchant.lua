
local StuffList = {};

local FontStrs = {};

local Slots = {
			["Head"] 			= 1, 	-- 头
			["Shoulder"] 		= 3, 	-- 肩
			["Chest"]			= 5, 	-- 胸甲
			["Wrist"]			= 9, 	-- 护腕
			["Hands"]			= 10,	-- 手套
			["Waist"]			= 6, 	-- 腰带
			["Legs"]			= 7, 	-- 腿
			["Feet"]			= 8, 	-- 靴子
			["MainHand"]		= 16,	-- 主手
			["SecondaryHand"]	= 17, 	-- 副手
			["Ranged"]			= 18	-- 远程
};
-----------------------------------------------------------------------------
local IsDebug = false;

local function ShowDebugMsg(msg)
    if IsDebug then
        DEFAULT_CHAT_FRAME:AddMessage(msg or "NULL");
    end
end
-----------------------------------------------------------------------------
local function print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg or "NULL");
end
-----------------------------------------------------------------------------
local function GetFontStrings(name)
	if(not FontStrs[name]) then
		local slot = getglobal("Character" .. name .. "Slot");
		FontStrs[name] = slot:CreateFontString(nil, "OVERLAY", "NumberFontNormal");
		FontStrs[name]:SetPoint("CENTER", slot, "BOTTOM", 0, 8)
	end
	return FontStrs[name];
end
-----------------------------------------------------------------------------
local function UpdateDurability()
	if(not ConfigDB["Durability"])then return end

	for slot, id in pairs(Slots) do
		local v1, v2 = GetInventoryItemDurability(id);
		if(v1 and v2 and v2 ~= 0) then
			local percent = v1 / v2;
			local font = GetFontStrings(slot);
			font:SetTextColor(1 - percent, percent, 0);
			font:SetText(ceil(percent * 100) .. "%");
		end -- end if
	end
end
-----------------------------------------------------------------------------
-- 判断物品是否是垃圾
local function IsJunk(bag, slot)
	-- GetContainerItemInfo(bag, slot)此函數只返回－1和4兩種值
	-- return select(4, GetContainerItemInfo(bag, slot) == 0);
	local link = GetContainerItemLink(bag, slot);
	if(not link)then return false end -- 判断是否为空的。
	return select(3, GetItemInfo(link)) == 0;
end
-----------------------------------------------------------------------------
local function SellJunk()
	if(not ConfigDB["Sell"])then return end

	for bag=0, 4 do
		local slots = GetContainerNumSlots(bag);
		for slot=1, slots do
			if(IsJunk(bag, slot))then
				ShowMerchantSellCursor(1);
				UseContainerItem(bag, slot);
			end
		end -- end for slot
	end
end
-----------------------------------------------------------------------------
-- 獲取金幣的字符串形式。
local function GetMoneyString(value)
	local gold = floor(value / (COPPER_PER_GOLD));
	local silver = floor((value - (gold * COPPER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(value, COPPER_PER_SILVER);
	return GOLD_AMOUNT_TEXTURE:format(gold,0,0)..SILVER_AMOUNT_TEXTURE:format(silver,0,0)..COPPER_AMOUNT_TEXTURE:format(copper,0,0);
end
-----------------------------------------------------------------------------
local function BuyStuff()
	if(not ConfigDB["Buy"])then return end

	local cost = 0;		-- 购买材料的花费

	for id, need in pairs(ConfigDB["Stuff"]) do
		for i=1, GetMerchantNumItems() do
			local link = GetMerchantItemLink(i);
			if(link) then
				local itemId = tonumber(string.match(link,"item:(%d+):"));
				if(itemId == id) then -- 找到需要购买的商品
					local _,_,price,quantity = GetMerchantItemInfo(i); -- 单价，堆叠数量
					local rem = need - GetItemCount(id); -- 需要购买的数量
					if(rem <= 0)then break; end

					if(quantity == 1) then
						local max = GetMerchantItemMaxStack(i);
						while(rem >= max) do
							BuyMerchantItem(i,max);
							cost = cost + price * max;
							rem = rem - max;
						end -- while
						BuyMerchantItem(i,rem);
						cost = cost + price * rem;
						break;
					else
						while(rem >= quantity)do
							BuyMerchantItem(i, 1);
							rem = rem - quantity;
							cost = cost + price;
						end
						break;
					end -- if
				end -- end if itemId == id
			end -- if not link
		end
	end -- end for

	if(ConfigDB["Details"] and cost > 0) then print(XM_LOCALE["CostofBuy"] .. GetMoneyString(cost)); end

end
-----------------------------------------------------------------------------
local function Repair()
	if(not ConfigDB["Repair"])then return end;

	local cost, canRepair = GetRepairAllCost();
	if canRepair and (cost ~= 0) then
		RepairAllItems(((ConfigDB["UseGuildBank"] and CanGuildBankRepair()) and 1) or nil);
		RepairAllItems();
		if(ConfigDB["Details"] and cost > 0) then print(XM_LOCALE["CostofRepair"] .. GetMoneyString(cost)) end
	end
end
-----------------------------------------------------------------------------
local function InitVariable()
	if(not ConfigDB or type(ConfigDB) ~= "table")then
		ConfigDB = {
		["Sell"]			= true,
		["Repair"]			= true,
		["UseGuildBank"]	= true,
		["Buy"]				= true,
		["Durability"]		= true,
		["Details"]			= true,
		["Stuff"] = {}
		};
	end
end
-----------------------------------------------------------------------------
function XM_OnLoad()
	this:RegisterEvent("UPDATE_INVENTORY_DURABILITY");
	this:RegisterEvent("MERCHANT_SHOW");
	this:RegisterEvent("VARIABLES_LOADED");
end
-----------------------------------------------------------------------------
function XM_OnEvent(event)
	if(event == "VARIABLES_LOADED")then
		InitVariable();
	elseif(event == "UPDATE_INVENTORY_DURABILITY") then
		UpdateDurability();
	elseif(event == "MERCHANT_SHOW") then
		SellJunk();
		Repair();
		BuyStuff();
	end
end
-----------------------------------------------------------------------------



