if game.PlaceId ~= 104067066727140 then return end

local ReplicatedStorage, Players, LocalPlayer, RunService, TweenService = game:GetService("ReplicatedStorage"), game:GetService("Players"), game:GetService("Players").LocalPlayer, game:GetService("RunService"), game:GetService("TweenService")

repeat RunService.Heartbeat:wait() until LocalPlayer.Character

local Framework, MainModules = ReplicatedStorage:WaitForChild("Framework"), ReplicatedStorage:WaitForChild("MainModules")
local AutoFarmQuestsEnabled, AutoBringMobsEnabled, AutoCollectFruitEnabled, AutoStatusDefenseEnabled, AutoStatusSwordEnabled, AutoStatusGunEnabled, AutoStatusStrengthEnabled, AutoStatusDevilFruitEnabled = false, false, false, false, false, false, false, false
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
end)

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

local FluentLibrary = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local MainWindow = FluentLibrary:CreateWindow({
    Title = "MicaHub",
    SubTitle = "Vox Seas",
    TabWidth = 160,
    Size = UDim2.fromOffset(570, 350),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

MainWindow:Minimize()

local HomeTab, OthersTab, SettingsTab = MainWindow:AddTab({ Title = "Home", Icon = "home" }), MainWindow:AddTab({ Title = "Others", Icon = "package" }), MainWindow:AddTab({ Title = "Settings", Icon = "settings" })

HomeTab:AddSection("Automatic Functions")

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

local AutoFarmQuestsToggle = HomeTab:AddToggle("AutoFarmQuests", {Title = "Auto Farm Quests", Default = false })
AutoFarmQuestsToggle:OnChanged(function(StateFunctionPanel)
    AutoFarmQuestsEnabled = StateFunctionPanel
    if AutoFarmQuestsEnabled then task.spawn(ExecuteAutoFarmQuests) end
end)

local AutoBringMobsToggle = HomeTab:AddToggle("AutoBringMobs", {Title = "Auto Bring Mobs [BETA]", Default = false })
AutoBringMobsToggle:OnChanged(function(StateFunctionPanel)
    AutoBringMobsEnabled = StateFunctionPanel
    if AutoBringMobsEnabled then task.spawn(ExecuteAutoBringMobs) end
end)

local function FireTouchInterestForChests(Character)
    local ChestsPath = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Int") and workspace.IgnoreList.Int:FindFirstChild("Chests")
    if not ChestsPath or not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    for _, ChestPart in pairs(ChestsPath:GetChildren()) do
        if ChestPart:IsA("BasePart") then
            firetouchinterest(Character.HumanoidRootPart, ChestPart, 0)
            firetouchinterest(Character.HumanoidRootPart, ChestPart, 1)
        end
    end
end

local function FireTouchInterestForFruits(Character, ToolObject)
    if not Character or not Character:FindFirstChild("HumanoidRootPart") or not ToolObject:IsA("Tool") or not ToolObject:FindFirstChild("Handle") then return end
    firetouchinterest(Character.HumanoidRootPart, ToolObject.Handle, 0)
    firetouchinterest(Character.HumanoidRootPart, ToolObject.Handle, 1)
end

local TakeChestsButton = HomeTab:AddButton({
    Title = "Take Chests",
    Description = "Collect Chests Immediately",
    Callback = function()
        FireTouchInterestForChests(LocalPlayer.Character)
    end
})

HomeTab:AddSection("Basic Settings")

local SelectToolFarmDropdown = HomeTab:AddDropdown("SelectToolFarm", {
    Title = "Select Tool Farm",
    Values = {"None Tools"},
    Multi = false,
    Default = 1,
})

local function GetCharacterTools()
    if not LocalPlayer.Character then return {} end
    local ToolsList = {}
    
    for _, ContainerObject in pairs({LocalPlayer.Backpack, LocalPlayer.Character}) do
        for _, ToolObject in pairs(ContainerObject:GetChildren()) do
            if ToolObject:IsA("Tool") and not ToolObject.Name:find("Fruit") then
                table.insert(ToolsList, ToolObject.Name)
            end
        end
    end
    return ToolsList
end

local UpdateToolsListButton = HomeTab:AddButton({
    Title = "Update Tools List",
    Description = "Update Tools Shown List",
    Callback = function()
        local ToolsList = GetCharacterTools()
        if #ToolsList > 0 then
            SelectToolFarmDropdown:SetValues(ToolsList)
        end
    end
})

OthersTab:AddSection("Fruits Functionality")

local DroppedToolsFolder = workspace:WaitForChild("Playability"):WaitForChild("DroppedTools")

local function ExecuteAutoCollect()
    if not AutoCollectFruitEnabled then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        RunService.Heartbeat:wait()
        return ExecuteAutoCollect()
    end
    
    for _, ToolObject in pairs(DroppedToolsFolder:GetChildren()) do
        FireTouchInterestForFruits(LocalPlayer.Character, ToolObject)
    end
    
    RunService.Heartbeat:wait()
    return ExecuteAutoCollect()
end

local AutoCollectFruitToggle = OthersTab:AddToggle("AutoCollectFruit", {Title = "Auto Collect Fruit", Default = false })
AutoCollectFruitToggle:OnChanged(function(StateFunctionPanel)
    AutoCollectFruitEnabled = StateFunctionPanel
    if AutoCollectFruitEnabled then task.spawn(ExecuteAutoCollect) end
end)

OthersTab:AddSection("Teleporting World")

local function GetPortalLocations()
    local PortalFolder = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Portal")
    if not PortalFolder then return {} end
    
    local LocationsList = {}
    for _, PortalPart in pairs(PortalFolder:GetChildren()) do
        if PortalPart:IsA("BasePart") then
            table.insert(LocationsList, PortalPart.Name)
        end
    end
    return LocationsList
end

local SelectTeleportLocationDropdown = OthersTab:AddDropdown("SelectTeleportLocation", {
    Title = "Select Teleport Location",
    Values = GetPortalLocations(),
    Multi = false,
    Default = 1,
})

local TeleportToLocationButton = OthersTab:AddButton({
    Title = "Teleport to Location [BETA]",
    Description = "Teleport to Selected Island",
    Callback = function()
        local SelectedLocation = SelectTeleportLocationDropdown.Value
        if not SelectedLocation or not LocalPlayer.Character then return end
        
        local PortalFolder = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Portal")
        if not PortalFolder then return end
        
        local TargetPortal = PortalFolder:FindFirstChild(SelectedLocation)
        if not TargetPortal or not TargetPortal:IsA("BasePart") then return end
        
        LocalPlayer.Character:PivotTo(TargetPortal.CFrame)
    end
})

OthersTab:AddSection("Automatic Status")

local function ExecuteAutoStatusDefense()
    if not AutoStatusDefenseEnabled then return end
    
    pcall(function()
        local StatusArguments = {Defense = 1, Sword = 0, Gun = 0, Strength = 0, DevilFruit = 0}
        local RemoteArguments = {"UpgradeStat", StatusArguments}
        ReplicatedStorage:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer(unpack(RemoteArguments))
    end)
    
    RunService.Heartbeat:wait()
    return ExecuteAutoStatusDefense()
end

local function ExecuteAutoStatusSword()
    if not AutoStatusSwordEnabled then return end
    
    pcall(function()
        local StatusArguments = {Defense = 0, Sword = 1, Gun = 0, Strength = 0, DevilFruit = 0}
        local RemoteArguments = {"UpgradeStat", StatusArguments}
        ReplicatedStorage:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer(unpack(RemoteArguments))
    end)
    
    RunService.Heartbeat:wait()
    return ExecuteAutoStatusSword()
end

local function ExecuteAutoStatusGun()
    if not AutoStatusGunEnabled then return end
    
    pcall(function()
        local StatusArguments = {Defense = 0, Sword = 0, Gun = 1, Strength = 0, DevilFruit = 0}
        local RemoteArguments = {"UpgradeStat", StatusArguments}
        ReplicatedStorage:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer(unpack(RemoteArguments))
    end)
    
    RunService.Heartbeat:wait()
    return ExecuteAutoStatusGun()
end

local function ExecuteAutoStatusStrength()
    if not AutoStatusStrengthEnabled then return end
    
    pcall(function()
        local StatusArguments = {Defense = 0, Sword = 0, Gun = 0, Strength = 1, DevilFruit = 0}
        local RemoteArguments = {"UpgradeStat", StatusArguments}
        ReplicatedStorage:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer(unpack(RemoteArguments))
    end)
    
    RunService.Heartbeat:wait()
    return ExecuteAutoStatusStrength()
end

local function ExecuteAutoStatusDevilFruit()
    if not AutoStatusDevilFruitEnabled then return end
    
    pcall(function()
        local StatusArguments = {Defense = 0, Sword = 0, Gun = 0, Strength = 0, DevilFruit = 1}
        local RemoteArguments = {"UpgradeStat", StatusArguments}
        ReplicatedStorage:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer(unpack(RemoteArguments))
    end)
    
    RunService.Heartbeat:wait()
    return ExecuteAutoStatusDevilFruit()
end

local AutoStatusDefenseToggle = OthersTab:AddToggle("AutoStatusDefense", {Title = "Auto Status Defense", Default = false })
AutoStatusDefenseToggle:OnChanged(function(StateFunctionPanel)
    AutoStatusDefenseEnabled = StateFunctionPanel
    if AutoStatusDefenseEnabled then task.spawn(ExecuteAutoStatusDefense) end
end)

local AutoStatusSwordToggle = OthersTab:AddToggle("AutoStatusSword", {Title = "Auto Status Sword", Default = false })
AutoStatusSwordToggle:OnChanged(function(StateFunctionPanel)
    AutoStatusSwordEnabled = StateFunctionPanel
    if AutoStatusSwordEnabled then task.spawn(ExecuteAutoStatusSword) end
end)

local AutoStatusGunToggle = OthersTab:AddToggle("AutoStatusGun", {Title = "Auto Status Gun", Default = false })
AutoStatusGunToggle:OnChanged(function(StateFunctionPanel)
    AutoStatusGunEnabled = StateFunctionPanel
    if AutoStatusGunEnabled then task.spawn(ExecuteAutoStatusGun) end
end)

local AutoStatusStrengthToggle = OthersTab:AddToggle("AutoStatusStrength", {Title = "Auto Status Strength", Default = false })
AutoStatusStrengthToggle:OnChanged(function(StateFunctionPanel)
    AutoStatusStrengthEnabled = StateFunctionPanel
    if AutoStatusStrengthEnabled then task.spawn(ExecuteAutoStatusStrength) end
end)

local AutoStatusDevilFruitToggle = OthersTab:AddToggle("AutoStatusDevilFruit", {Title = "Auto Status DevilFruit", Default = false })
AutoStatusDevilFruitToggle:OnChanged(function(StateFunctionPanel)
    AutoStatusDevilFruitEnabled = StateFunctionPanel
    if AutoStatusDevilFruitEnabled then task.spawn(ExecuteAutoStatusDevilFruit) end
end)

MainWindow:SelectTab(1)
