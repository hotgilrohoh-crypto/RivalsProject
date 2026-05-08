-- main.lua
-- Główny skrypt Twojego narzędzia.
-- Wklej tutaj kod, który ma się uruchomić po załadowaniu.

print("RivalX Project: main.lua loaded")

-- Przykładowy prosty GUI dla Roblox:
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RivalXGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 0, 40)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 1
label.Text = "RivalX Project"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Font = Enum.Font.GothamBold
label.TextSize = 24
label.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0.5, -60, 1, -50)
button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
button.BorderSizePixel = 0
button.Text = "Kliknij mnie"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 18
button.Parent = frame

button.MouseButton1Click:Connect(function()
    print("Przycisk RivalX został kliknięty!")
end)
