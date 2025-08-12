if game.PlaceId ~= 104067066727140 then 
    loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))():Notify({Title = "MicaHub Information", Content = "You're not on Vox Seas, idiot! Run the script on Vox Seas!", Duration = 8})
    return 
end

local ReplicatedStorageService, PlayersService, LocalPlayerReference, RunServiceReference, TweenServiceReference = game:GetService("ReplicatedStorage"), game:GetService("Players"), game:GetService("Players").LocalPlayer, game:GetService("RunService"), game:GetService("TweenService")

repeat RunServiceReference.Heartbeat:wait() until LocalPlayerReference.Character

local GameFrameworkModule, MainModulesContainer = ReplicatedStorageService:WaitForChild("Framework"), ReplicatedStorageService:WaitForChild("MainModules")
local AutomatedQuestFarmingEnabled, AutomatedMobBringingEnabled, AutomatedFruitCollectionEnabled, AutomatedFruitStorageEnabled, AutomatedDefenseStatusUpgradeEnabled, AutomatedSwordStatusUpgradeEnabled, AutomatedGunStatusUpgradeEnabled, AutomatedStrengthStatusUpgradeEnabled, AutomatedDevilFruitStatusUpgradeEnabled, AutomatedFruitPurchasingEnabled = false, false, false, false, false, false, false, false, false, false
local SelectedFruitIdentifierForPurchasing, CurrentCharacterReference = nil, LocalPlayerReference.Character or LocalPlayerReference.CharacterAdded:Wait()

LocalPlayerReference.CharacterAdded:Connect(function(NewlySpawnedCharacter) CurrentCharacterReference = NewlySpawnedCharacter end)

task.spawn(function()
    if getgenv().LoadedMobileUserInterface then return end
    getgenv().LoadedMobileUserInterface = true
    local MobileUIScreenGui, MobileToggleButton, MobileButtonCornerRadius = Instance.new("ScreenGui"), Instance.new("ImageButton"), Instance.new("UICorner")
    MobileUIScreenGui.Name, MobileUIScreenGui.Parent, MobileUIScreenGui.ZIndexBehavior = "MobileUIScreenGui", game:GetService("CoreGui"), Enum.ZIndexBehavior.Sibling
    MobileToggleButton.Parent, MobileToggleButton.BackgroundColor3, MobileToggleButton.BackgroundTransparency, MobileToggleButton.Position, MobileToggleButton.Size, MobileToggleButton.Image, MobileToggleButton.Draggable, MobileToggleButton.Transparency = MobileUIScreenGui, Color3.fromRGB(105,105,105), 0.8, UDim2.new(0.9,0,0.1,0), UDim2.new(0,50,0,50), "rbxassetid://95816097006870", true, 1
    MobileButtonCornerRadius.CornerRadius, MobileButtonCornerRadius.Parent = UDim.new(0,200), MobileToggleButton
    MobileToggleButton.MouseButton1Click:Connect(function() game:GetService("VirtualInputManager"):SendKeyEvent(true,"LeftControl",false,game) end)
end)

local FluentLibraryInterface = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local PrimaryDashboardWindow = FluentLibraryInterface:CreateWindow({Title = "MicaHub", SubTitle = "Vox Seas", TabWidth = 160, Size = UDim2.fromOffset(570, 350), Acrylic = false, Theme = "Dark", MinimizeKey = Enum.KeyCode.LeftControl})
PrimaryDashboardWindow:Minimize()

local HomeTabContainer, AdvancedFeaturesTabContainer, ConfigurationTabContainer = PrimaryDashboardWindow:AddTab({ Title = "Home", Icon = "home" }), PrimaryDashboardWindow:AddTab({ Title = "Others", Icon = "package" }), PrimaryDashboardWindow:AddTab({ Title = "Settings", Icon = "settings" })

HomeTabContainer:AddSection("Author Information")
HomeTabContainer:AddParagraph({Title = "Thank you for using my Dashboard!", Content = "I'm still developing, some functions may be incomplete or bugs!"})
HomeTabContainer:AddParagraph({Title = "GitHub: Mkklzz", Content = ""})
HomeTabContainer:AddSection("Automatic Functions")

local function ExecuteAutomatedQuestFarmingRoutine()
    if not AutomatedQuestFarmingEnabled then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then RunServiceReference.Heartbeat:wait() return ExecuteAutomatedQuestFarmingRoutine() end
    local SelectedToolName = ToolSelectionForFarmingDropdown.Value
    if not SelectedToolName or SelectedToolName == "None Tools" then RunServiceReference.Heartbeat:wait() return ExecuteAutomatedQuestFarmingRoutine() end
    local EquippedTool = LocalPlayerReference.Character:FindFirstChild(SelectedToolName) or LocalPlayerReference.Backpack:FindFirstChild(SelectedToolName)
    if EquippedTool and EquippedTool:IsA("Tool") and EquippedTool.Parent == LocalPlayerReference.Backpack then LocalPlayerReference.Character.Humanoid:EquipTool(EquippedTool) end
    RunServiceReference.Heartbeat:wait() return ExecuteAutomatedQuestFarmingRoutine()
end

local function ValidatePlayerCurrentFruitPossession(TargetFruitIdentifier)
    local PlayerPreviousFruitAttribute = LocalPlayerReference:GetAttribute("PreviousFruit")
    if not PlayerPreviousFruitAttribute then return false end
    local FruitIdentifierMappingTable = {["Celestial"] = "Celestial", ["Poison"] = "Venom", ["Orbit"] = "Gravity", ["Mirror"] = "Mirror", ["Zen"] = "Buddha", ["Vulcanic"] = "Magu", ["Eclipse"] = "Dark", ["Frozen"] = "Ice", ["Shine"] = "Light"}
    local MappedFruitIdentifier = FruitIdentifierMappingTable[TargetFruitIdentifier]
    return MappedFruitIdentifier and (PlayerPreviousFruitAttribute == MappedFruitIdentifier or PlayerPreviousFruitAttribute == "Portal")
end

local function ExecuteAutomatedFruitPurchasingRoutine()
    if not AutomatedFruitPurchasingEnabled or not SelectedFruitIdentifierForPurchasing then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then RunServiceReference.Heartbeat:wait() return ExecuteAutomatedFruitPurchasingRoutine() end
    local FruitIdentifierToNameMappingTable = {[15] = "Celestial", [14] = "Poison", [13] = "Orbit", [12] = "Mirror", [11] = "Zen", [10] = "Vulcanic", [9] = "Eclipse", [8] = "Frozen", [7] = "Shine"}
    local CurrentSelectedFruitName = FruitIdentifierToNameMappingTable[SelectedFruitIdentifierForPurchasing]
    if CurrentSelectedFruitName and ValidatePlayerCurrentFruitPossession(CurrentSelectedFruitName) then RunServiceReference.Heartbeat:wait() return ExecuteAutomatedFruitPurchasingRoutine() end
    pcall(function() ReplicatedStorageService:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("FruitShopEvent"):FireServer("Buy", SelectedFruitIdentifierForPurchasing) end)
    RunServiceReference.Heartbeat:wait() return ExecuteAutomatedFruitPurchasingRoutine()
end

local AutomatedQuestFarmingToggleControl = HomeTabContainer:AddToggle("AutomatedQuestFarming", {Title = "Auto Farm Quests", Default = false })
AutomatedQuestFarmingToggleControl:OnChanged(function(ToggleActivationState) AutomatedQuestFarmingEnabled = ToggleActivationState if AutomatedQuestFarmingEnabled then task.spawn(ExecuteAutomatedQuestFarmingRoutine) end end)

local AutomatedMobBringingToggleControl = HomeTabContainer:AddToggle("AutomatedMobBringing", {Title = "Auto Bring Mobs [BETA]", Default = false })
AutomatedMobBringingToggleControl:OnChanged(function(ToggleActivationState) AutomatedMobBringingEnabled = ToggleActivationState end)

local function ExecuteTouchInterestForGameChests(PlayerCharacterReference)
    local ChestContainerPath = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Int") and workspace.IgnoreList.Int:FindFirstChild("Chests")
    if not ChestContainerPath or not PlayerCharacterReference or not PlayerCharacterReference:FindFirstChild("HumanoidRootPart") then return end
    for _, IndividualChestPart in pairs(ChestContainerPath:GetChildren()) do
        if IndividualChestPart:IsA("BasePart") then firetouchinterest(PlayerCharacterReference.HumanoidRootPart, IndividualChestPart, 0) firetouchinterest(PlayerCharacterReference.HumanoidRootPart, IndividualChestPart, 1) end
    end
end

local function ExecuteTouchInterestForDroppedFruits(PlayerCharacterReference, DroppedToolObject)
    if not PlayerCharacterReference or not PlayerCharacterReference:FindFirstChild("HumanoidRootPart") or not DroppedToolObject:IsA("Tool") or not DroppedToolObject:FindFirstChild("Handle") then return end
    firetouchinterest(PlayerCharacterReference.HumanoidRootPart, DroppedToolObject.Handle, 0) firetouchinterest(PlayerCharacterReference.HumanoidRootPart, DroppedToolObject.Handle, 1)
end

HomeTabContainer:AddButton({Title = "Take All Chests", Description = "Collect Chests Immediately", Callback = function() ExecuteTouchInterestForGameChests(LocalPlayerReference.Character) end})

HomeTabContainer:AddButton({Title = "Redeem All Codes", Description = "Redeem all available codes in the game!", Callback = function()
    for _, IndividualCodeIdentifier in pairs({"BugFix1", "BugFix2", "BugFix3", "Release"}) do
        pcall(function() ReplicatedStorageService:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("CodesEvent"):FireServer("Redeem", IndividualCodeIdentifier) end)
    end
end})

HomeTabContainer:AddSection("Basic Settings")

local function RetrieveAvailableCharacterTools()
    if not LocalPlayerReference.Character then return {} end
    local AvailableToolsList = {}
    for _, ToolContainerObject in pairs({LocalPlayerReference.Backpack, LocalPlayerReference.Character}) do
        for _, IndividualToolObject in pairs(ToolContainerObject:GetChildren()) do
            if IndividualToolObject:IsA("Tool") and not IndividualToolObject.Name:find("Fruit") then table.insert(AvailableToolsList, IndividualToolObject.Name) end
        end
    end
    return AvailableToolsList
end

local ToolSelectionForFarmingDropdown = HomeTabContainer:AddDropdown("ToolSelectionForFarming", {Title = "Select Tool Farm", Values = RetrieveAvailableCharacterTools(), Multi = false, Default = 1})

HomeTabContainer:AddButton({Title = "Update Tools List", Description = "Update Tools Shown List", Callback = function()
    local CurrentAvailableToolsList = RetrieveAvailableCharacterTools()
    if #CurrentAvailableToolsList > 0 then ToolSelectionForFarmingDropdown:SetValues(CurrentAvailableToolsList) end
end})

AdvancedFeaturesTabContainer:AddSection("Fruits Functionality")

local AutomatedFruitPurchasingDropdown = AdvancedFeaturesTabContainer:AddDropdown("AutomatedFruitPurchasing", {Title = "Buy Fruit Automatically", Values = {"Celestial", "Poison", "Orbit", "Mirror", "Zen", "Vulcanic", "Eclipse", "Frozen", "Shine"}, Multi = false, Default = nil})

AutomatedFruitPurchasingDropdown:OnChanged(function(SelectedFruitOption)
    if not SelectedFruitOption then SelectedFruitIdentifierForPurchasing = nil return end
    local FruitSelectionToIdentifierMappingTable = {["Celestial"] = 15, ["Poison"] = 14, ["Orbit"] = 13, ["Mirror"] = 12, ["Zen"] = 11, ["Vulcanic"] = 10, ["Eclipse"] = 9, ["Frozen"] = 8, ["Shine"] = 7}
    local MappedFruitIdentifier = FruitSelectionToIdentifierMappingTable[SelectedFruitOption]
    if MappedFruitIdentifier then SelectedFruitIdentifierForPurchasing = MappedFruitIdentifier if AutomatedFruitPurchasingEnabled then task.spawn(ExecuteAutomatedFruitPurchasingRoutine) end end
end)

local AutomatedFruitPurchasingToggleControl = AdvancedFeaturesTabContainer:AddToggle("AutomatedFruitPurchasing", {Title = "Buy Selected Fruit", Default = false })
AutomatedFruitPurchasingToggleControl:OnChanged(function(ToggleActivationState) AutomatedFruitPurchasingEnabled = ToggleActivationState if AutomatedFruitPurchasingEnabled and SelectedFruitIdentifierForPurchasing then task.spawn(ExecuteAutomatedFruitPurchasingRoutine) end end)

local DroppedToolsWorkspaceContainer = workspace:WaitForChild("Playability"):WaitForChild("DroppedTools")

local function ExecuteAutomatedFruitCollectionRoutine()
    if not AutomatedFruitCollectionEnabled then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then RunServiceReference.Heartbeat:wait() return ExecuteAutomatedFruitCollectionRoutine() end
    for _, IndividualDroppedToolObject in pairs(DroppedToolsWorkspaceContainer:GetChildren()) do ExecuteTouchInterestForDroppedFruits(LocalPlayerReference.Character, IndividualDroppedToolObject) end
    RunServiceReference.Heartbeat:wait() return ExecuteAutomatedFruitCollectionRoutine()
end

local AutomatedFruitCollectionToggleControl = AdvancedFeaturesTabContainer:AddToggle("AutomatedFruitCollection", {Title = "Auto Collect Fruits", Default = false })
AutomatedFruitCollectionToggleControl:OnChanged(function(ToggleActivationState) AutomatedFruitCollectionEnabled = ToggleActivationState if AutomatedFruitCollectionEnabled then task.spawn(ExecuteAutomatedFruitCollectionRoutine) end end)

local function ExecuteAutomatedFruitStorageRoutine()
    if not AutomatedFruitStorageEnabled then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then RunServiceReference.Heartbeat:wait() return ExecuteAutomatedFruitStorageRoutine() end
    for _, IndividualFruitName in pairs({"Celestial Fruit", "Poison Fruit", "Orbit Fruit", "Mirror Fruit", "Zen Fruit", "Vulcanic Fruit", "Eclipse Fruit", "Frozen Fruit", "Shine Fruit", "Blaze Fruit", "Dust Fruit", "Boom Fruit", "Elastic Fruit", "Divide Fruit", "Kilo Fruit", "Bomb Fruit", "Blade Fruit", "Buddha Fruit", "Dark Fruit", "Gravity Fruit", "Ice Fruit", "Light Fruit", "Magu Fruit", "Mera Fruit", "Portal Fruit", "Rubber Fruit", "Sand Fruit", "Venom Fruit"}) do
        local LocatedFruitTool = LocalPlayerReference.Backpack:FindFirstChild(IndividualFruitName) or LocalPlayerReference.Character:FindFirstChild(IndividualFruitName)
        if LocatedFruitTool and LocatedFruitTool:IsA("Tool") and LocalPlayerReference.Character.Humanoid then
            LocalPlayerReference.Character.Humanoid:EquipTool(LocatedFruitTool)
            pcall(function() ReplicatedStorageService:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("ToolsEvent"):FireServer("StoreFruit") end)
        end
    end
    RunServiceReference.Heartbeat:wait() return ExecuteAutomatedFruitStorageRoutine()
end

local AutomatedFruitStorageToggleControl = AdvancedFeaturesTabContainer:AddToggle("AutomatedFruitStorage", {Title = "Auto Store Fruits", Default = false })
AutomatedFruitStorageToggleControl:OnChanged(function(ToggleActivationState) AutomatedFruitStorageEnabled = ToggleActivationState if AutomatedFruitStorageEnabled then task.spawn(ExecuteAutomatedFruitStorageRoutine) end end)

AdvancedFeaturesTabContainer:AddSection("Teleporting World")

local function RetrieveAvailablePortalLocations()
    local PortalContainerFolder = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Portal")
    if not PortalContainerFolder then return {} end
    local AvailableLocationsList = {}
    for _, IndividualPortalPart in pairs(PortalContainerFolder:GetChildren()) do
        if IndividualPortalPart:IsA("BasePart") then table.insert(AvailableLocationsList, IndividualPortalPart.Name) end
    end
    return AvailableLocationsList
end

local TeleportationDestinationSelectionDropdown = AdvancedFeaturesTabContainer:AddDropdown("TeleportationDestinationSelection", {Title = "Select Teleport Location", Values = RetrieveAvailablePortalLocations(), Multi = false, Default = 1})

AdvancedFeaturesTabContainer:AddButton({Title = "Teleport to Location [BETA]", Description = "Teleport to Selected Island", Callback = function()
    local SelectedTeleportationDestination = TeleportationDestinationSelectionDropdown.Value
    if not SelectedTeleportationDestination or not LocalPlayerReference.Character then return end
    local PortalContainerFolder = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Portal")
    if not PortalContainerFolder then return end
    local TargetPortalDestination = PortalContainerFolder:FindFirstChild(SelectedTeleportationDestination)
    if not TargetPortalDestination or not TargetPortalDestination:IsA("BasePart") then return end
    LocalPlayerReference.Character:PivotTo(TargetPortalDestination.CFrame)
end})

AdvancedFeaturesTabContainer:AddSection("Automatic Status")

local function CreateAutomatedStatusUpgradeRoutine(StatusType, StatusTable)
    return function()
        if not StatusType then return end
        pcall(function() ReplicatedStorageService:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer("UpgradeStat", StatusTable) end)
        RunServiceReference.Heartbeat:wait() return CreateAutomatedStatusUpgradeRoutine(StatusType, StatusTable)()
    end
end

local StatusUpgradeRoutines = {
    Defense = CreateAutomatedStatusUpgradeRoutine(function() return AutomatedDefenseStatusUpgradeEnabled end, {Defense = 1, Sword = 0, Gun = 0, Strength = 0, DevilFruit = 0}),
    Sword = CreateAutomatedStatusUpgradeRoutine(function() return AutomatedSwordStatusUpgradeEnabled end, {Defense = 0, Sword = 1, Gun = 0, Strength = 0, DevilFruit = 0}),
    Gun = CreateAutomatedStatusUpgradeRoutine(function() return AutomatedGunStatusUpgradeEnabled end, {Defense = 0, Sword = 0, Gun = 1, Strength = 0, DevilFruit = 0}),
    Strength = CreateAutomatedStatusUpgradeRoutine(function() return AutomatedStrengthStatusUpgradeEnabled end, {Defense = 0, Sword = 0, Gun = 0, Strength = 1, DevilFruit = 0}),
    DevilFruit = CreateAutomatedStatusUpgradeRoutine(function() return AutomatedDevilFruitStatusUpgradeEnabled end, {Defense = 0, Sword = 0, Gun = 0, Strength = 0, DevilFruit = 1})
}

local function CreateStatusToggle(StatusName, VariableName, RoutineFunction)
    local Toggle = AdvancedFeaturesTabContainer:AddToggle("Automated" .. StatusName .. "StatusUpgrade", {Title = "Auto Status " .. StatusName, Default = false})
    Toggle:OnChanged(function(ToggleActivationState) 
        _G[VariableName] = ToggleActivationState 
        if ToggleActivationState then task.spawn(RoutineFunction) end 
    end)
end

CreateStatusToggle("Defense", "AutomatedDefenseStatusUpgradeEnabled", StatusUpgradeRoutines.Defense)
CreateStatusToggle("Sword", "AutomatedSwordStatusUpgradeEnabled", StatusUpgradeRoutines.Sword)
CreateStatusToggle("Gun", "AutomatedGunStatusUpgradeEnabled", StatusUpgradeRoutines.Gun)
CreateStatusToggle("Strength", "AutomatedStrengthStatusUpgradeEnabled", StatusUpgradeRoutines.Strength)
CreateStatusToggle("DevilFruit", "AutomatedDevilFruitStatusUpgradeEnabled", StatusUpgradeRoutines.DevilFruit)

ConfigurationTabContainer:AddSection("Https Servers Connections")
ConfigurationTabContainer:AddParagraph({Title = "How does it work?", Content = "Join servers with specific items using the code available on our Discord."})

local ServerConnectionCodeInputField = ConfigurationTabContainer:AddInput("ServerConnectionCode", {Title = "Target Server Code", Default = "", Placeholder = "", Numeric = false, Finished = false})

ConfigurationTabContainer:AddButton({Title = "Join the Server", Description = "Use this button to connect to the server", Callback = function()
    PrimaryDashboardWindow:Dialog({Title = "Https Servers Connections", Content = "Are you sure you want to connect?", Buttons = {
        {Title = "Confirm", Callback = function()
            local ProvidedServerCode = ServerConnectionCodeInputField.Value
            if ProvidedServerCode and ProvidedServerCode ~= "" then pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, ProvidedServerCode, LocalPlayerReference) end) end
        end},
        {Title = "Cancel", Callback = function() end}
    }})
end})

PrimaryDashboardWindow:SelectTab(1)
