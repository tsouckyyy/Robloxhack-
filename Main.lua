-- [1] Téléporte le joueur
local player = game.Players.LocalPlayer
repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

local position = Vector3.new(260.882446, 345.758179, 26.7960835)
player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(position)

-- Attendre 4 secondes
wait(4)

-- [2] Crée une interface avec un bouton "🛑 Arrêter"
local gui = Instance.new("ScreenGui")
gui.Name = "AutoClaimGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local boutonStop = Instance.new("TextButton")
boutonStop.Size = UDim2.new(0, 200, 0, 50)
boutonStop.Position = UDim2.new(0.5, -100, 0.85, 0)
boutonStop.Text = "🛑 Arrêter l'auto-réclamation"
boutonStop.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
boutonStop.TextColor3 = Color3.new(1, 1, 1)
boutonStop.Font = Enum.Font.SourceSansBold
boutonStop.TextSize = 20
boutonStop.Parent = gui

-- [3] Fonction pour cliquer le bouton original 2 secondes
local function clickLong(boutonOriginal, durée)
	if boutonOriginal and boutonOriginal:IsA("TextButton") then
		local vi = game:GetService("VirtualInputManager")
		local pos = boutonOriginal.AbsolutePosition
		local size = boutonOriginal.AbsoluteSize
		local x = pos.X + size.X / 2
		local y = pos.Y + size.Y / 2

		vi:SendMouseButtonEvent(x, y, 0, true, game, 0)
		wait(durée)
		vi:SendMouseButtonEvent(x, y, 0, false, game, 0)
	end
end

-- [4] Cherche le bouton de récompense dans l’interface
local function trouverBoutonRecompense()
	local gui = player:FindFirstChild("PlayerGui"):FindFirstChild("RewardGui")
	if gui then
		return gui:FindFirstChild("ClaimRewardButton")
	end
	return nil
end

-- [5] Lancement de l’auto-réclamation
local auto = true
task.spawn(function()
	while auto do
		local bouton = trouverBoutonRecompense()
		if bouton and bouton.Visible then
			clickLong(bouton, 2)
		end
		wait(10) -- délai entre chaque tentative
	end
end)

-- [6] Bouton pour désactiver le script
boutonStop.MouseButton1Click:Connect(function()
	auto = false
	gui:Destroy()
end)
