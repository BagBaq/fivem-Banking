ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('banking:depoMoney')
AddEventHandler('banking:depoMoney', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
        if amount == nil or amount <= 0 then
                TriggerClientEvent('banking:effect', _source, "error", "Gecersiz miktar")
        if amount > xPlayer.getMoney() then
		TriggerClientEvent('banking:effect', _source, "error", "Yetersiz para")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('banking:effect', _source, "success", "Para bankaya yatırıldı")
	end
end)


RegisterServerEvent('banking:withdraw')
AddEventHandler('banking:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
        if amount > base then
                TriggerClientEvent('banking:effect', _source, "error", "Bankanizda bu kadar para yok")
        end
	if amount == nil or amount <= 0 then
		TriggerClientEvent('banking:effect', _source, "error", "Gecersiz miktar")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('banking:effect', _source, "success", "Paranizi cektiniz")
	end
end)

RegisterServerEvent('banking:checkBalance')
AddEventHandler('banking:checkBalance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentBalance', _source, balance)
end)


RegisterServerEvent('banking:transferCash')
AddEventHandler('banking:transferCash', function(tPlayer, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(tPlayer)
	local balance = 0

	if(zPlayer == nil or zPlayer == -1) then
		TriggerClientEvent('banking:effect', _source, "error", "Boyle bir oyuncu yok")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = zPlayer.getAccount('bank').money
		
		if tonumber(_source) == tonumber(tPlayer) then
			TriggerClientEvent('banking:effect', _source, "error", "Kendinize para gönderemezsiniz")
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('banking:effect', _source, "error", "Yetersiz para")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))
				TriggerClientEvent('banking:effect', _source, "success", "Transfer edildi")
			end
		end
	end
end)



