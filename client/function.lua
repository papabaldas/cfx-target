Config_me = {
    language = 'en',
    color = { r = 230, g = 230, b = 230, a = 255 },
    font = 0, 
    time = 5000, 
    scale = 0.5, 
    dist = 250, 
}

local c = Config_me 
local peds = {}
local GetGameTimer = GetGameTimer
function draw3dText(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    local scale = 200 / (GetGameplayCamFov() * dist)
    SetTextColour(c.color.r, c.color.g, c.color.b, c.color.a)
    SetTextScale(0.0, c.scale * scale)
    SetTextFont(c.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end
function displayText(ped, text)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local targetPos = GetEntityCoords(ped)
    local dist = #(playerPos - targetPos)
    local los = HasEntityClearLosToEntity(playerPed, ped, 17)
    if dist <= c.dist and los then
        local exists = peds[ped] ~= nil
        peds[ped] = {
            time = GetGameTimer() + c.time,
            text = text
        }
        if not exists then
            local display = true
            while display do
                Wait(0)
                local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
                draw3dText(pos, peds[ped].text)
                display = GetGameTimer() <= peds[ped].time
            end
            peds[ped] = nil
        end
    end
end

function onShareDisplay(text, target)
    local player = GetPlayerFromServerId(target)
    if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
        local ped = GetPlayerPed(player)
        displayText(ped, text)
    end
end

function OnCustom(vehicle)
    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 14, math.random(0, 7), true)  -- Modifiez la plage (0, 7) selon vos besoins
    SetVehicleNumberPlateTextIndex(vehicle, math.random(0, 5))
    ToggleVehicleMod(vehicle, 18, true)
    SetVehicleColours(vehicle, math.random(0, 159), math.random(0, 159))  -- Modifiez la plage (0, 159) selon vos besoins
    SetVehicleCustomPrimaryColour(vehicle, math.random(0, 159), math.random(0, 159), math.random(0, 159))  -- Modifiez la plage (0, 159) selon vos besoins
    SetVehicleModColor_2(vehicle, 5, math.random(0, 159))  -- Modifiez la plage (0, 159) selon vos besoins
    SetVehicleExtraColours(vehicle, math.random(0, 159), math.random(0, 159))  -- Modifiez la plage (0, 159) selon vos besoins
    SetVehicleWindowTint(vehicle, math.random(0, 6))  -- Modifiez la plage (0, 6) selon vos besoins
    ToggleVehicleMod(vehicle, 22, true)
    SetVehicleMod(vehicle, 23, math.random(0, 11), false)  -- Modifiez la plage (0, 11) selon vos besoins
    SetVehicleMod(vehicle, 24, math.random(0, 11), false)  -- Modifiez la plage (0, 11) selon vos besoins
    SetVehicleWheelType(vehicle, math.random(0, 7))  -- Modifiez la plage (0, 7) selon vos besoins
    SetVehicleWindowTint(vehicle, math.random(0, 6))  -- Modifiez la plage (0, 6) selon vos besoins
    ToggleVehicleMod(vehicle, 20, true)
    SetVehicleTyreSmokeColor(vehicle, math.random(0, 159), math.random(0, 159), math.random(0, 159))  -- Modifiez la plage (0, 159) selon vos besoins
    LowerConvertibleRoof(vehicle, true)
    SetVehicleIsStolen(vehicle, false)
    SetVehicleIsWanted(vehicle, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetCanResprayVehicle(vehicle, true)
    SetPlayersLastVehicle(vehicle)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleTyresCanBurst(vehicle, false)
    SetVehicleWheelsCanBreak(vehicle, false)
    SetVehicleCanBeTargetted(vehicle, false)
    SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
    SetVehicleHasStrongAxles(vehicle, true)
    SetVehicleDirtLevel(vehicle, 0)
    SetVehicleCanBeVisiblyDamaged(vehicle, false)
    IsVehicleDriveable(vehicle, true)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleStrong(vehicle, true)
    RollDownWindow(vehicle, 0)
    RollDownWindow(vehicle, 1)
    SetPedCanBeDraggedOut(PlayerPedId(), false)
    SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
    SetPedRagdollOnCollision(PlayerPedId(), false)
    ResetPedVisibleDamage(PlayerPedId())
    ClearPedDecorations(PlayerPedId())
    SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
end


function GetPlayerIdFromPed(id)
    for i = 0,500 do
        if NetworkIsPlayerActive(i) then
            if GetPlayerPed(i) == id then
                return GetPlayerServerId(i)
            end
        end
    end
end
