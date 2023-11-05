
ISFloorOverlay = ISBuildingObject:derive("ISFloorOverlay");

GrimeSprites_c = 
{
	"overlay_grime_floor_01_64",
	"overlay_grime_floor_01_56",
	"overlay_grime_floor_01_64",
	"overlay_grime_floor_01_48",
	"overlay_grime_floor_01_84",
	"overlay_grime_floor_01_85",
	"overlay_grime_floor_01_84",
	"overlay_grime_floor_01_72",
	"overlay_grime_floor_01_83",
	"overlay_grime_floor_01_82",
	"overlay_grime_floor_01_83",
	"overlay_grime_floor_01_48",
	"overlay_grime_floor_01_84",
	"overlay_grime_floor_01_85",
	"overlay_grime_floor_01_33",
	-- Edges
	"overlay_grime_floor_01_80",
	"overlay_grime_floor_01_81",
	"overlay_grime_floor_01_88",
	"overlay_grime_floor_01_89",
}

GrimeSprites_wall = 
{
	"overlay_grime_wall_01_1", -- N,
	"overlay_grime_wall_01_0", -- E
}

 ---@param wall IsoThumpable
 ---@param remove boolean
function ISFloorOverlay:UpdateGrime(wall, remove)
	print("UpdateGrime");

	local north = wall:getNorth();
	local LOOKUP_SIZE = 16;
	
	if (north) then
		wall:setOverlaySprite(GrimeSprites_wall[1]);

		local sq_ft = wall:getSquare();
		if (sq_ft ~= nil) then
			if (sq_ft ~= nil) then
				local sq = sq_ft;
				local floor = sq_ft:getFloor();
				local type = sq:getWallType();
				
				floor:setOverlaySprite(GrimeSprites_c[type]);
				print(type);
			end
			
			local sq_fl = sq_ft:getW();
			if (sq_fl ~= nil) then
				local sq = sq_fl;
				local floor = sq:getFloor();
				local type = sq:getWallType();

				floor:setOverlaySprite(type and GrimeSprites_c[type] or GrimeSprites_c[17]);
				print(type);
			end

			local sq_fr = sq_ft:getE();
			if (sq_fr ~= nil) then
				local sq = sq_fr;
				local floor = sq:getFloor();
				local type = sq:getWallType();

				floor:setOverlaySprite(type and GrimeSprites_c[type] or GrimeSprites_c[16]);
				print(type);
			end

			local sq_bk = wall:getOppositeSquare();
			if (sq_bk ~= nil) then
				if (sq_bk ~= nil) then
					local sq = sq_bk;
					local floor = sq:getFloor();
					local type = sq:getWallType();

					floor:setOverlaySprite(GrimeSprites_c[type]);
					print(type);
				end

				local sq_bl = sq_bk:getW();
				if (sq_bl ~= nil) then
					local sq = sq_bl;
					local floor = sq:getFloor();
					local type = sq:getWallType();

					floor:setOverlaySprite(type and GrimeSprites_c[type] or GrimeSprites_c[18]);
					print(type);
				end

				local sq_br = sq_bk:getE();
				if (sq_br ~= nil) then
					local sq = sq_br;
					local floor = sq:getFloor();
					local type = sq:getWallType();

					floor:setOverlaySprite(type and GrimeSprites_c[type] or GrimeSprites_c[19]);
					print(type);
				end
			end
		end
	else
		wall:setOverlaySprite(GrimeSprites_wall[2]);

		local sq_ft = wall:getSquare();
		if (sq_ft ~= nil) then
			if (sq_ft ~= nil) then
				local sq = sq_ft;
				local floor = sq_ft:getFloor();
				local type = sq:getWallType();
				
				floor:setOverlaySprite(GrimeSprites_c[type]);
				print(type);
			end
			
			local sq_fl = sq_ft:getS();
			if (sq_fl ~= nil) then
				local sq = sq_fl;
				local floor = sq:getFloor();
				local type = sq:getWallType();

				floor:setOverlaySprite(type and GrimeSprites_c[type] or GrimeSprites_c[16]);
				print(type);
			end

			local sq_fr = sq_ft:getN();
			if (sq_fr ~= nil) then
				local sq = sq_fr;
				local floor = sq:getFloor();
				local type = sq:getWallType();

				floor:setOverlaySprite(type and GrimeSprites_c[type] or GrimeSprites_c[19]);
				print(type);
			end

			local sq_bk = wall:getOppositeSquare();
			if (sq_bk ~= nil) then
				if (sq_bk ~= nil) then
					local sq = sq_bk;
					local floor = sq:getFloor();
					local type = sq:getWallType();

					floor:setOverlaySprite(GrimeSprites_c[type]);
					print(type);
				end

				local sq_bl = sq_bk:getS();
				if (sq_bl ~= nil) then
					local sq = sq_bl;
					local floor = sq:getFloor();
					local type = sq:getWallType();

					floor:setOverlaySprite(type and GrimeSprites_c[type] or GrimeSprites_c[17]);
					print(type);
				end

				local sq_br = sq_bk:getN();
				if (sq_br ~= nil) then
					local sq = sq_br;
					local floor = sq:getFloor();
					local type = sq:getWallType();

					floor:setOverlaySprite(type and GrimeSprites_c[type] or GrimeSprites_c[18]);
					print(type);
				end
			end
		end
	end
end

--************************************************************************--
--** ISFloorOverlay:new
--**
--************************************************************************--
function ISFloorOverlay:create(x, y, z, north, sprite)
	-- local cell = getWorld():getCell();
	-- self.sq = cell:getGridSquare(x, y, z);
	-- self.javaObject = IsoObject.new(cell, self.sq, sprite, north, self);

	buildUtil.consumeMaterial(self);

	-- self.sq:addFloor("floors_exterior_tilesandstone_01");
	-- print(self.sq:getFloor());

    -- self.sq:AddTileObject(self.javaObject, 0);
	-- self.sq:getObjects():get(0):AttachExistingAnim(sprite, 0, 0, false, 0, 0, false, 1.00);
	-- self.sq:getObjects():get(0):setOverlaySprite(sprite);
	-- self.javaObject:transmitCompleteItemToServer();
	
	
	local cell = getWorld():getCell();
	local sq = cell:getGridSquare(x, y, z);
	-- sq:getObjects():get(0):setOverlaySprite(sprite);

	local floor = sq:getFloor();
	local att = floor:getAttachedAnimSprite();
	if (att == nil) then
		att = ArrayList.new();
		floor:setAttachedAnimSprite(att);
	end

	att:add(getSprite(sprite):newInstance());

	

end

function ISFloorOverlay:removeFromGround(square)
	for i = 0, square:getSpecialObjects():size() do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
		end
	end
end

function ISFloorOverlay:new(name, sprite, northSprite)
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
function ISFloorOverlay:getHealth()
	return 100 + buildUtil.getWoodHealth(self);
end

function ISFloorOverlay:isValid(square)
	if not ISBuildingObject.isValid(self, square) then return false; end
	if not buildUtil.canBePlace(self, square) then return false end
	if buildUtil.stairIsBlockingPlacement( square, true ) then return false; end
    return true;
end

function ISFloorOverlay:render(x, y, z, square)
	ISBuildingObject.render(self, x, y, z, square)
end

-- Events
---@param object IsoObject
local function onTileRemoved(object)
	local type = object:getType();
	if (type ~= IsoObjectType.wall) then 
		return; 
	end

	print("OnTileRemoved");
	print(object:getType());

	triggerEvent("OnRemWall", object);
end

Events.OnTileRemoved.Add(onTileRemoved)

--- Custom Events
LuaEventManager.AddEvent("OnAddWall")
LuaEventManager.AddEvent("OnRemWall")

---@param wall IsoThumpable
local function onAddWall(wall)
	ISFloorOverlay:UpdateGrime(wall, false);
	-- print("OnAddWall");
	-- print(object:getName());
end

---@param wall IsoThumpable
local function onRemWall(wall)
	ISFloorOverlay:UpdateGrime(wall, true);
	-- print("OnRemWall");
	-- print(object:getName());
end

Events.OnAddWall.Add(onAddWall)
Events.OnRemWall.Add(onRemWall)