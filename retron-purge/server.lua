local QBCore = exports['qb-core']:GetCoreObject()  
local arinmaAktif = false  
local players = {}  

-- Arınmayı Başlatma Komutu  
QBCore.Commands.Add("arinmabaslat", "Arınma Gecesini Başlatır (Admin Komutu)", {}, false, function(source, args)  
    local adminAdi = GetPlayerName(source)  
    local duyuruMesaji = "Arınma Gecesi " .. adminAdi .. " tarafından başlatıldı! Her şey serbest!"  
    arinmaAktif = true  

    TriggerClientEvent('arinma:duyuru', -1, duyuruMesaji)  
    TriggerClientEvent('arinma:baslat', -1)  
end, 'admin')  

-- Arınmayı Bitirme Komutu  
QBCore.Commands.Add("arinmabitir", "Arınma Gecesini Bitirir (Admin Komutu)", {}, false, function(source, args)  
    local adminAdi = GetPlayerName(source)  
    local duyuruMesaji = "Arınma Gecesi " .. adminAdi .. " tarafından bitirilmiştir!"  
    arinmaAktif = false  

    TriggerClientEvent('arinma:duyuru', -1, duyuruMesaji)  
    TriggerClientEvent('arinma:bitir', -1)  
end, 'admin')  

-- Arınma Gecesi Itemlerini Ver  
QBCore.Commands.Add("arinma", "Arınma Gecesi Itemlerini Verir", {}, false, function(source, args)  
    if not arinmaAktif then  
        TriggerClientEvent('QBCore:Notify', source, "Arınma Gecesi Aktif Değil!", "error")  
        return  
    end  

    local cooldownSuresi = 1 * 10 -- 3 dakika  
    local sonKullanim = players[source] and players[source].arinmaSonKullanim or 0  

    if (GetGameTimer() - sonKullanim) < (cooldownSuresi * 1000) then  
        local kalanSure = cooldownSuresi - math.floor((GetGameTimer() - sonKullanim) / 1000)  
        TriggerClientEvent('QBCore:Notify', source, "Bu komutu tekrar kullanmak için " .. kalanSure .. " saniye beklemelisin.", "error")  
        return  
    end  

    local verilecekItemler = {  
        {item = "weapon_machinepistol", amount = 1},  
        {item = "bandage", amount = 30},  
        {item = "heavyarmor", amount = 30},  
        {item = "ammo-9", amount = 30},  
        {item = "radio", amount = 1},  
    }  

    for _, item in ipairs(verilecekItemler) do  
        exports.ox_inventory:AddItem(source, item.item, item.amount, {metadata = {arinma = true, quality = 100}})  
    end  

    players[source] = { arinmaSonKullanim = GetGameTimer() }  

end, 'user')   
