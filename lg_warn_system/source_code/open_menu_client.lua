game.Players.LocalPlayer.Chatted:Connect(function(msg)
	if msg == "!warn" then
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild("AdminWarn") then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Menu des warns",
				Text = "Le menu est déjà ouvert",
				Duration = 5,
			})
			return
		end
		game:GetService("ReplicatedStorage"):WaitForChild("LG_STUFF").GiveMenu:FireServer()
	end
end)