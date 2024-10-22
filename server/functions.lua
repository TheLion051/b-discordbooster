
if Config.Framework = "qb" then
    local QBCore = exports['qb-core']:GetCoreObject()
    
    function ObtainDiscordIdentifier(src)
        local discord = QBCore.Functions.GetIdentifier(src, 'discord')
        return string.sub(discord, 9)
    end
    
    function Notify(src, text, notifType)
        QBCore.Functions.Notify(src, text, notifType)
    end
    
    function ProduceReward(src)
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return false end
    
        if Config.Reward.type == 'bank' then
            Player.Functions.AddMoney('bank', Config.Reward.amount, 'Discord Booster Reward')
            return true
        elseif Config.Reward.type == 'cash' then
            Player.Functions.AddMoney('cash', Config.Reward.amount, 'Discord Booster Reward')
            return true
        elseif Config.Reward.type == 'item' then
            Player.Functions.AddItem(Config.Reward.item, Config.Reward.amount, nil, {})
            return true
        end
    
        print('b-discordbooster | INVALID REWARD TYPE')
        return false
    end
elseif Config.Framework = "esx" then
    ESX = exports["es_extended"]:getSharedObject()

    function ObtainDiscordIdentifier(src)
        local identifiers = GetPlayerIdentifiers(src)
        for _, identifier in ipairs(identifiers) do
            if string.find(identifier, "discord:") then
                return string.sub(identifier, 9)
            end
        end
        return nil
    end
    
    function Notify(src, text, notifType)
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.showNotification(text)
    end
    
    function ProduceReward(src)
        local xPlayer = ESX.GetPlayerFromId(src)
        if not xPlayer then return false end
    
        if Config.Reward.type == 'bank' then
            xPlayer.addAccountMoney('bank', Config.Reward.amount)
            return true
        elseif Config.Reward.type == 'money' then
            xPlayer.addMoney(Config.Reward.amount)
            return true
        elseif Config.Reward.type == 'item' then
            xPlayer.addInventoryItem(Config.Reward.item, Config.Reward.amount)
            return true
        end
    
        print('esx-discordbooster | INVALID REWARD TYPE')
        return false
    end
else
    print('esx-discordbooster | INVALID FRAMEWORK')
end
