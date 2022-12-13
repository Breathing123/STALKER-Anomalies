require "Foraging/forageSystem"
require "Foraging/ISSearchManager"
require "Foraging/ISBaseIcon"
require "Foraging/ISUI/ISPanel"

local deviceEquipped

local function OnEquipPrimary(character, inventoryItem)
    local isSearchOn = getSearchMode():isEnabled(character:getPlayerNum())
    if inventoryItem ~= nil then
        if inventoryItem:getDisplayCategory() == "ArtifactDetector" and isSearchOn == true then
            if inventoryItem:isActivated() == true then
                deviceEquipped = true
            end
        else
            deviceEquipped = false
        end
    end
end

Events.OnEquipPrimary.Add(OnEquipPrimary)

local function OnEquipSecondary(character, inventoryItem)
    local isSearchOn = getSearchMode():isEnabled(character:getPlayerNum())

    if inventoryItem ~= nil then
        if inventoryItem:getDisplayCategory() == "ArtifactDetector" and isSearchOn == true then
            if inventoryItem:isActivated() == true then
                deviceEquipped = true
            end
        else
            deviceEquipped = false
        end
    end
end

Events.OnEquipSecondary.Add(OnEquipSecondary)

local function onToggleSearchMode(player, isSearchMode)
    getWorldMarkers():removeAllHomingPoints(getPlayer())
    local detectors = {"commonAnomaliesArtifactDetector", "uncommonAnomaliesArtifactDetector", "rareAnomaliesArtifactDetector"} 


        if isSearchMode == true and player:getPrimaryHandItem() ~= nil or player:getSecondaryHandItem() ~= nil and player:hasEquippedTag(detectors) == true and deviceEquipped == true then
        end
end

Events.onToggleSearchMode.Add(onToggleSearchMode)


local function OnPlayerMove(player)
    print("spoingus")

    local manager = ISSearchManager.getManager(getSpecificPlayer(0));

    if player:getPrimaryHandItem() == nil or player:getPrimaryHandItem():getDisplayCategory() ~= "ArtifactDetector" then return;
    end

    if player:getPrimaryHandItem() ~= nil and player:getPrimaryHandItem():getDisplayCategory() == "ArtifactDetector" and player:getPrimaryHandItem():isActivated() == false and getSearchMode():isEnabled(player:getPlayerNum()) == true then
        manager:toggleSearchMode()
    end
end

Events.OnPlayerMove.Add(OnPlayerMove)

function ISBaseIcon:spotIcon()
    local player = self.character
    local item = InventoryItemFactory.CreateItem(self.itemType)

    if (not self:getIsSeen()) then
        self:resetBounce();
        self.spotTimer = self.spotTimerMax;
        self:setIsNoticed(true);
        self:updateAlpha();
        self:setIsSeen(true);
        if player:getPrimaryHandItem() ~= nil or player:getSecondaryHandItem() ~= nil and player:hasEquippedTag(detectors) == true and player:getPrimaryHandItem():getUsedDelta() > 0 or deviceEquipped == true then
            if item:getDisplayCategory() == "Artifact" then
                getPlayer():getEmitter():playSound("ArtifactBeep")
                print("sound") 
            end
        end
        self:setIsSeenThisUpdate(true);
        self.manager:spotIcon(self);
        self:addIsoMarker();
        self:initItem();
        self:initItemCount();
        self:getItemList();
        if self.canRollForSearchFocus then
            self:setCanRollForSearchFocus(false);
        end;
    end;
end