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

if Config.TargetSystem == 'ox_target' then
    for _, propName in ipairs(Config.SodaProps) do
        exports.ox_target:addModel(propName, {
            {
                event = 'sodafountain:openMenu',
                icon = 'fas fa-glass-whiskey',
                label = 'Use Soda Fountain',
                distance = 2.5,
            }
        })
    end
elseif Config.TargetSystem == 'qtarget' then
    for _, propName in ipairs(Config.SodaProps) do
        exports.qtarget:AddTargetModel(propName, {
            options = {
                {
                    event = 'sodafountain:openMenu',
                    icon = 'fas fa-glass-whiskey',
                    label = 'Use Soda Fountain',
                }
            },
            distance = 2.5
        })
    end
end

RegisterNetEvent('sodafountain:openMenu', function()
    if Config.UseUI then
        SetNuiFocus(true, true) 
        SendNUIMessage({
            action = 'openMenu',
            drinks = Config.Drinks
        })
    else
        local elements = {}
        for _, drink in ipairs(Config.Drinks) do
            table.insert(elements, { label = drink.label .. ' ($' .. drink.price .. ')', value = drink.item, price = drink.price })
        end

        if Config.Framework == 'ESX' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'soda_fountain_menu', {
                title = 'Soda Fountain',
                align = 'top-left',
                elements = elements
            }, function(data, menu)
                TriggerServerEvent('sodafountain:dispenseDrink', data.current.value, data.current.price)
                menu.close()
            end, function(data, menu)
                menu.close()
            end)
        elseif Config.Framework == 'QBCore' then
            exports['qb-menu']:openMenu(elements, function(data, menu)
                if data.value then
                    TriggerServerEvent('sodafountain:dispenseDrink', data.value, data.price)
                end
            end)
        end
    end
end)

RegisterNUICallback('selectDrink', function(data)
    if Config.Debug == true then
        print('Drink selected:', data.item, data.price) 
    end
    TriggerServerEvent('sodafountain:dispenseDrink', data.item, data.price)
    SetNuiFocus(false, false) 
    SendNUIMessage({ action = 'closeMenu' }) 
end)

RegisterNUICallback('closeMenu', function()
    SetNuiFocus(false, false) 
    SendNUIMessage({ action = 'closeMenu' })
end)
