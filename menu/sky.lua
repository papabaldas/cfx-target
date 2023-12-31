function _sky()
    Action_Config = {
        Sky = {
            {
                Type = "buttom-submenu",
                Blocked = false,
                Label = "Changer l'heure",
                IsRestricted = true,
                Action = {
                    {
                        'Matin', 
                        function() 
                            TriggerServerEvent("contextmenu:NetworkOverrideClockTime", 8)
                        end
                    },
                    {
                        'Après-midi', 
                        function() 
                            TriggerServerEvent("contextmenu:NetworkOverrideClockTime", 12)
                        end
                    },
                    {
                        'Soirée', 
                        function() 
                            TriggerServerEvent("contextmenu:NetworkOverrideClockTime", 18)
                        end
                    },
                    {
                        'Nuit', 
                        function() 
                            TriggerServerEvent("contextmenu:NetworkOverrideClockTime", 22)
                        end
                    },
                },
            },
			{
				Type = "buttom",
				IsRestricted = true,
				Blocked = false,
				CloseOnClick = false,
				Label = '<font color="#00ffff">Geler le temps</font>',
				OnClick = function()
					local currentTime = GetNetworkTime()
					local isTimeFrozen = IsPauseMenuActive()
					if isTimeFrozen then
						-- Si le temps est déjà gelé, dégelez-le
						NetworkOverrideClockTime(currentTime, false)
						SetRandomWeatherType(false)
						TriggerEvent("chatMessage", "SYSTEM", { 255, 0, 0 }, "Le temps a été dégelé.")
					else
						-- Si le temps n'est pas gelé, geler-le
						NetworkOverrideClockTime(currentTime, true)
						SetRandomWeatherType(true)
						TriggerEvent("chatMessage", "SYSTEM", { 255, 0, 0 }, "Le temps a été gelé.")
					end
				end,
			},
            {
                Type = "buttom-submenu",
                Blocked = false,
                Label = "Changer la météo",
                IsRestricted = true,
                Action = {
                    {
                        'Clear', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'CLEAR')
                        end
                    },
                    {
                        'Clearing', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'CLEARING')
                        end
                    },
                    {
                        'Clouds', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'CLOUDS')
                        end
                    },
                    {
                        'Extra Sunny', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'EXTRASUNNY')
                        end
                    },
                    {
                        'Foggy', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'FOGGY')
                        end
                    },
                    {
                        'Overcast', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'OVERCAST')
                        end
                    },
                    {
                        'Rain', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'RAIN')
                        end
                    },
                    {
                        'Smog', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'SMOG')
                        end
                    },
                    {
                        'Thunder', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'THUNDER')
                        end
                    },
                    {
                        'Xmas', 
                        function() 
                            TriggerServerEvent("contextmenu:SetWeatherType", 'XMAS')
                        end
                    },
                },
            },
        },
    }
end
