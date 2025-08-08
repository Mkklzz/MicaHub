local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/ToraLibrarySource.lua", true))()
local Window = Library:CreateWindow("Vox Seas")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local TakeFruitsEnabled, AutoQuestEnabled, PanelFarmEnabled = false, false, false

local QuestSystem = {
    SelectedToolFarm = "Combat",
    SelectedQuestFarm = "Bandits Hunter",
    EnemyFarmSpeed = 3,
    EnemySelectedFarm = nil,
    FarmConnectionQuest = nil
}

local GameData = {
    EnemyFolder = workspace.Playability.Enemys["Foosha Village"],
    CombatEvent = ReplicatedStorage.BetweenSides.Remotes.Events.CombatEvent,
    DialogueEvent = ReplicatedStorage.BetweenSides.Remotes.Events.DialogueEvent,
    QuestData = {
        ["Bandits Hunter"] = {
            NpcName = "Bandits Hunter",
            QuestName = "Defeat Bandits",
            EnemyPattern = "Bandit"
        }
    }
}

local DisconnectAllConnections = function()
    if QuestSystem.FarmConnectionQuest then
        QuestSystem.FarmConnectionQuest:Disconnect()
        QuestSystem.FarmConnectionQuest = nil
    end
end

local EquipTool = function(ToolName)
    local Character = Player.Character
    if not Character then return end
    
    local Tool = Player.Backpack:FindFirstChild(ToolName)
    if Tool then
        Character.Humanoid:EquipTool(Tool)
    end
end

local FindValidEnemy = function()
    local QuestInfo = GameData.QuestData[QuestSystem.SelectedQuestFarm]
    if not QuestInfo then return nil end
    
    local Enemies = GameData.EnemyFolder:GetChildren()
    for I = 1, #Enemies do
        local Enemy = Enemies[I]
        if Enemy:IsA("Model") and Enemy.Name:find(QuestInfo.EnemyPattern) and Enemy:FindFirstChild("Humanoid") and Enemy:FindFirstChild("HumanoidRootPart") then
            if Enemy.Humanoid.Health > 0 then
                return Enemy
            end
        end
    end
    return nil
end

local AttackEnemy = function(Enemy)
    local Character = Player.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
    
    GameData.CombatEvent:FireServer("DealDamage", {
        CallTime = tick(),
        Results = {Enemy},
        Combo = QuestSystem.EnemyFarmSpeed,
        DelayTime = 0.01
    })
end

local StartQuestSystem = function()
    local QuestInfo = GameData.QuestData[QuestSystem.SelectedQuestFarm]
    if not QuestInfo then return end
    
    GameData.DialogueEvent:FireServer("Quests", {
        NpcName = QuestInfo.NpcName,
        QuestName = QuestInfo.QuestName
    })
    
    EquipTool(QuestSystem.SelectedToolFarm)
    
    QuestSystem.FarmConnectionQuest = RunService.Heartbeat:Connect(function()
        if not AutoQuestEnabled then return end
        
        local Character = Player.Character
        if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
        
        if Character.Humanoid.Health <= 0 then
            EquipTool(QuestSystem.SelectedToolFarm)
            return
        end
        
        local Tool = Player.Backpack:FindFirstChild(QuestSystem.SelectedToolFarm)
        if Tool then
            EquipTool(QuestSystem.SelectedToolFarm)
        end
        
        if not QuestSystem.EnemySelectedFarm or not QuestSystem.EnemySelectedFarm.Parent or not QuestSystem.EnemySelectedFarm:FindFirstChild("Humanoid") or QuestSystem.EnemySelectedFarm.Humanoid.Health <= 0 then
            QuestSystem.EnemySelectedFarm = FindValidEnemy()
        end
        
        if QuestSystem.EnemySelectedFarm then
            AttackEnemy(QuestSystem.EnemySelectedFarm)
        end
    end)
end

Window:AddToggle({
    text = "Take Fruits",
    flag = "ToggleTakeFruits",
    callback = function(ToggleState)
        TakeFruitsEnabled = ToggleState
    end
})

Window:AddButton({
    text = "Farm Panel",
    flag = "ButtonFarmPanel",
    callback = function()
        if PanelFarmEnabled then return end
        PanelFarmEnabled = true
        
        local LibraryFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/ToraLibrarySource.lua", true))()
        local WindowFarm = LibraryFarm:CreateWindow("Vox Farms")
        
        WindowFarm:AddList({
            text = "Select Tools",
            values = {"Combat", "Sword", "Gun"},
            flag = "DropdownSelectTools",
            callback = function(SelectedValue)
                QuestSystem.SelectedToolFarm = SelectedValue
            end,
            open = false
        })
        
        WindowFarm:AddList({
            text = "Select Quest",
            values = {"Bandits Hunter"},
            flag = "DropdownSelectQuest",
            callback = function(SelectedValue)
                QuestSystem.SelectedQuestFarm = SelectedValue
            end,
            open = false
        })
        
        WindowFarm:AddBox({
            text = "Farm Quest Speed",
            flag = "BoxFarmSpeed",
            value = "5",
            callback = function(BoxValue)
                local SpeedValue = tonumber(BoxValue)
                if SpeedValue and SpeedValue >= 1 and SpeedValue <= 10 then
                    QuestSystem.EnemyFarmSpeed = SpeedValue
                end
            end
        })
        
        WindowFarm:AddToggle({
            text = "Auto Quest [BETA]",
            flag = "ToggleAutoQuest",
            callback = function(ToggleState)
                AutoQuestEnabled = ToggleState
                
                if AutoQuestEnabled then
                    StartQuestSystem()
                else
                    DisconnectAllConnections()
                    QuestSystem.EnemySelectedFarm = nil
                end
            end
        })
        
        WindowFarm:AddButton({
            text = "Close",
            flag = "ButtonClose",
            callback = function()
                if not AutoQuestEnabled then
                    LibraryFarm:Close()
                    PanelFarmEnabled = false
                end
            end
        })
        
        LibraryFarm:Init()
    end
})

Window:AddLabel({
    text = "GitHub: Mkklz-h",
    type = "label"
})

Library:Init()