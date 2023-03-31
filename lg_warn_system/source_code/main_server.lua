--//TOUCHEZ QUE SI VOUS SAVEZ CE QUE VOUS FAITES
--//TOUCHEZ QUE SI VOUS SAVEZ CE QUE VOUS FAITES
--//TOUCHEZ QUE SI VOUS SAVEZ CE QUE VOUS FAITES

local DataStoreService = game:GetService("DataStoreService")
local warns_db = DataStoreService:GetDataStore("warns")
local WarnCard = game:GetService("ServerStorage"):WaitForChild("LG_STUFF").WarnCard
local WarnCardR = game:GetService("ServerStorage"):WaitForChild("LG_STUFF").WarnCardR
local Config = require(game:GetService("ServerScriptService"):WaitForChild("LG_WARN_SYSTEM").Config)

game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").SendWarn.OnServerEvent:Connect(function(wmod, plrToWarn, wreason)
	if not table.find(Config.Admins, wmod.UserId) then
		wmod:Kick("LG ANTI EXPLOIT : Vous n'avez pas le droit d'utiliser ceci.")
		return
	end
	
	local key = "plr_"..game:GetService("Players"):GetUserIdFromNameAsync(plrToWarn)
	local DateData = os.date("*t")
	
	local succes, errormessage = pcall(function()
		local data = warns_db:GetAsync(key)
		
		if data == nil then
			warns_db:SetAsync(key, {
				ActualWarns = 1,
				Warns = {
					[1] = {
						Date = tostring(DateData.day.."/"..DateData.month.."/"..DateData.year),
						Mod = tostring(wmod),
						Reason = tostring(wreason),
					}
				}
			})
		else
			local NewAWN = data.ActualWarns + 1
			local NewWarn = {
				Date = tostring(DateData.day.."/"..DateData.month.."/"..DateData.year),
				Mod = tostring(wmod),
				Reason = tostring(wreason),
			}
			
			table.insert(data.Warns, NewWarn)
			
			warns_db:SetAsync(key, {
				ActualWarns = NewAWN,
				Warns = data.Warns,
			})
		end
	end)
	
	if not succes then
		print("Une erreur est survenue lors de l'atribution du warn")
		warn(errormessage)
	end
end)

game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").RequestWarns.OnServerEvent:Connect(function(mod, plr)
	local key = "plr_"..game:GetService("Players"):GetUserIdFromNameAsync(plr)
	local UI = mod.PlayerGui:WaitForChild("AdminWarn", 10)
	
	for i, v in pairs(UI.BaseFrame.MainFrame.Warns:GetDescendants()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
	
	local succes, errormessage = pcall(function()
		local data = warns_db:GetAsync(key)
		
		if data == nil or data.ActualWarns == 0 then
			UI.BaseFrame.MainFrame.NoWarns.TextTransparency = 0
			UI.BaseFrame.MainFrame.ActualWarnsT.TextTransparency = 1
		else
			UI.BaseFrame.MainFrame.NoWarns.TextTransparency = 1
			UI.BaseFrame.MainFrame.ActualWarnsT.Text = "Le joueur possède "..data.ActualWarns.." warn(s)"
			UI.BaseFrame.MainFrame.ActualWarnsT.TextTransparency = 0
			local actualCard = 1
			for i = 1, data.ActualWarns do
				if table.find(Config.SuperAdmins, mod.UserId) then
					local NewCard = WarnCardR:Clone()
					NewCard.Name = "Warn"..actualCard
					NewCard.Infos.Text = 'Date : <font color="#ffa600">'..data.Warns[actualCard].Date..'</font>\nAttribué par : <font color="#ffa600">'..data.Warns[actualCard].Mod..'</font>'
					NewCard.ReasonBG.Reason.Text = data.Warns[actualCard].Reason
					NewCard.Parent = UI.BaseFrame.MainFrame.Warns
					NewCard:SetAttribute("id", actualCard)
					actualCard += 1
				else
					local NewCard = WarnCard:Clone()
					NewCard.Name = "Warn"..actualCard
					NewCard.Infos.Text = 'Date : <font color="#ffa600">'..data.Warns[actualCard].Date..'</font>\nAttribué par : <font color="#ffa600">'..data.Warns[actualCard].Mod..'</font>'
					NewCard.ReasonBG.Reason.Text = data.Warns[actualCard].Reason
					NewCard.Parent = UI.BaseFrame.MainFrame.Warns
					NewCard:SetAttribute("id", actualCard)
					actualCard += 1
				end
			end
		end
	end)
	
	if not succes then
		print("Une erreur est survenue lors de la requête des warns")
		warn(errormessage)
	end
end)

game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").RemoveWarn.OnServerEvent:Connect(function(mod, plr, warnId)
	if not table.find(Config.SuperAdmins, mod.UserId) then
		mod:Kick("LG ANTI EXPLOIT : Vous n'avez pas le droit d'utiliser ceci.")
		return
	end
	
	local key = "plr_"..game:GetService("Players"):GetUserIdFromNameAsync(plr)
	
	local succes, errormessage = pcall(function()
		local data = warns_db:GetAsync(key)
		local NewAWN = data.ActualWarns - 1
		
		table.remove(data.Warns, warnId)
		
		warns_db:SetAsync(key, {
			ActualWarns = NewAWN,
			Warns = data.Warns,
		})
	end)
	
	if not succes then
		print("Une erreur est survenue lors de la suppression du warn")
		warn(errormessage)
	end
end)

game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").GiveMenu.OnServerEvent:Connect(function(plr)
	if table.find(Config.Admins, plr.UserId) or table.find(Config.SuperAdmins, plr.UserId) then
		local NewAdminMenu = game:GetService("ServerStorage"):WaitForChild("LG_STUFF").AdminWarn:Clone()
		NewAdminMenu.Parent = plr.PlayerGui
	end
end)