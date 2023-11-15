local showPlayerNames = true  -- Par défaut, les noms des joueurs sont activés

local function TogglePlayerNames()
    showPlayerNames = not showPlayerNames
    local status = showPlayerNames and "activé" or "désactivé"
    print("Affichage des noms des joueurs " .. status)
end

function _Ground()
    Action_Config = {
        Ground = {
            {
                Type = "buttom",
                IsRestricted = true,
                Blocked = false,
                CloseOnClick = false,
                Label = "Vous téléporter ici",
                OnClick = function()
                    SetEntityCoords(PlayerPedId(), LastCoordsHit)
                end,
            },
            {
                Type = "buttom-submenu",
                Label = "Voitures disponibles",
                IsRestricted = true,
                CloseOnClick = false,
                Action = {
                    {
                        'T20', -- Nom du véhicule
                        function()
                            SpawnVehicle("t20")
                        end
                    },
                    {
                        'Sultan Rs',
                        function()
                            SpawnVehicle("sultanrs")
                        end
                    },
                    {
                        'Krieger',
                        function()
                            SpawnVehicle("krieger")
                        end
                    },
                },
            },
            {
                Type = "buttom-submenu",
                Label = "Motos disponibles",
                IsRestricted = true,
                CloseOnClick = false,
                Action = {
                    {
                        'Hakuchou', -- Nom du véhicule
                        function()
                            SpawnVehicle("hakuchou")
                        end
                    },
                    {
                        'Avarus',
                        function()
                            SpawnVehicle("avarus")
                        end
                    },
                },
            },
            {
                Type = "buttom-submenu",
                Label = "Air disponibles",
                IsRestricted = true,
                CloseOnClick = false,
                Action = {
                    {
                        'Volatus', -- Nom du véhicule
                        function()
                            SpawnVehicle("volatus")
                        end
                    },
                    {
                        'Nimbus',
                        function()
                            SpawnVehicle("nimbus")
                        end
                    },
                },
            },
            {
                Type = "buttom-submenu",
                Label = "Eau disponibles",
                IsRestricted = true,
                CloseOnClick = false,
                Action = {
                    {
                        'Bateau rapide', -- Nom du véhicule
                        function()
                            SpawnVehicle("squalo")
                        end
                    },
                    {
                        'Voilier',
                        function()
                            SpawnVehicle("marquis")
                        end
                    },
                    {
                        'Jet-Ski',
                        function()
                            SpawnVehicle("seashark2")
                        end
                    },
                },
            },
            {
                Type = "buttom-submenu",
                Label = "Autres véhicules",
                IsRestricted = true,
                CloseOnClick = false,
                Action = {
                    {
                        'Remorque Fluide', -- Nom du véhicule
                        function()
                            SpawnVehicle("tanker2")
                        end
                    },
                    {
                        'Remorque voitures',
                        function()
                            SpawnVehicle("tr4")
                        end
                    },
                    {
                        'Tank',
                        function()
                            SpawnVehicle("rhino")
                        end
                    },
                    {
                        'Dock Handler',
                        function()
                            SpawnVehicle("handler")
                        end
                    },
                },
            },
            {
				Type = "buttom-submenu",
				Label = "Administration",
				IsRestricted = true,
				CloseOnClick = false,
				Action = {
					{
						'Afficher/Masquer Noms des Joueurs',
						function()
							TogglePlayerNames()
						end
					},
					{
						'Se téléporter au parking central',
						function()
							local parkingCoords = vector3(219.87, -792.61, 30.74)
							local playerPed = GetPlayerPed(-1)
							if IsEntityAVehicle(playerPed) then
								local vehicle = GetVehiclePedIsIn(playerPed, false)
								SetEntityCoordsNoOffset(vehicle, parkingCoords, true, true, true)
							else
								SetEntityCoordsNoOffset(playerPed, parkingCoords, true, true, true)
							end
							print("Téléportation au parking central")
						end
					},
				},
			},
            {
                Type = "buttom",
                IsRestricted = true,
                Blocked = false,
                CloseOnClick = false,
                Label = "Se téléporter à un joueur",
                OnClick = function()
                    local playerId = exports["cfx-target"]:ShowSync('player', false, 320, "small_text")
                    if playerId then
                        local targetPed = GetPlayerPed(-1)  -- Obtenez le Ped du joueur local
                        if DoesEntityExist(targetPed) then
                            local targetCoords = GetEntityCoords(targetPed)
                            local playerPed = GetPlayerPed(-1)
                            SetEntityCoordsNoOffset(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, true, true, true)
                        end
                    end
                end,
            },
            {
                Type = "buttom",
                IsRestricted = true,
                Blocked = false,
                CloseOnClick = false,
                Label = "Déposer un objet",
                OnClick = function()
                    local obj_model = exports["cfx-target"]:ShowSync('model', false, 320, "small_text")
                    if IsModelValid(obj_model) then
                        RequestModel(obj_model)
                        while not HasModelLoaded(obj_model) do
                            Wait(0)
                        end
                        local obj = CreateObject(obj_model, LastCoordsHit, true, true, true)
                        SetEntityAsMissionEntity(obj, true, true)
                        SetModelAsNoLongerNeeded(obj_model)
                    end
                end,
            },
            -- {
                -- Type = "buttom",
                -- IsRestricted = true,
                -- Blocked = false,
                -- CloseOnClick = false,
                -- Label = "Poser un véhicule",
                -- OnClick = function()
                    -- local veh_model = exports["cfx-target"]:ShowSync('model', false, 320, "small_text")
                    -- if IsModelValid(veh_model) then
                        -- RequestModel(veh_model)
                        -- while not HasModelLoaded(veh_model) do
                            -- Wait(0)
                        -- end
                        -- local veh = CreateVehicle(veh_model, LastCoordsHit, GetEntityHeading(PlayerPedId()), true, true)
                        -- SetEntityAsMissionEntity(veh, true, true)
                        -- SetVehicleOnGroundProperly(veh)
                        -- SetModelAsNoLongerNeeded(veh_model)
                    -- end
                -- end,
            -- },
            {
                Type = "buttom",
                IsRestricted = true,
                Blocked = true,
                CloseOnClick = false,
                Label = "Poser un peds",
                OnClick = function()
                    local ped_model = exports["cfx-target"]:ShowSync('Peds', false, 320, "small_text")
                    if IsModelValid(ped_model) then
                        RequestModel(ped_model)
                        while not HasModelLoaded(ped_model) do
                            Wait(0)
                        end
                        local ped = CreatePed(4, ped_model, LastCoordsHit, GetEntityHeading(PlayerPedId()), true, true)
                        SetEntityAsMissionEntity(ped, true, true)
                        SetModelAsNoLongerNeeded(ped_model)
                    end
                end,
            },
        },
    }
end

-- Fonction pour faire apparaître un véhicule
function SpawnVehicle(vehicleModel)
    local playerPed = GetPlayerPed(-1)
    local spawnCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    local heading = GetEntityHeading(playerPed)

    if IsModelValid(vehicleModel) then
        RequestModel(vehicleModel)
        while not HasModelLoaded(vehicleModel) do
            Wait(0)
        end

        local vehicle = CreateVehicle(vehicleModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, true)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleOnGroundProperly(vehicle)
        SetModelAsNoLongerNeeded(vehicleModel)
    end
end
