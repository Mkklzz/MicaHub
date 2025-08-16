if game.PlaceId ~= 104067066727140 then 
    loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))():Notify({Title = "MicaHub Information", Content = "You're not on Vox Seas, idiot! Run the script on Vox Seas!", Duration = 8})
    return 
end

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer.Character
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui

local ReplicatedStorageServiceReference, PlayersServiceReference, LocalPlayerReference, RunServiceReference, TweenServiceReference = game:GetService("ReplicatedStorage"), game:GetService("Players"), game:GetService("Players").LocalPlayer, game:GetService("RunService"), game:GetService("TweenService")
repeat RunServiceReference.Heartbeat:Wait() until LocalPlayerReference.Character

local GameFrameworkModuleContainer, MainModulesContainer = ReplicatedStorageServiceReference:WaitForChild("Framework"), ReplicatedStorageServiceReference:WaitForChild("MainModules")
local AutomatedQuestFarmingActivationState, AutomatedEnemyFarmingActivationState, AutomatedBossFarmingActivationState, AutomatedMaterialFarmingActivationState, AutomatedFruitCollectionActivationState, AutomatedFruitStorageActivationState, CooldownRemovalExecutedState, IncludeBossFarmActivationState, CodesRedeemedExecutedState, CurrentMinimizeKeyCode, WalkingWaterActivationState, StatusPointsAmount = false, false, false, false, false, false, false, false, false, "LeftControl", false, 3
local AutomatedStatusUpgradeStates = {Defense = false, Sword = false, Gun = false, Strength = false, DevilFruit = false}
local CurrentCharacterInstanceReference = LocalPlayerReference.Character or LocalPlayerReference.CharacterAdded:Wait()
local AvailableToolsListContainer = {"BlackLeg", "Combat", "Eletric", "WaterKungFu"}

LocalPlayerReference.CharacterAdded:Connect(function(NewlySpawnedCharacterInstance) CurrentCharacterInstanceReference = NewlySpawnedCharacterInstance end)

local QuestSystemModuleContainer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/LoadsEssentials/VoxSeasQuests.lua"))()
getgenv().MicaHubQuestSystemContainer = QuestSystemModuleContainer

local BetweenSidesRemoteConnectionFolderContainer = ReplicatedStorageServiceReference:WaitForChild("BetweenSides")
local RemoteEventsCommunicationFolderContainer = BetweenSidesRemoteConnectionFolderContainer:WaitForChild("Remotes")
local GameEventHandlersContainerReference = RemoteEventsCommunicationFolderContainer:WaitForChild("Events")
local DialogueSystemRemoteEventHandlerReference = GameEventHandlersContainerReference:WaitForChild("DialogueEvent")
local QuestManagementRemoteEventHandlerReference = GameEventHandlersContainerReference:WaitForChild("QuestEvent")
local PlayerLevelDisplayElementReference = LocalPlayerReference.PlayerGui.MainUI.MainFrame.StastisticsFrame.BaseFrame.Level

task.spawn(function()
    if getgenv().LoadedMobileUserInterfaceContainer then return end
    getgenv().LoadedMobileUserInterfaceContainer = true
    local MobileUIScreenGuiContainer, MobileToggleButtonElement, MobileButtonCornerRadiusElement = Instance.new("ScreenGui"), Instance.new("ImageButton"), Instance.new("UICorner")
    MobileUIScreenGuiContainer.Name, MobileUIScreenGuiContainer.Parent, MobileUIScreenGuiContainer.ZIndexBehavior = "MobileUIScreenGui", game:GetService("CoreGui"), Enum.ZIndexBehavior.Sibling
    MobileToggleButtonElement.Parent, MobileToggleButtonElement.BackgroundColor3, MobileToggleButtonElement.BackgroundTransparency, MobileToggleButtonElement.Position, MobileToggleButtonElement.Size, MobileToggleButtonElement.Image, MobileToggleButtonElement.Draggable, MobileToggleButtonElement.Transparency = MobileUIScreenGuiContainer, Color3.fromRGB(105,105,105), 0.8, UDim2.new(0.9,0,0.1,0), UDim2.new(0,50,0,50), "rbxassetid://15330857581", true, 1
    MobileButtonCornerRadiusElement.CornerRadius, MobileButtonCornerRadiusElement.Parent = UDim.new(0,200), MobileToggleButtonElement
    MobileToggleButtonElement.MouseButton1Click:Connect(function() 
        local KeyCodeEnum = Enum.KeyCode[CurrentMinimizeKeyCode] or Enum.KeyCode.LeftControl
        game:GetService("VirtualInputManager"):SendKeyEvent(true, KeyCodeEnum, false, game) 
    end)
end)

local FluentLibraryInterfaceContainer = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local PrimaryDashboardWindowInstance = FluentLibraryInterfaceContainer:CreateWindow({Title = "MicaHub", SubTitle = "Vox Seas", TabWidth = 160, Size = UDim2.fromOffset(550, 330), Acrylic = false, Theme = "Dark", MinimizeKey = Enum.KeyCode.LeftControl})
PrimaryDashboardWindowInstance:Minimize()

local InformationTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Information", Icon = "info" })
local FarmingTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Farming", Icon = "swords" })
local StatusTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Status", Icon = "bar-chart" })
local ShopTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Shop", Icon = "shopping-cart" })
local FruitsTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Fruits", Icon = "apple" })
local TeleportTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Teleport", Icon = "map-pin" })
local MiscTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Misc", Icon = "folder" })
local SettingsTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Settings", Icon = "settings" })

InformationTabContainerReference:AddSection("Author Information")
InformationTabContainerReference:AddParagraph({Title = "Thank you for using my Dashboard!", Content = "I'm still developing, some functions may be incomplete or bugs!"})
InformationTabContainerReference:AddParagraph({Title = "GitHub: Mkklzz", Content = ""})
InformationTabContainerReference:AddButton({Title = "Join Discord Server", Description = "Join the author's discord. To receive information or updates", Callback = function()
    PrimaryDashboardWindowInstance:Dialog({Title = "Discord link copied", Content = "The Discord link has been copied to your clipboard. You can now paste it in your browser to join the server.", Buttons = {
        {Title = "Ok", Callback = function() end}
    }})
    setclipboard("https://discord.gg/yfsKgGYU4e")
end})

local function ProcessSingleFruit()
    local SelectedFruitReference = nil
    for _, ToolContainerObjectReference in pairs({LocalPlayerReference.Backpack, LocalPlayerReference.Character}) do
        for _, IndividualToolObjectInstance in pairs(ToolContainerObjectReference:GetChildren()) do
            if IndividualToolObjectInstance:IsA("Tool") and IndividualToolObjectInstance.Name:find("Fruit") then
                SelectedFruitReference = IndividualToolObjectInstance
                break
            end
        end
        if SelectedFruitReference then break end
    end
    if not SelectedFruitReference then return false end
    if SelectedFruitReference.Parent == LocalPlayerReference.Backpack then
        LocalPlayerReference.Character.Humanoid:EquipTool(SelectedFruitReference)
        RunServiceReference.Heartbeat:Wait()
    end
    pcall(function() 
        ReplicatedStorageServiceReference:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("ToolsEvent"):FireServer("StoreFruit") 
    end)
    RunServiceReference.Heartbeat:Wait()
    RunServiceReference.Heartbeat:Wait()
    pcall(function() 
        ReplicatedStorageServiceReference:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("ToolsEvent"):FireServer("StoreFruit") 
    end)
    RunServiceReference.Heartbeat:Wait()
    RunServiceReference.Heartbeat:Wait()
    if SelectedFruitReference and SelectedFruitReference.Parent then
        pcall(function() SelectedFruitReference:Destroy() end)
    end
    return true
end

local function GetAvailableTool()
    for _, ToolNameIdentifier in pairs(AvailableToolsListContainer) do
        local ToolReference = LocalPlayerReference.Backpack:FindFirstChild(ToolNameIdentifier) or LocalPlayerReference.Character:FindFirstChild(ToolNameIdentifier)
        if ToolReference then return ToolReference end
    end
    for _, ToolContainerObjectReference in pairs({LocalPlayerReference.Backpack, LocalPlayerReference.Character}) do
        for _, IndividualToolObjectInstance in pairs(ToolContainerObjectReference:GetChildren()) do
            if IndividualToolObjectInstance:IsA("Tool") then
                for _, ToolNameIdentifier in pairs(AvailableToolsListContainer) do
                    if IndividualToolObjectInstance.Name:find(ToolNameIdentifier) then
                        return IndividualToolObjectInstance
                    end
                end
            end
        end
    end
    return nil
end

local function ExecuteTouchInterestForItems(PlayerCharacterInstanceReference, ItemInstanceReference)
    if not PlayerCharacterInstanceReference or not PlayerCharacterInstanceReference:FindFirstChild("HumanoidRootPart") then return end
    local HandleReference = ItemInstanceReference:IsA("Tool") and ItemInstanceReference:FindFirstChild("Handle") or (ItemInstanceReference:IsA("BasePart") and ItemInstanceReference)
    if HandleReference then
        firetouchinterest(PlayerCharacterInstanceReference.HumanoidRootPart, HandleReference, 0) 
        firetouchinterest(PlayerCharacterInstanceReference.HumanoidRootPart, HandleReference, 1)
    end
end

local function ExecuteAutomatedQuestFarmingProcedureRoutine()
    if not AutomatedQuestFarmingActivationState then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then 
        RunServiceReference.Heartbeat:Wait() 
        return ExecuteAutomatedQuestFarmingProcedureRoutine() 
    end
    RunServiceReference.Heartbeat:Wait()
    RunServiceReference.Heartbeat:Wait()
    if getgenv().MicaHubQuestSystemContainer and getgenv().MicaHubQuestSystemContainer.StartQuestManagement then
        getgenv().MicaHubQuestSystemContainer.StartQuestManagement()
    end
    if ProcessSingleFruit() then
        return ExecuteAutomatedQuestFarmingProcedureRoutine()
    end
    local EquippedToolObjectReference = GetAvailableTool()
    if EquippedToolObjectReference and EquippedToolObjectReference:IsA("Tool") and EquippedToolObjectReference.Parent == LocalPlayerReference.Backpack then 
        LocalPlayerReference.Character.Humanoid:EquipTool(EquippedToolObjectReference) 
    end
    RunServiceReference.Heartbeat:Wait()
    return ExecuteAutomatedQuestFarmingProcedureRoutine()
end

local function ExecuteAutomatedFruitCollectionProcedureRoutine()
    if not AutomatedFruitCollectionActivationState then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then 
        RunServiceReference.Heartbeat:Wait() 
        return ExecuteAutomatedFruitCollectionProcedureRoutine() 
    end
    local DroppedToolsWorkspaceContainerReference = workspace:WaitForChild("Playability"):WaitForChild("DroppedTools")
    for _, IndividualDroppedToolObjectInstance in pairs(DroppedToolsWorkspaceContainerReference:GetChildren()) do 
        ExecuteTouchInterestForItems(LocalPlayerReference.Character, IndividualDroppedToolObjectInstance) 
    end
    RunServiceReference.Heartbeat:Wait() 
    return ExecuteAutomatedFruitCollectionProcedureRoutine()
end

local function ExecuteAutomatedFruitStorageProcedureRoutine()
    if not AutomatedFruitStorageActivationState then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then 
        RunServiceReference.Heartbeat:Wait()
        return ExecuteAutomatedFruitStorageProcedureRoutine() 
    end
    if ProcessSingleFruit() then
        RunServiceReference.Heartbeat:Wait()
        RunServiceReference.Heartbeat:Wait()
        RunServiceReference.Heartbeat:Wait()
        return ExecuteAutomatedFruitStorageProcedureRoutine()
    end
    RunServiceReference.Heartbeat:Wait()
    return ExecuteAutomatedFruitStorageProcedureRoutine()
end

local function ExecuteTouchInterestForGameChestsCollection(PlayerCharacterInstanceReference)
    local ChestContainerPathReference = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Int") and workspace.IgnoreList.Int:FindFirstChild("Chests")
    if not ChestContainerPathReference then return end
    for _, IndividualChestPartInstance in pairs(ChestContainerPathReference:GetChildren()) do
        if IndividualChestPartInstance:IsA("BasePart") then 
            ExecuteTouchInterestForItems(PlayerCharacterInstanceReference, IndividualChestPartInstance)
        end
    end
end

local function CreateAutomatedStatusUpgradeProcedureRoutine(StatusTypeValidationFunction, StatusUpgradeTableConfiguration)
    return function()
        if not StatusTypeValidationFunction() then return end
        pcall(function() 
            local UpgradeConfiguration = {}
            for StatusType, BaseValue in pairs(StatusUpgradeTableConfiguration) do
                UpgradeConfiguration[StatusType] = BaseValue * StatusPointsAmount
            end
            ReplicatedStorageServiceReference:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer("UpgradeStat", UpgradeConfiguration) 
        end)
        RunServiceReference.Heartbeat:Wait() 
        return CreateAutomatedStatusUpgradeProcedureRoutine(StatusTypeValidationFunction, StatusUpgradeTableConfiguration)()
    end
end

local function IsToolInAvailableList(ToolNameParameter)
    for _, ToolNameIdentifier in pairs(AvailableToolsListContainer) do
        if ToolNameParameter == ToolNameIdentifier or ToolNameParameter:find(ToolNameIdentifier) then
            return true
        end
    end
    return false
end

FarmingTabContainerReference:AddSection("Farming Functions")

local AutomatedQuestFarmingToggleControlReference = FarmingTabContainerReference:AddToggle("AutomatedQuestFarming", {Title = "Auto Farm Quests [BETA]", Default = false })
AutomatedQuestFarmingToggleControlReference:OnChanged(function(ToggleActivationStateValue) 
    AutomatedQuestFarmingActivationState = ToggleActivationStateValue 
    if AutomatedQuestFarmingActivationState then 
        task.spawn(ExecuteAutomatedQuestFarmingProcedureRoutine)
        if getgenv().MicaHubQuestSystemContainer and getgenv().MicaHubQuestSystemContainer.StartQuestManagement then
            getgenv().MicaHubQuestSystemContainer.StartQuestManagement()
        end
    else
        if getgenv().MicaHubQuestSystemContainer and getgenv().MicaHubQuestSystemContainer.StopQuestManagement then
            getgenv().MicaHubQuestSystemContainer.StopQuestManagement()
        end
    end
end)

local AutomatedEnemyFarmingToggleControlReference = FarmingTabContainerReference:AddToggle("AutomatedEnemyFarming", {Title = "Auto Farm Enemies", Default = false })
AutomatedEnemyFarmingToggleControlReference:OnChanged(function(ToggleActivationStateValue) AutomatedEnemyFarmingActivationState = ToggleActivationStateValue end)

FarmingTabContainerReference:AddSection("Farming Boss")

local BossFarmSelectionDropdownReference = FarmingTabContainerReference:AddDropdown("BossFarmSelection", {Title = "Select Boss Farm", Values = {"AINDA NÃO TERMINEI"}, Multi = false, Default = 1})

FarmingTabContainerReference:AddParagraph({Title = "Selected Boss Spawning: 🔴", Content = ""})

local AutomatedBossFarmingToggleControlReference = FarmingTabContainerReference:AddToggle("AutomatedBossFarming", {Title = "Auto Farm Boss", Default = false })
AutomatedBossFarmingToggleControlReference:OnChanged(function(ToggleActivationStateValue) AutomatedBossFarmingActivationState = ToggleActivationStateValue end)

FarmingTabContainerReference:AddSection("Farming Material")

local MaterialFarmSelectionDropdownReference = FarmingTabContainerReference:AddDropdown("MaterialFarmSelection", {Title = "Select Material", Values = {"AINDA NÃO TERMINEI"}, Multi = false, Default = 1})

local AutomatedMaterialFarmingToggleControlReference = FarmingTabContainerReference:AddToggle("AutomatedMaterialFarming", {Title = "Farming Selected Material", Default = false })
AutomatedMaterialFarmingToggleControlReference:OnChanged(function(ToggleActivationStateValue) AutomatedMaterialFarmingActivationState = ToggleActivationStateValue end)

FarmingTabContainerReference:AddSection("Other Functions")

FarmingTabContainerReference:AddButton({Title = "Redeem All Codes", Description = "Redeem all available codes in the game!", Callback = function()
    if CodesRedeemedExecutedState then return end
    for _, IndividualCodeIdentifierString in pairs({"BugFix1", "BugFix2", "BugFix3", "BugFix4"}) do
        pcall(function() 
            ReplicatedStorageServiceReference:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("CodesEvent"):FireServer("Redeem", IndividualCodeIdentifierString) 
        end)
    end
    CodesRedeemedExecutedState = true
end})

FarmingTabContainerReference:AddButton({Title = "Take All Chests", Description = "Collect Chests Immediately", Callback = function() ExecuteTouchInterestForGameChestsCollection(LocalPlayerReference.Character) end})

FarmingTabContainerReference:AddSection("Basic Settings")

local IncludeBossFarmToggleControlReference = FarmingTabContainerReference:AddToggle("IncludeBossFarm", {Title = "Include Boss Farm", Description = "Enable boss farming integration with other farming functions", Default = false})
IncludeBossFarmToggleControlReference:OnChanged(function(ToggleActivationStateValue)
    IncludeBossFarmActivationState = ToggleActivationStateValue
end)

local WalkingWaterToggleControlReference = FarmingTabContainerReference:AddToggle("WalkingWater", {Title = "Walking Water", Description = "Allows you to walk on water surfaces without swimming", Default = false})
WalkingWaterToggleControlReference:OnChanged(function(ToggleActivationStateValue)
    WalkingWaterActivationState = ToggleActivationStateValue
end)

FarmingTabContainerReference:AddButton({Title = "Remove Waiting Time", Description = "Now the tools don't have any more Cooldown set! Your attacks will now be powerful.", Callback = function()
    if CooldownRemovalExecutedState then return end
    pcall(function()
        local MainModulesContainer = require(ReplicatedStorageServiceReference.MainModules)
        local OriginalIsCooldownFunction = MainModulesContainer.CombatHandler.IsCooldown
        MainModulesContainer.CombatHandler.IsCooldown = function(ToolNameParameter)
            if IsToolInAvailableList(ToolNameParameter) then
                return false
            end
            return OriginalIsCooldownFunction(ToolNameParameter)
        end
        CooldownRemovalExecutedState = true
    end)
end})

StatusTabContainerReference:AddSection("Automatic Status")

local StatusPointsSliderControlReference = StatusTabContainerReference:AddSlider("StatusPoints", {Title = "Status Points Amount", Min = 3, Max = 10, Default = 3, Rounding = 0})
StatusPointsSliderControlReference:OnChanged(function(SliderValue)
    StatusPointsAmount = SliderValue
end)

local StatusUpgradeRoutinesContainer = {
    Defense = CreateAutomatedStatusUpgradeProcedureRoutine(function() return AutomatedStatusUpgradeStates.Defense end, {Defense = 1, Sword = 0, Gun = 0, Strength = 0, DevilFruit = 0}),
    Sword = CreateAutomatedStatusUpgradeProcedureRoutine(function() return AutomatedStatusUpgradeStates.Sword end, {Defense = 0, Sword = 1, Gun = 0, Strength = 0, DevilFruit = 0}),
    Gun = CreateAutomatedStatusUpgradeProcedureRoutine(function
