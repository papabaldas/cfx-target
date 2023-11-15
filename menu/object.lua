function _Object()
    Action_Config = {
        Object = {
            {
                Type = "buttom",
                IsRestricted = true,
                Blocked = false,
                CloseOnClick = true,
                Label = ("Utilisé"),
                OnClick = function()
                    UseContextmenu(GetEntityModel(LastEntityHit))
                end,
            },
            {
                Type = "buttom",
                IsRestricted = true,
                Blocked = IsHackableAtm(GetEntityModel(LastEntityHit)),
                CloseOnClick = true,
                Label = ("Hack"),
                OnClick = function()
                ExecuteCommand("hack")
                end,
           },
		   {
                Type = "buttom-submenu",
                IsRestricted = true,
                CloseOnClick = false,
                Blocked = false,
                Label = "Parametres",
                Action = {
                    {
                        'Changer en Véhicule',
                        function()
                            ChangeEntityToRandomVehicle(LastEntityHit) 
                        end
                    },
                    {
                        'Faire apparaitre un PED',
                        function()
                            ChangeEntityType(LastEntityHit)  -- 2 correspond au type de piéton
                        end
                    },
					{
                        'Activer rotation',
                        function()
                            RotateObjectWithMouse(LastEntityHit)
                        end
                    },
					{
						'Changer la taille',
						function()
							ChangeObjectSize(LastEntityHit)
						end
					},

                    -- Ajoutez d'autres options de type ici
                }
            },
            {
                Type = "buttom",
                IsRestricted = true,
                CloseOnClick = true,
                Blocked = false,
                Label = ("ID de l'objet : %s"):format(LastEntityHit),
                OnClick = function()

                end,
            },
            {
				Type = "buttom",
				IsRestricted = true,
				CloseOnClick = true,
				Blocked = false,
				Label = ("Model de l'objet : %s"):format(GetEntityModel(LastEntityHit)),
				OnClick = function()
					local modelCode = GetEntityModel(LastEntityHit)
					SendNUIMessage({ type = "copy", text = tostring(modelCode) })
				end,
			},
            {
                Type = "buttom",
                IsRestricted = true,
                CloseOnClick = true,
                Blocked = false,
                Label = ("Owner de l'objet : %s"):format(NetworkGetEntityOwner(LastEntityHit)),
                OnClick = function()
                end,
            },

            {
                Type = "buttom",
                IsRestricted = true,
                CloseOnClick = true,
                Blocked = false,
                Label = ("Position : %s"):format(GetEntityCoords(LastEntityHit)),
                OnClick = function()
                end,
            },
            {
                Type = "buttom",
                IsRestricted = true,
                CloseOnClick = true,
                Blocked = false,
                Label = ("Rotation : %s"):format(GetEntityRotation(LastEntityHit)),
                OnClick = function()
                end,
            },
            {
                Type = "buttom",
                IsRestricted = true,
                CloseOnClick = true,
                Blocked = false,
                Label = ("Type : %s"):format(GetEntityType(LastEntityHit)),
                OnClick = function()
                end,
            },
            {
                Type = "buttom",
                IsRestricted = true,
                CloseOnClick = true,
                Blocked = false,
                OnClick = function()
                    Target:MouveEntity(LastEntityHit)
                end,
                Label = "Déplacé l'objet",
            },
            {
                Type = "buttom",
                Label = "Dupliqué",
                IsRestricted = true,
                CloseOnClick = true,
                Blocked = false,
                OnClick = function()
                    local new = Target:DuplicateEntity(LastEntityHit)
                    Target:MouveEntity(new)
                end,
            },
            {
                Type = "buttom",
                Label = "Suprimé",
                IsRestricted = true,
                CloseOnClick = true,
                Blocked = false,
                OnClick = function()
                    SetEntityAsMissionEntity(LastEntityHit, false, false)
                    DeleteObject(LastEntityHit)
                end,
            },
        },
    }
end
function ChangeEntityType(entity)
    local x, y, z = table.unpack(GetEntityCoords(entity))
    local heading = GetEntityHeading(entity)

    DeleteObject(entity)

    local isPedestrian = true
    if isPedestrian then
        local pedModel = GetRandomPedestrianModel()
        RequestModel(pedModel)
        while not HasModelLoaded(pedModel) do
            Wait(500)
        end

        local newPed = CreatePed(4, pedModel, x, y, z, heading, false, false)
        TaskWarpPedIntoVehicle(newPed, GetVehiclePedIsUsing(newPed), -1)
        Target:MouveEntity(newPed)
    else
        local vehicleModel = GetRandomVehicleModel()
        RequestModel(vehicleModel)
        while not HasModelLoaded(vehicleModel) do
            Wait(500)
        end

        local newEntity = CreateObject(vehicleModel, x, y, z, false, false, true)
        SetEntityHeading(newEntity, heading)
        Target:MouveEntity(newEntity)
    end
end




function GetRandomPedestrianModel()
    -- Liste de modèles de piétons que vous souhaitez inclure
    local pedestrianModels = {
        "a_m_m_acult_01",
        "a_m_m_beach_01",
        "a_m_m_business_01",
        -- Ajoutez d'autres modèles de piétons ici
    }

    -- Sélectionnez un modèle de manière aléatoire
    local randomIndex = math.random(1, #pedestrianModels)
    return pedestrianModels[randomIndex]
end



function ChangeEntityToRandomVehicle(entity)
    local x, y, z = table.unpack(GetEntityCoords(entity))
    local heading = GetEntityHeading(entity)

    SetEntityAsMissionEntity(entity, false, false)
    DeleteObject(entity)

    local vehicleModel = GetRandomVehicleModel()  -- Fonction à définir
	local newEntity = CreateObject(vehicleModel, x, y, z, false, false, true)
    SetEntityHeading(newEntity, heading)
    Target:MouveEntity(newEntity)
end

function GetRandomVehicleModel()
    -- Liste de modèles de véhicules que vous souhaitez inclure
    local vehicleModels = {
        "adder",
        "comet2",
        "entityxf",
        -- Ajoutez d'autres modèles de véhicules ici
    }

    -- Sélectionnez un modèle de manière aléatoire
    local randomIndex = math.random(1, #vehicleModels)
    return vehicleModels[randomIndex]
end

function RotateObjectWithMouse(entity)
    local rotationSpeed = 12.0 -- Vous pouvez ajuster la vitesse de rotation
    local rotationActive = true

    -- Fonction pour arrêter la rotation
    function StopRotation()
        rotationActive = false
    end

    -- Attacher la fonction StopRotation à la touche 'E'
    RegisterCommand("stoprotation", StopRotation, false)

    Citizen.CreateThread(function()
        while rotationActive do
            Citizen.Wait(0)

            if DoesEntityExist(entity) then
                local _, _, zRotation = table.unpack(GetEntityRotation(entity))
                local delta = GetDisabledControlNormal(2, 2) * rotationSpeed

                -- Ajuster l'angle de rotation avec la molette de la souris
                zRotation = zRotation + delta

                -- Appliquer la nouvelle rotation
                SetEntityRotation(entity, 0.0, 0.0, zRotation)
            else
                break
            end
        end
    end)
end

