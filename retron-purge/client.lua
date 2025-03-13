-- QBCore nesnesini elde et
local QBCore = exports['qb-core']:GetCoreObject()

-- Arınma durumunu kontrol etmek için değişken
local arinmaAktif = false  

-- Duyuru olayını kaydet
RegisterNetEvent('arinma:duyuru')  
AddEventHandler('arinma:duyuru', function(mesaj)  
    QBCore.Functions.Notify(mesaj, "error", 7500) 
end)  

-- Arınma gecesini başlatma olayı
RegisterNetEvent('arinma:baslat')  
AddEventHandler('arinma:baslat', function()  
    arinmaAktif = true  
    TriggerEvent('chat:addMessage', { args = {"[SİSTEM]", "^1Arınma Gecesi başladı! Eşyalar yere atılamaz."} })  
end)  

-- Arınma gecesini bitirme olayı
RegisterNetEvent('arinma:bitir')  
AddEventHandler('arinma:bitir', function()  
    arinmaAktif = false  
    TriggerEvent('chat:addMessage', { args = {"[SİSTEM]", "^2Arınma Gecesi sona erdi! Kurallar tekrar geçerli."} })  
end)  
