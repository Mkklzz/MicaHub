local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/ToraLibrarySource.lua", true))()
local Window = Library:CreateWindow("Vox Seas")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local TakeFruitsEnabled = false
local AutoQuestEnabled = false
local PanelFarmEnabled = false

local SelectedEnemyType = "Monkey"
local EnemySelectedDropdown = nil
local AttachConnection = nil

Window:AddToggle({
    text = "Take Fruits",
    flag = "toggle",
    callback = function(ToggleState)
        TakeFruitsEnabled = ToggleState
    end
})

Window:AddButton({
    text = "Farm Panel",
    flag = "button",
    callback = function()
        if not PanelFarmEnabled then
            PanelFarmEnabled = true
            
            local LibraryFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/ToraLibrarySource.lua", true))()
            local WindowFarm = LibraryFarm:CreateWindow("Vox Farms")
            
            WindowFarm:AddList({
                text = "Select Enemy",
                values = {"Monkey", "Gorilla"},
                callback = function(ListState)
                    SelectedEnemyType = ListState
                    EnemySelectedDropdown = nil
                    
                    local EnemiesFolder = workspace:FindFirstChild("Enemies")
                    if not EnemiesFolder then return end
                    
                    for _, Enemy in pairs(EnemiesFolder:GetChildren()) do
                        if Enemy:IsA("Model") and Enemy.Name == value and Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                            EnemySelectedDropdown = Enemy
                            return
                        end
                    end
                end,
                open = false,
                flag = "listflag"
            })
            
            local EnemiesFolder = workspace:FindFirstChild("Enemies")
            if EnemiesFolder then
                for _, Enemy in pairs(EnemiesFolder:GetChildren()) do
                    if Enemy:IsA("Model") and Enemy.Name == SelectedEnemyType and Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                        EnemySelectedDropdown = Enemy
                        break
                    end
                end
            end
            
            WindowFarm:AddToggle({
                text = "Auto Quest [BETA]",
                flag = "toggle",
                callback = function(ToggleState)
                    AutoQuestEnabled = ToggleState
                    
                    if AutoQuestEnabled then
                        local function FindValidEnemyFarm()
                            local EnemiesFolder = workspace:FindFirstChild("Enemies")
                            if not EnemiesFolder then return nil end
                            
                            for _, Enemy in pairs(EnemiesFolder:GetChildren()) do
                                if Enemy:IsA("Model") and Enemy.Name == SelectedEnemyType and Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                                    return Enemy
                                end
                            end
                            return nil
                        end
                        
                        local function TeleportToEnemy()
                            if not AutoQuestEnabled then return end
                            
                            local Character = Player.Character
                            if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
                            
                            if not EnemySelectedDropdown or not EnemySelectedDropdown.Parent or not EnemySelectedDropdown:FindFirstChild("HumanoidRootPart") or not EnemySelectedDropdown:FindFirstChild("Humanoid") or EnemySelectedDropdown.Humanoid.Health <= 0 then
                                EnemySelectedDropdown = FindValidEnemyFarm()
                                if not EnemySelectedDropdown then return end
                            end
                            
                            if EnemySelectedDropdown and EnemySelectedDropdown:FindFirstChild("HumanoidRootPart") then
                                local EnemyPosition = EnemySelectedDropdown.HumanoidRootPart.Position
                                Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(EnemyPosition.X, EnemyPosition.Y + 5, EnemyPosition.Z))
                            end
                        end
                        
                        AttachConnection = RunService.Heartbeat:Connect(function()
                            TeleportToEnemy()
                        end)
                        
                        local EnemiesFolder = workspace:FindFirstChild("Enemies")
                        if EnemiesFolder then
                            EnemiesFolder.ChildAdded:Connect(function(enemy)
                                if not AutoQuestEnabled then return end
                                if enemy:IsA("Model") and enemy.Name == SelectedEnemyType and not EnemySelectedDropdown then
                                    if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                        EnemySelectedDropdown = enemy
                                    end
                                end
                            end)
                            
                            if not EnemySelectedDropdown then
                                EnemySelectedDropdown = FindValidEnemyFarm()
                            end
                        end
                        
                    else
                        if AttachConnection then
                            AttachConnection:Disconnect()
                            AttachConnection = nil
                        end
                    end
                end
            })
            
            WindowFarm:AddButton({
                text = "Close",
                flag = "button",
                callback = function()
                    if not AutoQuestEnabled then
                        if AttachConnection then
                            AttachConnection:Disconnect()
                            AttachConnection = nil
                        end
                        LibraryFarm:Close()
                        PanelFarmEnabled = false
                        EnemySelectedDropdown = nil
                        SelectedEnemyType = "Monkey"
                    end
                end
            })
            
            LibraryFarm:Init()
        end
    end
})

Window:AddList({
    text = "Teleport",
    values = {"Sland Pirarte"},
    callback = function(ListState)
    end,
    open = false,
    flag = "listflag"
})

Window:AddLabel({
    text = "GitHub: Mkklzz",
    type = "label"
})

Library:Init()