local ReplicatedStorage, Players, LocalPlayer, RunService = game:GetService("ReplicatedStorage"), game:GetService("Players"), game:GetService("Players").LocalPlayer, game:GetService("RunService")

repeat RunService.Heartbeat:wait() until LocalPlayer.Character

local Framework, MainModules = ReplicatedStorage:WaitForChild("Framework"), ReplicatedStorage:WaitForChild("MainModules")
local AutoFarmQuestsEnabled, AutoBringMobsEnabled, AutoCollectFruitEnabled, AutoStatusEnabled = false, false, false, false
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local function SetCharacterAttribute(char)
    char:SetAttribute("IgnoreAntiTeleport", true)
end

SetCharacterAttribute(Character)
LocalPlayer.CharacterAdded:Connect(SetCharacterAttribute)

task.spawn(function()
    if getgenv().LoadedMobileUI then return end
    getgenv().LoadedMobileUI = true
    local OpenUI = Instance.new("ScreenGui")
    local ImageButton = Instance.new("ImageButton")
    local UICorner = Instance.new("UICorner")
    OpenUI.Name, OpenUI.Parent, OpenUI.ZIndexBehavior = "OpenUI", game:GetService("CoreGui"), Enum.ZIndexBehavior.Sibling
    ImageButton.Parent, ImageButton.BackgroundColor3, ImageButton.BackgroundTransparency = OpenUI, Color3.fromRGB(105,105,105), 0.8
    ImageButton.Position, ImageButton.Size, ImageButton.Image = UDim2.new(0.9,0,0.1,0), UDim2.new(0,50,0,50), "rbxassetid://95816097006870"
    ImageButton.Draggable, ImageButton.Transparency = true, 1
    UICorner.CornerRadius, UICorner.Parent = UDim.new(0,200), ImageButton
    ImageButton.MouseButton1Click:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true,"LeftControl",false,game)
    end)
end)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "MicaHub",
    SubTitle = "Vox Seas",
    TabWidth = 160,
    Size = UDim2.fromOffset(570, 350),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

Window:Minimize()

local Home, Others, Settings = Window:AddTab({ Title = "Home", Icon = "home" }), Window:AddTab({ Title = "Others", Icon = "package" }), Window:AddTab({ Title = "Settings", Icon = "settings" })

Home:AddSection("Automatic Functions")

local function ExecuteAutoFarmQuests()
    if not AutoFarmQuestsEnabled then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        RunService.Heartbeat:wait()
        return ExecuteAutoFarmQuests()
    end
    
    RunService.Heartbeat:wait()
    return ExecuteAutoFarmQuests()
end

local function ExecuteAutoBringMobs()
    if not AutoBringMobsEnabled then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        RunService.Heartbeat:wait()
        return ExecuteAutoBringMobs()
    end
    
    RunService.Heartbeat:wait()
    return ExecuteAutoBringMobs()
end

local AutoFarmQuests = Home:AddToggle("AutoFarmQuests", {Title = "Auto Farm Quests", Default = false })
AutoFarmQuests:OnChanged(function(StateFunctionPanel)
    AutoFarmQuestsEnabled = StateFunctionPanel
    if AutoFarmQuestsEnabled then task.spawn(ExecuteAutoFarmQuests) end
end)

local AutoBringMobs = Home:AddToggle("AutoBringMobs", {Title = "Auto Bring Mobs [BETA]", Default = false })
AutoBringMobs:OnChanged(function(StateFunctionPanel)
    AutoBringMobsEnabled = StateFunctionPanel
    if AutoBringMobsEnabled then task.spawn(ExecuteAutoBringMobs) end
end)

local function FireTouchInterestForChests(character)
    local ChestsPath = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Int") and workspace.IgnoreList.Int:FindFirstChild("Chests")
    if not ChestsPath or not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    for _, ChestPart in pairs(ChestsPath:GetChildren()) do
        if ChestPart:IsA("BasePart") then
            firetouchinterest(character.HumanoidRootPart, ChestPart, 0)
            firetouchinterest(character.HumanoidRootPart, ChestPart, 1)
        end
    end
end

local function FireTouchInterestForFruits(character, tool)
    if not character or not character:FindFirstChild("HumanoidRootPart") or not tool:IsA("Tool") or not tool:FindFirstChild("Handle") then return end
    firetouchinterest(character.HumanoidRootPart, tool.Handle, 0)
    firetouchinterest(character.HumanoidRootPart, tool.Handle, 1)
end

local TakeChests = Home:AddButton({
    Title = "Take Chests",
    Description = "Collect Chests Immediately",
    Callback = function()
        FireTouchInterestForChests(LocalPlayer.Character)
    end
})

Home:AddSection("Basic Settings")

local SelectToolFarm = Home:AddDropdown("SelectToolFarm", {
    Title = "Select Tool Farm",
    Values = {"None Tools"},
    Multi = false,
    Default = 1,
})

local function GetCharacterTools()
    if not LocalPlayer.Character then return {} end
    local ToolsList = {}
    
    for _, container in pairs({LocalPlayer.Backpack, LocalPlayer.Character}) do
        for _, Tool in pairs(container:GetChildren()) do
            if Tool:IsA("Tool") and not Tool.Name:find("Fruit") then
                table.insert(ToolsList, Tool.Name)
            end
        end
    end
    return ToolsList
end

local UpdateToolsList = Home:AddButton({
    Title = "Update Tools List",
    Description = "Update Tools Shown List",
    Callback = function()
        local ToolsList = GetCharacterTools()
        if #ToolsList > 0 then
            SelectToolFarm:SetValues(ToolsList)
        end
    end
})

Others:AddSection("Fruits Functionality")

local DroppedToolsFolder = workspace:WaitForChild("Playability"):WaitForChild("DroppedTools")

local function ExecuteAutoCollect()
    if not AutoCollectFruitEnabled then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        RunService.Heartbeat:wait()
        return ExecuteAutoCollect()
    end
    
    for _, Tool in pairs(DroppedToolsFolder:GetChildren()) do
        FireTouchInterestForFruits(LocalPlayer.Character, Tool)
    end
    
    RunService.Heartbeat:wait()
    return ExecuteAutoCollect()
end

local AutoCollectFruit = Others:AddToggle("AutoCollectFruit", {Title = "Auto Collect Fruit", Default = false })
AutoCollectFruit:OnChanged(function(StateFunctionPanel)
    AutoCollectFruitEnabled = StateFunctionPanel
    if AutoCollectFruitEnabled then task.spawn(ExecuteAutoCollect) end
end)

Others:AddSection("Automatic Status")

local SelectStatus = Others:AddDropdown("SelectStatus", {
    Title = "Select Status",
    Values = {"None Status", "Defense", "Sword", "Gun", "Strength", "DevilFruit"},
    Multi = false,
    Default = 1,
})

SelectStatus:OnChanged(function(Value)
    if Value ~= "None Status" then
        SelectStatus:SetValues({"Defense", "Sword", "Gun", "Strength", "DevilFruit"})
    end
end)

local function ExecuteAutoStatus()
    if not AutoStatusEnabled then return end
    
    local SelectedStatus = SelectStatus.Value
    if SelectedStatus == "None Status" then 
        RunService.Heartbeat:wait()
        return ExecuteAutoStatus()
    end
    
    pcall(function()
        local Args = {"UpgradeStat", {
            Defense = SelectedStatus == "Defense" and 3 or 0,
            Sword = SelectedStatus == "Sword" and 3 or 0,
            Gun = SelectedStatus == "Gun" and 3 or 0,
            Strength = SelectedStatus == "Strength" and 3 or 0,
            DevilFruit = SelectedStatus == "DevilFruit" and 3 or 0
        }}
        ReplicatedStorage:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer(unpack(Args))
    end)
    
    RunService.Heartbeat:wait()
    return ExecuteAutoStatus()
end

local AutoStatusSelected = Others:AddToggle("AutoStatusSelected", {Title = "Auto Status Selected", Default = false })
AutoStatusSelected:OnChanged(function(StateFunctionPanel)
    AutoStatusEnabled = StateFunctionPanel
    if AutoStatusEnabled then task.spawn(ExecuteAutoStatus) end
end)

Window:SelectTab(1)
