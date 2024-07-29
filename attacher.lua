---@diagnostic disable: missing-parameter

local attacher = {}
local createproplocation = false

local Control = { -- https://docs.fivem.net/docs/game-references/controls/
	RaiseX = 174,
	LowerX = 175,
	RaiseY = 15,
	LowerY = 14,
	RaiseZ = 173,
	LowerZ = 172,
	
	RaiseRX = 312,
	LowerRX = 313,
	RaiseRY = 314,
	LowerRY = 315,
	RaiseRZ = 83,
	LowerRZ = 84,
	
	Increment = 127,
	Decrement = 128,
	Cancel = 202,
    Confirm = 215
}

---@param num number
---@param numDecimalPlaces number
---@return number?
local function Round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

--- DrawText2D
---@param x number
---@param y number
---@param width number
---@param height number
---@param scale number
---@param text string
---@param r number
---@param g number
---@param b number
---@param a number
local function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

--- Start Function
---@param boneindex number
---@param prop string | integer
function attacher.start(boneindex, prop)
	local Player = cache.ped
	local boneid = GetPedBoneIndex(Player, boneindex)
	local x2,y2,z2 = table.unpack(GetEntityCoords(Player))
    
	lib.requestModel(prop, 2500)
	local object = CreateObject(prop, x2, y2, z2+0.2,  true,  true, true)
	local x, y, z, rx, ry, rz, increment = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.01
	AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)

    local text = [[
    X       : ←	→
    Y       : Mouse Scroll ↑↓
    Z       : ↑↓
    RX      : [ ]
    RY      : Numpad + -
    RZ      : = -
    Step    : Numpad 8 5
    Cancel  : Escape
    Confirm : Enter
    ]]

    lib.showTextUI(text)

    createproplocation = true
	CreateThread(function()
		while createproplocation do
			for k, v in pairs(Control) do
				DisableControlAction(0, v, true)
			end

			if IsDisabledControlPressed(0, Control.RaiseZ) then
				z = Round(z+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Control.LowerZ) then 
				z = Round(z-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Control.RaiseX) then 
				x = Round(x+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Control.LowerX) then 
				x = Round(x-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Control.RaiseY) then 
				y = Round(y+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Control.LowerY) then 
				y = Round(y-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Control.RaiseRX) then 
				rx = Round(rx+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)		
			elseif IsDisabledControlPressed(0, Control.LowerRX) then 
				rx = Round(rx-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Control.RaiseRY) then 
				ry = Round(ry+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)		
			elseif IsDisabledControlPressed(0, Control.LowerRY) then 
				ry = Round(ry-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlPressed(0, Control.RaiseRZ) then 
				rz = Round(rz+increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)		
			elseif IsDisabledControlPressed(0, Control.LowerRZ) then 
				rz = Round(rz-increment, 2)
				DetachEntity(object)
				AttachEntityToEntity(object, Player, boneid, x, y, z, rx, ry, rz, true, true, false, true, 1, true)
			elseif IsDisabledControlJustReleased(0, Control.Increment) then
				increment = Round(increment+0.01, 2)
			elseif IsDisabledControlJustReleased(0, Control.Decrement) then
				increment = Round(increment-0.01, 2)
			elseif IsDisabledControlJustReleased(0, Control.Cancel) then
				createproplocation = false
			elseif IsDisabledControlJustReleased(0, Control.Confirm) then
				createproplocation = false
                local locationFormat = [[
                    {
                        x = %.2f,
                        y = %.2f,
                        z = %.2f,
                        rx = %.2f,
                        ry = %.2f,
                        rz = %.2f
                    }
                ]]

                local textLocation = locationFormat:format(x, y, z, rx, ry, rz, increment)
                lib.setClipboard(textLocation)
			end

            local locationFormat = [[
    X: %.2f
    Y: %.2f
    Z: %.2f
    RX: %.2f
    RY: %.2f
    RZ: %.2f
    Step: %.2f
            ]]
            
            local textLocation = locationFormat:format(x, y, z, rx, ry, rz, increment)
			drawTxt(0.49, 0.95, 1.0,1.0,0.64 , textLocation, 255, 255, 255, 255)
            
			Wait(0)
		end
		SetModelAsNoLongerNeeded(prop)
		DeleteObject(object)
        lib.hideTextUI()
	end)
end

_ENV.attacher = attacher
