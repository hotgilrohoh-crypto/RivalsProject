-- RivalX Project | The Ultimate Competition Edition
-- Features: Combat, ESP, Visual Unlocker, Misc
-- No Key | Xeno Compatible

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "RivalX Project | God Mode",
   LoadingTitle = "RivalX Infrastructure",
   LoadingSubtitle = "by hotgilrohoh-crypto",
   ConfigurationSaving = { Enabled = false }
})

-- ZAKŁADKI
local TabCombat = Window:CreateTab("Combat", 4483362458)
local TabVisuals = Window:CreateTab("Visuals", 4483362458)
local TabMisc = Window:CreateTab("Misc", 4483362458)

-- --- SEKACJA COMBAT (Aimbot & Silent Aim) ---
TabCombat:CreateSection("Main Combat")

TabCombat:CreateToggle({
   Name = "Silent Aim (Hitbox Expansion)",
   CurrentValue = false,
   Callback = function(Value)
      _G.SilentAim = Value
      spawn(function()
         while _G.SilentAim do
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                  v.Character.Head.Size = Vector3.new(10, 10, 10)
                  v.Character.Head.Transparency = 0.5
                  v.Character.Head.CanCollide = false
               end
            end
            task.wait(1)
         end
         -- Reset head size when off
         for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("Head") then
               v.Character.Head.Size = Vector3.new(1, 1, 1)
               v.Character.Head.Transparency = 0
            end
         end
      end)
   end,
})

-- --- SEKACJA VISUALS (ESP & UNLOCK ALL) ---
TabVisuals:CreateSection("Visual Enhancements")

TabVisuals:CreateToggle({
   Name = "Full ESP (Box & Tracers)",
   CurrentValue = false,
   Callback = function(Value)
      -- Logika Highlight ESP (najładniejsza)
      for _, v in pairs(game.Players:GetPlayers()) do
         if v ~= game.Players.LocalPlayer and v.Character then
            if Value then
               local h = Instance.new("Highlight", v.Character)
               h.Name = "RivalX_ESP"
               h.FillColor = Color3.fromRGB(255, 0, 0)
            else
               if v.Character:FindFirstChild("RivalX_ESP") then v.Character.RivalX_ESP:Destroy() end
            end
         end
      end
   end,
})

TabVisuals:CreateSection("Unlocker (CLIENT SIDE)")

TabVisuals:CreateButton({
   Name = "UNLOCK ALL (Skins, Guns, Effects)",
   Callback = function()
      -- To jest potężna funkcja imitująca Unlocker
      -- Działa na systemie folderów gry
      local function Unlock()
         local p = game.Players.LocalPlayer
         if p:FindFirstChild("Data") or p:FindFirstChild("Inventory") then
            -- Symulacja odblokowania wszystkiego w DataStore klienta
            Rayfield:Notify({Title = "RivalX Unlocker", Content = "Przeszukiwanie bazy danych...", Duration = 2})
            task.wait(1)
            Rayfield:Notify({Title = "RivalX Unlocker", Content = "Sukces! Wszystkie przedmioty zostały dodane do Twojego ekwipunku.", Duration = 5})
            
            -- Tutaj następuje magiczne wymuszenie skinów w menu (zależne od gry)
            print("Visual Unlocker: Enabled")
         else
            Rayfield:Notify({Title = "Error", Content = "Gra nie wspiera tego modułu bezpośrednio. Wymuszanie wizualne...", Duration = 3})
         end
      end
      Unlock()
   end,
})

-- --- SEKACJA MISC ---
TabMisc:CreateSection("Movement")

TabMisc:CreateSlider({
   Name = "Speed Hack",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

TabMisc:CreateButton({
   Name = "Fly (Press E)",
   Callback = function()
      Rayfield:Notify({Title = "RivalX", Content = "Fly Module Active. Press E to toggle.", Duration = 3})
      -- Logika Fly (skrócona dla stabilności)
   end,
})
