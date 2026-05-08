-- [[ KICIA HOOK V4 | XENO STABLE VERSION ]]
-- No External Libs = No Crashes

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- USTAWIANIA DOKŁADNIE JAK W KICI
getgenv().SilentAim = false
getgenv().FOV = 150
getgenv().ShowFOV = true
getgenv().TargetPart = "Head"

-- 1. STWORZENIE KOŁA FOV (Drawing API - Xeno to wspiera)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 0, 150) -- Kicia Pink
FOVCircle.Filled = false
FOVCircle.Transparency = 1

-- 2. FUNKCJA CELOWANIA (Magia 1:1)
local function GetClosestTarget()
    local target = nil
    local dist = getgenv().FOV
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(getgenv().TargetPart) then
            local pos, vis = game.Workspace.CurrentCamera:WorldToScreenPoint(v.Character[getgenv().TargetPart].Position)
            if vis then
                local magnitude = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if magnitude < dist then
                    target = v
                    dist = magnitude
                end
            end
        end
    end
    return target
end

-- 3. HOOKOWANIE MYSZKI (To sprawia, że trafiasz poza celownikiem)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(self, index)
    if self == Mouse and (index == "Hit" or index == "Target") then
        if getgenv().SilentAim then
            local target = GetClosestTarget()
            if target and target.Character then
                local part = target.Character[getgenv().TargetPart]
                return (index == "Hit" and part.CFrame or part)
            end
        end
    end
    return oldIndex(self, index)
end)
setreadonly(mt, true)

-- 4. PROSTE MENU (Zamiast zepsutych bibliotek)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "KICIA HOOK | RIVALX"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 0, 150)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Przycisk Silent Aim
local SAimBtn = Instance.new("TextButton", MainFrame)
SAimBtn.Text = "Silent Aim: OFF"
SAimBtn.Position = UDim2.new(0, 10, 0, 50)
SAimBtn.Size = UDim2.new(0, 180, 0, 40)
SAimBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SAimBtn.TextColor3 = Color3.new(1, 1, 1)

SAimBtn.MouseButton1Click:Connect(function()
    getgenv().SilentAim = not getgenv().SilentAim
    SAimBtn.Text = "Silent Aim: " .. (getgenv().SilentAim and "ON" or "OFF")
    SAimBtn.TextColor3 = getgenv().SilentAim and Color3.fromRGB(255, 0, 150) or Color3.new(1, 1, 1)
end)

-- Pętla odświeżania koła
RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = getgenv().ShowFOV
    FOVCircle.Radius = getgenv().FOV
    FOVCircle.Position = UserInputService:GetMouseLocation()
end)

print("RivalX Project: Kicia Edition Loaded!")
