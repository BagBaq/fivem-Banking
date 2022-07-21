ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('banking:depoMoney')
AddEventHandler('banking:depoMoney', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
        --if amount == nil or amount <= 0 then
        -- yanlis girilmis para
		--end
        --if amount > xPlayer.getMoney() then
		-- yetersiz para
		--end
	--else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		-- basarili
	--end
end)


RegisterServerEvent('banking:withdraw')
AddEventHandler('banking:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
        if amount > base then
			-- yetersiz para
        end
	if amount == nil or amount <= 0 then
		-- yanlis girilmis para
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		-- basarili alert
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
		-- oyuncu bulunamadı alert
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = zPlayer.getAccount('bank').money
		
		if tonumber(_source) == tonumber(tPlayer) then
			--kendimize para gönderme alert
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				-- para yok alert
			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))
				-- basarili alert
			end
		end
	end
end)



