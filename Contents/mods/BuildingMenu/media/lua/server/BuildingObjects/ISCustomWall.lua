--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

ISCustomWall = ISBuildingObject:derive("ISCustomWall");

GrimeSprites_a = 
{
	"overlay_grime_floor_01_29", -- N
	nil,
	"overlay_grime_floor_01_28", -- W
	nil,
	"overlay_grime_floor_01_28", -- E
	nil,
	"overlay_grime_floor_01_75", -- S
	nil
}

GrimeSprites_b = 
{
	"overlay_grime_floor_01_59", -- N
	"overlay_grime_floor_01_00", -- W
	"overlay_grime_floor_01_75", -- E
	"overlay_grime_floor_01_00", -- S
	"overlay_grime_floor_01_82",
	"overlay_grime_floor_01_83",
	"overlay_grime_floor_01_84",
	"overlay_grime_floor_01_85",
}

-- GrimeSprites_a = 
-- {
-- 	"overlay_grime_floor_01_67", -- N
-- 	"overlay_grime_floor_01_59", -- W
-- 	"overlay_grime_floor_01_51", -- E
-- 	"overlay_grime_floor_01_75", -- S
-- 	"overlay_grime_floor_01_82",
-- 	"overlay_grime_floor_01_83",
-- 	"overlay_grime_floor_01_84",
-- 	"overlay_grime_floor_01_85",
-- }

-- GrimeSprites_b = 
-- {
-- 	"overlay_grime_floor_01_59", -- N
-- 	"overlay_grime_floor_01_00", -- W
-- 	"overlay_grime_floor_01_75", -- E
-- 	"overlay_grime_floor_01_00", -- S
-- 	"overlay_grime_floor_01_82",
-- 	"overlay_grime_floor_01_83",
-- 	"overlay_grime_floor_01_84",
-- 	"overlay_grime_floor_01_85",
-- }

GrimeSprites_wall = 
{
	"overlay_grime_wall_01_1", -- N
	nil,
	"overlay_grime_wall_01_0", -- W
	nil,
	nil,
	nil,
	nil,
	nil
}

GrimeSpritesCorner = 
{
	"overlay_grime_floor_01_80",
	"overlay_grime_floor_01_81",
	"overlay_grime_floor_01_88",
	"overlay_grime_floor_01_89",
}

-- GrimeSpritesCorner = 
-- {
-- 	"overlay_grime_floor_01_80",
-- 	"overlay_grime_floor_01_81",
-- 	"overlay_grime_floor_01_88",
-- 	"overlay_grime_floor_01_89",
-- }

GrimeSpritesCornerInv = 
{
	"overlay_grime_floor_01_82",
	"overlay_grime_floor_01_83",
	"overlay_grime_floor_01_84",
	"overlay_grime_floor_01_85",
}

--************************************************************************--
--** ISCustomWall:new
--**
--************************************************************************--
function ISCustomWall:create(x, y, z, north, sprite)
	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	self.javaObject = IsoThumpable.new(cell, self.sq, sprite, north, self);
	buildUtil.setInfo(self.javaObject, self);
	buildUtil.consumeMaterial(self);
	if not self.health then
        self.javaObject:setMaxHealth(self:getHealth());
    else
        self.javaObject:setMaxHealth(self.health);
    end
    self.javaObject:setHealth(self.javaObject:getMaxHealth());
    self.javaObject:setName(self.name);
	-- the sound that will be played when our wall will be broken
	self.javaObject:setBreakSound("BreakObject");
	-- self.javaObject:setDir(north);
	-- add the item to the ground
    self.sq:AddSpecialObject(self.javaObject, self:getObjectIndex());
    self.sq:RecalcAllWithNeighbours(true);
	
	ISCustomWall.checkCorner(x, y, z, north, self, self.javaObject);
--	buildUtil.addWoodXp(self);

	local wall = self.javaObject;
	-- local floor_a = self.sq:getFloor();
	-- local floor_b = self.javaObject:getOppositeSquare():getFloor();

	-- -- local att = floor:getAttachedAnimSprite();
	-- -- if (att == nil) then
	-- -- 	att = ArrayList.new();
	-- -- 	floor:setAttachedAnimSprite(att);
	-- -- end
	-- -- att:add(getSprite(GrimeSprites[grime_idx_0]):newInstance());

	-- -- local grime_idx_0 = 1;
	-- -- if (north) then grime_idx_0 = 2 end

	-- local dir = IsoDirections.fromIndex(north and 0 or 2);
	-- self.javaObject:setDir(dir);

	
	-- -- -- att:add(getSprite(GrimeSprites[grime_idx_0]):newInstance());
	-- floor_a:setOverlaySprite(GrimeSprites_a[dir:index() + 1]);
	-- floor_b:setOverlaySprite(GrimeSprites_b[dir:index() + 1]);
	-- wall:setOverlaySprite(GrimeSprites_wall[dir:index() + 1]);
	
	-- -- local att = wall:getAttachedAnimSprite();
	-- -- if (att == nil) then
	-- -- 	att = ArrayList.new();
	-- -- 	wall:setAttachedAnimSprite(att);
	-- -- end
	-- -- -- att:add(getSprite(GrimeSprites_a[dir:index() + 1]):newInstance());
	-- -- -- wall:setOverlaySprite(GrimeSprites_a[dir:index() + 1]);
	-- -- wall:setOverlaySprite(GrimeSprites_wall[dir:index() + 1]);
	-- -- -- att:add(getSprite(GrimeSprites_wall[dir:index() + 1]):newInstance());
	-- -- att:add(getSprite(GrimeSprites_a[dir:index() + 1]):newInstance());


	-- print(self.javaObject:getDir():index());
	-- print(IsoDirections.N:index() .. " " .. IsoDirections.NW:index() .. " " .. IsoDirections.W:index().. " " .. IsoDirections.S:index() .. " " .. IsoDirections.E:index() .. " " .. IsoDirections.NE:index());

	triggerEvent("OnAddWall", wall);

	self.javaObject:transmitCompleteItemToServer();

	-- self.javaObject:getOppositeSquare():addBrokenGlass();
	-- self.javaObject:setBlockaAllTheSquare(true);
	-- print(self.javaObject:getSpriteEdge(true));
end

-- check if a corner has to be added
-- if you place a wall to make a corner for example, there is still a hole where you can walk, so your fort will not be zombie proof
-- here we gonna check if, when you add a wall, we need to add a corner
function ISCustomWall.checkCorner(x, y, z, north, thumpable, item)
	local found = false;
	local xoffset = 1;
	local yoffset = -1;
	local sx = x + 1;
	local sy = y;
		
	if not north then
		xoffset = -1;
		yoffset = 1;
		sx = x;
		sy = y + 1;
	end
	
	local sq1 = getCell():getGridSquare(x, y, z);
	if (not item:isCorner()) then
		for i = 0, sq1:getSpecialObjects():size() - 1 do
			local itemTmp = sq1:getSpecialObjects():get(i);
			
			if instanceof(itemTmp, "IsoThumpable") and itemTmp:isCorner() then
				sq1:transmitRemoveItemFromSquare(itemTmp)
				sq1:RemoveTileObject(itemTmp);
				sq1:RecalcAllWithNeighbours(true);
				break;
			end
		end
	end

	local sq2 = getCell():getGridSquare(x + xoffset, y + yoffset, z);
	for i = 0, sq2:getSpecialObjects():size() - 1 do
		local itemTmp = sq2:getSpecialObjects():get(i);
		if instanceof(itemTmp, "IsoThumpable") and itemTmp:getNorth() ~= north  then
			found = true;
			break;
		end
	end

	if found then
		-- don't add a corner if there's a wall on the tile
		local sq2 = getCell():getGridSquare(sx, sy, z);
		if sq2 and sq2:getWallFull() then
			return;
		end
		ISCustomWall.addCorner(sx,sy,z,thumpable,item);
	end
end

-- add the needed corner so there will be no hole in your fort
function ISCustomWall.addCorner(x,y,z, thumpable, item)
	if thumpable.corner ~= nil then
		local sq = getCell():getGridSquare(x, y, z);
		local corner = IsoThumpable.new(getCell(), sq, thumpable.corner, false, nil);
		local floor = sq:getFloor();

		corner:setCorner(true);
		corner:setCanBarricade(false);
		sq:AddSpecialObject(corner);
		sq:RecalcAllWithNeighbours(true);

		-- local att = corner:getAttachedAnimSprite();
		-- if (att == nil) then
		-- 	att = ArrayList.new();
		-- 	corner:setAttachedAnimSprite(att);
		-- end
		-- -- att:add(getSprite("overlay_grime_floor_01_30"):newInstance());
		-- -- att:add(getSprite("overlay_grime_wall_01_3"):newInstance());
		-- att:add(getSprite("overlay_grime_floor_01_30"):newInstance());

		-- floor:setOverlaySprite("overlay_grime_floor_01_30");
		-- corner:setOverlaySprite("overlay_grime_floor_01_30");
		-- corner:setOverlaySprite("overlay_grime_wall_01_3");
		corner:setOverlaySprite("overlay_grime_wall_01_3");

		corner:transmitCompleteItemToServer();
	end
end

function ISCustomWall:removeFromGround(square)
	print("remove");
end

function ISCustomWall:onTimedActionStart(action)
	if self.firstItem == "BlowTorch" then
		ISBuildingObject.onTimedActionStart(self, action)
		return
	end
	if self.noNeedHammer then
		-- Log Wall
		action:setActionAnim("Loot")
		action.character:SetVariable("LootPosition", "High")
		action:setOverrideHandModels(nil, nil)
		return
	end
	ISBuildingObject.onTimedActionStart(self, action)
end

function ISCustomWall:new(sprite, northSprite, corner)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSprite(sprite);
	o:setNorthSprite(northSprite);
	o.corner = corner;
	o.canBarricade = true;
	o.name = "Wooden Wall";
	o.isWallLike = true
	return o;
end

-- return the health of the new wall, it's 200 + 100 per carpentry lvl
function ISCustomWall:getHealth()
    if self.sprite == "carpentry_02_80" then -- log walls are stronger
	    return 400 + buildUtil.getWoodHealth(self);
    else
        return 200 + buildUtil.getWoodHealth(self);
    end
end

function ISCustomWall:isValid(square)
	if not self:haveMaterial(square) then return false end

--	if not buildUtil.canBePlace(self, square) then return false end
	if isClient() and SafeHouse.isSafeHouse(square, getSpecificPlayer(self.player):getUsername(), true) then
		return false;
	end

	if square:isVehicleIntersecting() then return false end

	for i=1,square:getObjects():size() do
		local object = square:getObjects():get(i-1);
		local sprite = object:getSprite()
		if (sprite and ((sprite:getProperties():Is(IsoFlagType.collideN) and self.north) or
				(sprite:getProperties():Is(IsoFlagType.collideW) and not self.north))) or
				((instanceof(object, "IsoThumpable") and (object:getNorth() == self.north)) and not object:isCorner() and not object:isFloor() and not object:isBlockAllTheSquare()) or
				(instanceof(object, "IsoWindow") and object:getNorth() == self.north) or
				(instanceof(object, "IsoDoor") and object:getNorth() == self.north) then
			return false;
		end

		-- Forbid placing walls between parts of multi-tile objects like couches.
		-- TODO: Check for parts being destroyed.
		local spriteGrid = sprite and sprite:getSpriteGrid()
		if spriteGrid then
			local gridX = spriteGrid:getSpriteGridPosX(sprite)
			local gridY = spriteGrid:getSpriteGridPosY(sprite)
			if self.north and gridY > 0 then
				return false;
			end
			if not self.north and gridX > 0 then
				return false;
			end
		end
	end

    if buildUtil.stairIsBlockingPlacement( square, true, (self.nSprite==4 or self.nSprite==2) ) then return false; end

    -- if we don't have floor we gonna check if there's a stairs under it, in this case we allow the build
	if not square:hasFloor(self.north) then
		local belowSQ = getCell():getGridSquare(square:getX(), square:getY(), square:getZ()-1)
		if belowSQ then
			if self.north and not belowSQ:HasStairsWest() then return false; end
			if not self.north and not belowSQ:HasStairsNorth() then return false; end
		end
	end

	return true -- square:isFreeOrMidair(false);
end

function ISCustomWall:render(x, y, z, square)
	ISBuildingObject.render(self, x, y, z, square)
end

function ISCustomWall:getObjectIndex()
	for i = self.sq:getObjects():size(),1,-1 do
		local object = self.sq:getObjects():get(i-1)
		local props = object:getProperties()
		if props and props:Is(IsoFlagType.solidfloor) then
			return i
		end
	end
	return -1
end
