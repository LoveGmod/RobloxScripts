local MainFrame = script.Parent
local PlayersOnline = MainFrame:WaitForChild("PlayersOnline")
local PlayersScrollingFrame = MainFrame:WaitForChild("Players")
local PlayerCard = game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").PlayerCard
local Players = game:GetService("Players")
local SelectedPlayerText = MainFrame:WaitForChild("SelectedPlayer")
local AddWarnButton = MainFrame:WaitForChild("AddWarnButton")
local AddWarn = MainFrame:WaitForChild("AddWarn")
local Warns = MainFrame:WaitForChild("Warns")
local SendDebounce = false

for i, v in pairs(Players:GetPlayers()) do
	local NewCard = PlayerCard:Clone()
	NewCard.Name = v.Name
	NewCard.Text = v.Name
	NewCard.Parent = PlayersScrollingFrame
end

PlayersOnline.Text = "Joueur(s) connecté(s) : "..#Players:GetPlayers()

game.Players.PlayerAdded:Connect(function(plr)
	local NewCard = PlayerCard:Clone()
	NewCard.Name = plr.Name
	NewCard.Text = plr.Name
	NewCard.Parent = PlayersScrollingFrame
	PlayersOnline.Text = "Joueur(s) connecté(s) : "..#Players:GetPlayers()
end)

game.Players.PlayerRemoving:Connect(function(plr)
	PlayersScrollingFrame:FindFirstChild(plr.Name):Destroy()
	PlayersOnline.Text = "Joueur connectés : "..#Players:GetPlayers()
end)

MainFrame:GetAttributeChangedSignal("selectedPlayer"):Connect(function()
	SelectedPlayerText.Text = "Warns du joueur <b>"..MainFrame:GetAttribute("selectedPlayer").."</b>"
	game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").RequestWarns:FireServer(MainFrame:GetAttribute("selectedPlayer"))
end)

AddWarnButton.MouseButton1Click:Connect(function()
	if SendDebounce  then
		return
	end
	if MainFrame:GetAttribute("selectedPlayer") == "" then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Menu des Warns",
			Text = "Vous devez d'abbord sélectionner un joueur !",
			Duration = 5,
		})
	else
		AddWarn.Visible = true
	end
end)

AddWarn.NewWarn.Reason.Changed:Connect(function()
	AddWarn.NewWarn.Reason.Text = AddWarn.NewWarn.Reason.Text:sub(1, 100)
	AddWarn.NewWarn.LimitCharacters.Text = AddWarn.NewWarn.Reason.Text:len().."/100"
end)

AddWarn.NewWarn.Cancel.MouseButton1Click:Connect(function()
	AddWarn.NewWarn.Reason.Text = ""
	AddWarn.Visible = false
end)

AddWarn.NewWarn.Reason.FocusLost:Connect(function()
	AddWarn.NewWarn.Reason:SetAttribute("actualReason", AddWarn.NewWarn.Reason.Text)
end)

AddWarn.NewWarn.Reason.Focused:Connect(function()
	AddWarn.NewWarn.Reason.Text = AddWarn.NewWarn.Reason:GetAttribute("actualReason")
end)

AddWarn.NewWarn.Validate.MouseButton1Click:Connect(function()
	if not game.Players:FindFirstChild(MainFrame:GetAttribute("selectedPlayer")) then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Menu des Warns",
			Text = "Vous devez d'abbord sélectionner un joueur !",
			Duration = 5,
		})
		AddWarn.Visible = false
		AddWarn.NewWarn.Reason.Text = ""
		AddWarn.NewWarn.Reason:SetAttribute("actualReason", "")
		return
	end
	
	SendDebounce = true
	game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").SendWarn:FireServer(MainFrame:GetAttribute("selectedPlayer"), AddWarn.NewWarn.Reason.Text)
	AddWarn.Visible = false
	AddWarn.NewWarn.Reason.Text = ""
	AddWarn.NewWarn.Reason:SetAttribute("actualReason", "")
	AddWarnButton.Text = "Veuillez Patienter"
	Warns:SetAttribute("removeDebounce", true)
	wait(1)
	game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").RequestWarns:FireServer(MainFrame:GetAttribute("selectedPlayer"))
	wait(3)
	AddWarnButton.Text = "Ajouter un Warn"
	SendDebounce = false
end)

Warns:GetAttributeChangedSignal("removeDebounce"):Connect(function()
	wait(5)
	Warns:SetAttribute("removeDebounce", false)
end)

while wait(30) do
	if MainFrame:GetAttribute("selectedPlayer") ~= "" then
		game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").RequestWarns:FireServer(MainFrame:GetAttribute("selectedPlayer"))
	end
end