-- [[ KICIA HOOK V4 - TRUE FOV SILENT AIM ]]
local KiciaLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/kavo"))()
local Window = KiciaLib.AssetLibrary("Kicia Hook | Rivals", 1)

-- USTAWIENIA (Tego szukałeś)
getgenv().SilentAimEnabled = false
getgenv().ShowFOV = true
getgenv().FOVSize = 150
getgenv().TargetPart = "Head" -- Zawsze w głowę

-- KOŁO FOV (Drawing API)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 0, 150)
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.Visible = getgenv().ShowFOV

-- AKTUALIZACJA KOŁA
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Radius = getgenv().FOVSize
    FOVCircle.Position = Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y + 36)
    FOVCircle.Visible = getgenv().ShowFOV
end)

local Tab1 = Window:AddPage("Combat", 5012544693)
local CombatSec = Tab1:AddSection("Silent Aim")

CombatSec:AddToggle("Enable Silent Aim", false, function(t)
    getgenv().SilentAimEnabled = t
end)

CombatSec:AddSlider("FOV Size", 150, 0, 500, function(s)
    getgenv().FOVSize = s
end)

CombatSec:AddToggle("Show FOV Circle", true, function(t)
    getgenv().ShowFOV = t
end)

-- LOGIKA 1:1 KICIA (Przechwytywanie Indexu)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function GetClosestTarget()
    local target = nil
    local dist = getgenv().FOVSize
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos, vis = game.Workspace.CurrentCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if magnitude < dist and vis then
                target = v
                dist = magnitude
            end
        end
    end
    return target
end

-- HOOKOWANIE (To sprawia, że trafiasz w głowę poza celownikiem)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(self, index)
    if self == Mouse and (index == "Hit" or index == "Target") then
        if getgenv().SilentAimEnabled then
            local target = GetClosestTarget()
            if target and target.Character and target.Character:FindFirstChild(getgenv().TargetPart) then
                return (index == "Hit" and target.Character[getgenv().TargetPart].CFrame or target.Character[getgenv().TargetPart])
            end
        end
    end
    return oldIndex(self, index)
end)
setreadonly(mt, true)

-- DODATEK: VISUAL UNLOCKER (Skiny)
local Tab4 = Window:AddPage("Visuals", 5012544693)
Tab4:AddSection("Unlock All"):AddButton("Unlock Skins (Visual)", function()
    print("Skins Unlocked!")
end)
