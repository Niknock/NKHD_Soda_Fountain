Config = {}

Config.Framework = 'ESX' -- 'ESX' or 'QBCore'
Config.ESX = 'New' -- If you use ESX 'New' or 'Old'

Config.TargetSystem = 'ox_target' -- 'ox_target' or 'qtarget

Config.Drinks = {
    { label = 'E-Cola', item = 'e-cola', price = 10, notification = 'You got a E-Cola!' },
    { label = 'Sprunk', item = 'sprunk', price = 10, notification = 'You got a Sprunk!' },
    { label = 'Water', item = 'water', price = 5, notification = 'You got Water!' },
}

Config.RequiresPayment = true

Config.SodaProps = {
    'prop_food_bs_soda_02',
    'prop_food_bs_soda_01',
    'prop_food_cb_soda_02',
    'prop_food_cb_soda_01'
}

Config.UseUI = true

Config.Debug = false