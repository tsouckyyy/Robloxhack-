-- // Interface
local ScreenGui = Instance.new("ScreenGui")
local OpenButton = Instance.new("TextButton")

ScreenGui.Name = "TeleportGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

OpenButton.Name = "OpenButton"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Position = UDim2.new(0.4, 0, 0.9, 0)
OpenButton.Size = UDim2.new(0, 200, 0, 50)
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.Text = "Lancer la boucle"
OpenButton.TextColor3 = Color3.new(1, 1, 1)
OpenButton.TextScaled = true

-- // Fonction principale
local function TeleportEtReclamerEnBoucle()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    
    -- Position de téléportation (CFrame)
    local tpCFrame = CFrame.new(260.882446, 345.758179, 26.7960835,
                                0.0871553123, 0.355917424, -0.93044436,
                                1.078579e-09, 0.933998466, 0.357276946,
                                0.99619472, -2.235174e-08, 0.0871553123)

    while true do
        -- Téléportation
        hrp.CFrame = tpCFrame
        
        -- Attente avant autoclick
        wait(4)

        -- Premier clics automatiques pendant 2 secondes
        local startTime = tick()
        while tick() - startTime < 2 do
            VirtualInputManager:SendMouseButtonEvent(
                workspace.CurrentCamera.ViewportSize.X / 2,
                workspace.CurrentCamera.ViewportSize.Y / 2,
                0,
                true,
                game,
                0
            )
            wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(
                workspace.CurrentCamera.ViewportSize.X / 2,
                workspace.CurrentCamera.ViewportSize.Y / 2,
                0,
                false,
                game,
                0
            )
        end

        -- Pause d’1 seconde
        wait(1)

        -- Deuxième clic unique
        VirtualInputManager:SendMouseButtonEvent(
            workspace.CurrentCamera.ViewportSize.X / 2,
            workspace.CurrentCamera.ViewportSize.Y / 2,
            0,
            true,
            game,
            0
        )
        wait(0.1)
        VirtualInputManager:SendMouseButtonEvent(
            workspace.CurrentCamera.ViewportSize.X / 2,
            workspace.CurrentCamera.ViewportSize.Y / 2,
            0,
            false,
            game,
            0
        )

        -- Recommence la boucle (petite pause possible si nécessaire)
        wait(2)
    end
end

-- // Activation par bouton
OpenButton.MouseButton1Click:Connect(function()
    coroutine.wrap(TeleportEtReclamerEnBoucle)()
end)
