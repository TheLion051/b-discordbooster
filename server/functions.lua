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
