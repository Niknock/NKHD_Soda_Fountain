Config = Config or {}

if Config.Framework == 'ESX' then
    ESX = nil
    if Config.ESX == 'Old' then
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    elseif Config.ESX == 'New' then
        ESX = exports["es_extended"]:getSharedObject()
    else
        if Config.Debug == true then
            print('Wrong ESX Type!')
        end
    end
end

if Config.Framework == 'QBCore' then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent('sodafountain:dispenseDrink', function(item, price)
    local xPlayer = nil
    local src = source
    
    if Config.Framework == 'ESX' then
        xPlayer = ESX.GetPlayerFromId(src)
    elseif Config.Framework == 'QBCore' then
        xPlayer = QBCore.Functions.GetPlayer(src)
    end
    
    if xPlayer then
        if Config.RequiresPayment then
            local playerMoney
            if Config.Framework == 'ESX' then
                playerMoney = xPlayer.getMoney()
            elseif Config.Framework == 'QBCore' then
                playerMoney = xPlayer.PlayerData.money['cash'] 
            end
            
            if playerMoney >= price then
                if Config.Framework == 'ESX' then
                    xPlayer.removeMoney(price)
                    xPlayer.addInventoryItem(item, 1)
                    TriggerClientEvent('esx:showNotification', src, 'You bought a ' .. item .. ' for $' .. price)
                elseif Config.Framework == 'QBCore' then
                    xPlayer.Functions.RemoveMoney('cash', price)
                    xPlayer.Functions.AddItem(item, 1)
                    TriggerClientEvent('QBCore:Notify', src, 'You bought a ' .. item .. ' for $' .. price, 'success')
                end
            else
                if Config.Framework == 'ESX' then
                    TriggerClientEvent('esx:showNotification', src, 'Not enough money!')
                elseif Config.Framework == 'QBCore' then
                    TriggerClientEvent('QBCore:Notify', src, 'Not enough money!', 'error')
                end
            end
        else
            if Config.Framework == 'ESX' then
                xPlayer.addInventoryItem(item, 1)
                TriggerClientEvent('esx:showNotification', src, 'You got a free ' .. item .. '!')
            elseif Config.Framework == 'QBCore' then
                xPlayer.Functions.AddItem(item, 1)
                TriggerClientEvent('QBCore:Notify', src, 'You got a free ' .. item .. '!', 'success')
            end
        end
    end
end)
