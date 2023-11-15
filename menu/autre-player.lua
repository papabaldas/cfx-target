Action_Config = {
    Player = {
        {
            Type = "buttom",
            IsRestricted = false,
            Blocked = false,
            CloseOnClick = false,
            Label = "ID : " .. (GetPlayerIdFromPed(LastEntityHit) or "Inconnu"),
            OnClick = function()
            end,
        },
        {
            Type = "buttom",
            IsRestricted = false,
            Blocked = false,
            CloseOnClick = false,
            Label = "Nom : " .. (GetPlayerName(GetPlayerIdFromPed(LastEntityHit)) or "Inconnu"),
            OnClick = function()
            end,
        },
        {
            Type = "buttom",
            IsRestricted = true,
            Blocked = false,
            CloseOnClick = false,
            Label = "Kick le joueur",
            OnClick = function()
                local playerId = GetPlayerIdFromPed(LastEntityHit)
                if playerId then
                    DropPlayer(playerId, "Vous avez été kické du serveur.")
                else
                    print("Impossible de kicker le joueur : ID introuvable")
                end
            end,
        },
    },
}
