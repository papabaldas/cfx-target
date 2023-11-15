


function _My()
    Action_Config = {
        My = {
            {
                Type = "buttom",
                IsRestricted = false,
                Blocked = false,
                CloseOnClick = false,
                Label = ("Mon ID : %s"):format(GetPlayerServerId(PlayerId())),
                OnClick = function()
                end,
            },
            {
                Type = "buttom",
                IsRestricted = false,
                Blocked = false,
                CloseOnClick = false,
                Label = ("Mon nom : %s"):format(GetPlayerName(PlayerId())),
                OnClick = function()
                end,
            },
            {
                Type = "buttom",
                IsRestricted = true,
                Blocked = false,
                CloseOnClick = false,
                Label = "Activer le God Mode",
                OnClick = function()
                    local playerPed = PlayerId()
                    local godMode = not GetPlayerInvincible(playerPed)

                    if godMode then
						SetPlayerInvincible(playerPed, true)
						print("God Mode activé.")
					else
						SetPlayerInvincible(playerPed, false)
						print("God Mode désactivé.")
					end

                end,
            },
			-- {
				-- Type = "buttom",
				-- IsRestricted = false,
				-- Blocked = false,
				-- CloseOnClick = true,
				-- Label = "Give Item",
				-- OnClick = function()
					-- local itemName = exports["cfx-target"]:ShowSync('Entrez le nom de l\'item', false, 320., "small_text")
					-- local quantity = tonumber(exports["cfx-target"]:ShowSync('Entrez la quantité', false, 320., "small_text"))
					-- if itemName and quantity then
						-- local itemLabel = ESX.GetItemLabel(itemName)
						-- if itemLabel then
							-- TriggerServerEvent("esx_extended:giveInventoryItem", GetPlayerServerId(PlayerId()), itemName, quantity)
						-- else
							-- print("Nom de l'item invalide.")
						-- end
					-- else
						-- print("Nom de l'item ou quantité invalide.")
					-- end
				-- end,
			-- },

            -- {
                -- Type = "buttom",
                -- IsRestricted = false,
                -- Blocked = false,
                -- CloseOnClick = true,
                -- Label = "Me (...)",
                -- OnClick = function()
                    -- local imput = exports["cfx-target"]:ShowSync('Entrez un nom', false, 320., "small_text")
                    -- TriggerServerEvent("contextmenu:me", imput, PlayerPedId())
                -- end,
            -- },
        },
    }
end


RegisterNetEvent("godmode:status")
AddEventHandler("godmode:status", function(godModeStatus)
    if godModeStatus then
        print("God Mode activé.")
    else
        print("God Mode désactivé.")
    end
end)


