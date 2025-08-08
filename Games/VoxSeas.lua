local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/ToraLibrarySource.lua", true))()
local Window = Library:CreateWindow("Vox Seas")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local TakeFruitsEnabled = false
local AutoQuestEnabled = false
local PanelFarmEnabled = false

local EnemySelectedDropdown = {
    SelectedSlandFarm = "Sland1",
    AttachConnectionEnemy = nil,
    EnemySelectedFarm = nil,
    Enemies = {"Treiner", "Monkey", "Gorilla"}
}

local SlandData = {
    Sland1 = {
        Location = workspace.Enemies,
        Enemies = {
            "Treiner",
            "Monkey", 
            "Gorilla"
        }
    },
    Sland2 = {
        Location = workspace.Enemies,
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
                            
                            if not EnemySelectedDropdown.EnemySelectedFarm or not EnemySelectedDropdown.EnemySelectedFarm.Parent or not EnemySelectedDropdown.EnemySelectedFarm:FindFirstChild("HumanoidRootPart") or not EnemySelectedDropdown.EnemySelectedFarm:FindFirstChild("Humanoid") or EnemySelectedDropdown.EnemySelectedFarm.Humanoid.Health <= 0 then
                                CurrentTarget = nil
                                
                                local SlandInfo = SlandData[EnemySelectedDropdown.SelectedSlandFarm]
                                if SlandInfo and SlandInfo.Location then
                                    local LocationChildren = SlandInfo.Location:GetChildren()
                                    for I = 1, #LocationChildren do
                                        local Enemy = LocationChildren[I]
                                        if Enemy:IsA("Model") and Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                                            local EnemiesArray = EnemySelectedDropdown.Enemies
                                            for J = 1, #EnemiesArray do
                                                if Enemy.Name == EnemiesArray[J] then
                                                    EnemySelectedDropdown.EnemySelectedFarm = Enemy
                                                    break
                                                end
                                            end
                                            if EnemySelectedDropdown.EnemySelectedFarm then break end
                                        end
                                    end
                                end
                            end
                            
                            if EnemySelectedDropdown.EnemySelectedFarm and EnemySelectedDropdown.EnemySelectedFarm:FindFirstChild("HumanoidRootPart") then
                                local EnemyPosition = EnemySelectedDropdown.EnemySelectedFarm.HumanoidRootPart.Position
                                Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(EnemyPosition.X, EnemyPosition.Y + 5, EnemyPosition.Z))
                            end
                        end)
                    else
                        if EnemySelectedDropdown.AttachConnectionEnemy then
                            EnemySelectedDropdown.AttachConnectionEnemy:Disconnect()
                            EnemySelectedDropdown.AttachConnectionEnemy = nil
                        end
                        CurrentTarget = nil
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