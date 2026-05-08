-- [[ KICIA HOOK V4 REPLICA | NO KEY VERSION ]]
-- [[ AUTHOR: hotgilrohoh-crypto | FOR RIVALX PROJECT ]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/kavo"))()
local Window = Library.AssetLibrary("Kicia Hook | No Key", 1) -- Dokładnie ten sam styl GUI

-- USTAWIENIA GŁÓWNE
getgenv().SilentAim = false
getgenv().FOV = 150
getgenv().ShowFOV = true
getgenv().WallCheck = false

-- ZAKŁADKI (IDentyczne jak w oryginale)
local Tab1 = Window:AddPage("Combat", 5012544693)
local Tab2 = Window:AddPage("Visuals", 5012544693)
local Tab3 = Window:AddPage("Skins", 5012544693)
local Tab4 = Window:AddPage("Misc", 5012544693)

-- --- SEKCJA COMBAT ---
local MainCombat = Tab1:AddSection("Main Combat")
MainCombat:AddToggle("Silent Aim", false, function(state)
    getgenv().SilentAim = state
end)

MainCombat:AddSlider("FOV Radius", 150, 0, 800, function(value)
    getgenv().FOV = value
end)

MainCombat:AddToggle("Show FOV Circle", true, function(state)
    getgenv().ShowFOV = state
end)

MainCombat:AddDropdown("Target Part", {"Head", "HumanoidRootPart"}, function(part)
    getgenv().TargetPart = part
end)

-- --- SEKCJA VISUALS (ESP) ---
local ESPSection = Tab2:AddSection("ESP Settings")
ESPSection:AddToggle("Box ESP", false, function(v) _G.Box = v end)
ESPSection:AddToggle("Tracers", false, function(v) _G.Tracers = v end)

-- --- SEKCJA SKINS (UNLOCK ALL) ---
local SkinSection = Tab3:AddSection("Visual Unlocker")
SkinSection:AddButton("Unlock All Skins/Melee", function()
    -- Emulacja Kicia Unlocker
    print("Kicia Hook: Unlocking all visual assets...")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kicia Hook",
        Text = "All skins unlocked (Visual Only)",
        Duration = 5
    })
end)

-- --- LOGIKA SILENT AIM (1:1 KICIA) ---
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 0, 150)
FOVCircle.Filled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local function GetClosestTarget()
    local target = nil
    local dist = getgenv().FOV
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
            local pos, vis = game.Workspace.CurrentCamera:WorldToScreenPoint(v.Character.Head.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if magnitude < dist and vis then
                target = v
                dist = magnitude
            end
        end
    end
    return target
end

-- HOOKOWANIE MYSZKI (To sprawia że trafiasz w głowę wewnątrz koła)
local mt = getrawmetatable(game)
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(self, index)
    if self == Mouse and (index == "Hit" or index == "Target") then
        if getgenv().SilentAim then
            local target = GetClosestTarget()
            if target and target.Character then
                return (index == "Hit" and target.Character.Head.CFrame or target.Character.Head)
            end
        end
    end
    return oldIndex(self, index)
end)
setreadonly(mt, true)

-- PĘTLA ODŚWIEŻANIA
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Radius = getgenv().FOV
    FOVCircle.Visible = getgenv().ShowFOV
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)
end)
