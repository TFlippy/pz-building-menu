--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

ISFloorBorder = ISBuildingObject:derive("ISFloorBorder");

--************************************************************************--
--** ISFloorBorder:new
--**
--************************************************************************--
function ISFloorBorder:create(x, y, z, north, sprite)
	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	self.javaObject = IsoObject.new(cell, self.sq, sprite, north, self);

	buildUtil.consumeMaterial(self);

	-- self.sq:addFloor("floors_exterior_tilesandstone_01");
	print(self.sq:getFloor());

    -- self.sq:AddTileObject(self.javaObject, 0);
	-- self.sq:getObjects():get(0):AttachExistingAnim(sprite, 0, 0, false, 0, 0, false, 1.00);
	-- self.sq:getObjects():get(0):setOverlaySprite(sprite);
	
	
	-- local cell = getWorld():getCell();
	-- local sq = cell:getGridSquare(x, y, z);
	-- sq:getObjects():get(0):setOverlaySprite(sprite);

	
	self.javaObject:transmitCompleteItemToServer();
end

function ISFloorBorder:removeFromGround(square)
	for i = 0, square:getSpecialObjects():size() do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
		end
	end
end

function ISFloorBorder:new(name, sprite, northSprite)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSprite(sprite);
	o:setNorthSprite(northSprite);
	o.name = name;
	o.canBarricade = false;
	o.dismantable = false;
	o.blockAllTheSquare = false;
	o.canBeAlwaysPlaced = true;
	o.buildLow = true;
	o.canPassThrough = true;
	o.needToBeAgainstWall = false;
	return o;
end

-- return the health of the new container, it's 100 + 100 per carpentry lvl
function ISFloorBorder:getHealth()
	return 100 + buildUtil.getWoodHealth(self);
end

function ISFloorBorder:isValid(square)
	if not ISBuildingObject.isValid(self, square) then return false; end
	if not buildUtil.canBePlace(self, square) then return false end
	if buildUtil.stairIsBlockingPlacement( square, true ) then return false; end
    return true;
end

function ISFloorBorder:render(x, y, z, square)
	ISBuildingObject.render(self, x, y, z, square)
end
