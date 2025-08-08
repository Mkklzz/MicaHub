local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/ToraLibrarySource.lua", true))()
local Window = Library:CreateWindow("Vox Seas")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local TakeFruitsEnabled = false
local AutoQuestEnabled = false
local PanelFarmEnabled = false

local EnemySelectedDropdown = {
    SelectedSlandFarm = nil,
    AttachConnectionEnemy = nil,
    Enemies = {}
}

local SlandData = {
    Sland1 = {
        Location = game.workspace.Enemies,
        Enemies = {
            "EnemyTreiner",
            "Monkey", 
            "Gorila"
        }
    },
    Sland2 = {
        Location = game.workspace.Enemies,
        Enemies = {
            "EnemyKolar",
            "EnemyMelioda",
            "EnemyJeohe"
        }
    }
}

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
                text = "Select Sland",
                values = {"Sland1", "Sland2"},
                callback = function(value)
                    local SlandInfo = SlandData[value]
                    if SlandInfo then
                        EnemySelectedDropdown.SelectedSlandFarm = value
                        EnemySelectedDropdown.Enemies = SlandInfo.Enemies
                    end
                end,
                open = false,
                flag = "dropdown"
            })
            
            WindowFarm:AddToggle({
                text = "Auto Quest [BETA]",
                flag = "toggle",
                callback = function(ToggleState)
                    if not EnemySelectedDropdown.SelectedSlandFarm or #EnemySelectedDropdown.Enemies == 0 then
                        return
                    end
                    
                    AutoQuestEnabled = ToggleState
                    
                    if AutoQuestEnabled then
                        EnemySelectedDropdown.AttachConnectionEnemy = RunService.Heartbeat:Connect(function()
                            if not AutoQuestEnabled then return end
                            
                            local Character = Player.Character
                            if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
                            
                            if not TakeFruitsEnabled or not TakeFruitsEnabled.Parent or not TakeFruitsEnabled:FindFirstChild("HumanoidRootPart") or not TakeFruitsEnabled:FindFirstChild("Humanoid") or TakeFruitsEnabled.Humanoid.Health <= 0 then
                                TakeFruitsEnabled = nil
                                
                                local SlandInfo = SlandData[EnemySelectedDropdown.SelectedSlandFarm]
                                if SlandInfo and SlandInfo.Location then
                                    for _, Enemy in pairs(SlandInfo.Location:GetChildren()) do
                                        if Enemy:IsA("Model") and Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                                            for _, EnemyName in pairs(EnemySelectedDropdown.Enemies) do
                                                if Enemy.Name == EnemyName then
                                                    TakeFruitsEnabled = Enemy
                                                    break
                                                end
                                            end
                                            if TakeFruitsEnabled then break end
                                        end
                                    end
                                end
                            end
                            
                            if TakeFruitsEnabled then
                                local EnemyPosition = TakeFruitsEnabled.HumanoidRootPart.Position
                                Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(EnemyPosition.X, EnemyPosition.Y + 5, EnemyPosition.Z))
                            end
                        end)
                    else
                        if EnemySelectedDropdown.AttachConnectionEnemy then
                            EnemySelectedDropdown.AttachConnectionEnemy:Disconnect()
                            EnemySelectedDropdown.AttachConnectionEnemy = nil
                        end
                        TakeFruitsEnabled = false
                    end
                end
            })
            
            WindowFarm:AddButton({
                text = "Close",
                flag = "button",
                callback = function()
                    if not AutoQuestEnabled then
                        LibraryFarm:Close()
                        PanelFarmEnabled = false
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
    flag = "dropdown"
})

Window:AddLabel({
    text = "GitHub: Mkklz-h",
    type = "label"
})

Library:Init()