if game.PlaceId ~= 104067066727140 then 
    loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))():Notify({Title = "MicaHub Information", Content = "You're not on Vox Seas, idiot! Run the script on Vox Seas!", Duration = 8})
    return 
end

local ReplicatedStorageServiceReference, PlayersServiceReference, LocalPlayerReference, RunServiceReference, TweenServiceReference = game:GetService("ReplicatedStorage"), game:GetService("Players"), game:GetService("Players").LocalPlayer, game:GetService("RunService"), game:GetService("TweenService")
repeat RunServiceReference.Heartbeat:wait() until LocalPlayerReference.Character

local GameFrameworkModuleContainer, MainModulesContainer = ReplicatedStorageServiceReference:WaitForChild("Framework"), ReplicatedStorageServiceReference:WaitForChild("MainModules")
local AutomatedQuestFarmingActivationState, AutomatedMobBringingActivationState, AutomatedFruitCollectionActivationState, AutomatedFruitStorageActivationState, AutomatedDefenseStatusUpgradeActivationState, AutomatedSwordStatusUpgradeActivationState, AutomatedGunStatusUpgradeActivationState, AutomatedStrengthStatusUpgradeActivationState, AutomatedDevilFruitStatusUpgradeActivationState, CooldownRemovalExecutedState = false, false, false, false, false, false, false, false, false, false
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
    MobileToggleButtonElement.Parent, MobileToggleButtonElement.BackgroundColor3, MobileToggleButtonElement.BackgroundTransparency, MobileToggleButtonElement.Position, MobileToggleButtonElement.Size, MobileToggleButtonElement.Image, MobileToggleButtonElement.Draggable, MobileToggleButtonElement.Transparency = MobileUIScreenGuiContainer, Color3.fromRGB(105,105,105), 0.8, UDim2.new(0.9,0,0.1,0), UDim2.new(0,50,0,50), "rbxassetid://95816097006870", true, 1
    MobileButtonCornerRadiusElement.CornerRadius, MobileButtonCornerRadiusElement.Parent = UDim.new(0,200), MobileToggleButtonElement
    MobileToggleButtonElement.MouseButton1Click:Connect(function() game:GetService("VirtualInputManager"):SendKeyEvent(true,"LeftControl",false,game) end)
end)

local FluentLibraryInterfaceContainer = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local PrimaryDashboardWindowInstance = FluentLibraryInterfaceContainer:CreateWindow({Title = "MicaHub", SubTitle = "Vox Seas", TabWidth = 160, Size = UDim2.fromOffset(550, 330), Acrylic = false, Theme = "Dark", MinimizeKey = Enum.KeyCode.LeftControl})
PrimaryDashboardWindowInstance:Minimize()

local AuthorTabContainerReference, HomeTabContainerReference, StatusTabContainerReference, OthersTabContainerReference, SettingsTabContainerReference = PrimaryDashboardWindowInstance:AddTab({ Title = "Author", Icon = "user" }), PrimaryDashboardWindowInstance:AddTab({ Title = "Home", Icon = "home" }), PrimaryDashboardWindowInstance:AddTab({ Title = "Status", Icon = "trending-up" }), PrimaryDashboardWindowInstance:AddTab({ Title = "Others", Icon = "layers" }), PrimaryDashboardWindowInstance:AddTab({ Title = "Settings", Icon = "settings" })

AuthorTabContainerReference:AddSection("Author Information")
AuthorTabContainerReference:AddParagraph({Title = "Thank you for using my Dashboard!", Content = "I'm still developing, some functions may be incomplete or bugs!"})
AuthorTabContainerReference:AddParagraph({Title = "GitHub: Mkklzz", Content = ""})
AuthorTabContainerReference:AddButton({Title = "Join Discord Server", Description = "Join the author's discord. To receive information or updates", Callback = function()
    PrimaryDashboardWindowInstance:Dialog({Title = "Discord link copied", Content = "The Discord link has been copied to your clipboard. You can now paste it in your browser to join the server.", Buttons = {
        {Title = "Ok", Callback = function() end}
    }})
    setclipboard("https://discord.gg/yfsKgGYU4e")
end})

HomeTabContainerReference:AddSection("Automatic Functions")

local function ProcessSingleFruit()
    for _, ToolContainerObjectReference in pairs({LocalPlayerReference.Backpack, LocalPlayerReference.Character}) do
        for _, IndividualToolObjectInstance in pairs(ToolContainerObjectReference:GetChildren()) do
            if IndividualToolObjectInstance:IsA("Tool") and IndividualToolObjectInstance.Name:match("Fruit$") then
                if IndividualToolObjectInstance.Parent == LocalPlayerReference.Backpack then
                    LocalPlayerReference.Character.Humanoid:EquipTool(IndividualToolObjectInstance)
                    RunServiceReference.Heartbeat:wait()
                end
                local FruitReference = IndividualToolObjectInstance
                pcall(function() 
                    ReplicatedStorageServiceReference:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("ToolsEvent"):FireServer("StoreFruit") 
                end)
                RunServiceReference.Heartbeat:wait()
                RunServiceReference.Heartbeat:wait()
                if FruitReference and FruitReference.Parent then
                    pcall(function() FruitReference:Destroy() end)
                end
                return true
            end
        end
    end
    return false
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

local function ExecuteAutomatedQuestFarmingProcedureRoutine()
    if not AutomatedQuestFarmingActivationState then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then 
        RunServiceReference.Heartbeat:wait() 
        return ExecuteAutomatedQuestFarmingProcedureRoutine() 
    end
    if ProcessSingleFruit() then
        return ExecuteAutomatedQuestFarmingProcedureRoutine()
    end
    local EquippedToolObjectReference = GetAvailableTool()
    if EquippedToolObjectReference and EquippedToolObjectReference:IsA("Tool") and EquippedToolObjectReference.Parent == LocalPlayerReference.Backpack then 
        LocalPlayerReference.Character.Humanoid:EquipTool(EquippedToolObjectReference) 
    end
    RunServiceReference.Heartbeat:wait()
    return ExecuteAutomatedQuestFarmingProcedureRoutine()
end

local AutomatedQuestFarmingToggleControlReference = HomeTabContainerReference:AddToggle("AutomatedQuestFarming", {Title = "Auto Farm Quests", Default = false })
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

local AutomatedMobBringingToggleControlReference = HomeTabContainerReference:AddToggle("AutomatedMobBringing", {Title = "Auto Bring Mobs [BETA]", Default = false })
AutomatedMobBringingToggleControlReference:OnChanged(function(ToggleActivationStateValue) AutomatedMobBringingActivationState = ToggleActivationStateValue end)

local function ExecuteTouchInterestForGameChestsCollection(PlayerCharacterInstanceReference)
    local ChestContainerPathReference = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Int") and workspace.IgnoreList.Int:FindFirstChild("Chests")
    if not ChestContainerPathReference or not PlayerCharacterInstanceReference or not PlayerCharacterInstanceReference:FindFirstChild("HumanoidRootPart") then return end
    for _, IndividualChestPartInstance in pairs(ChestContainerPathReference:GetChildren()) do
        if IndividualChestPartInstance:IsA("BasePart") then 
            firetouchinterest(PlayerCharacterInstanceReference.HumanoidRootPart, IndividualChestPartInstance, 0) 
            firetouchinterest(PlayerCharacterInstanceReference.HumanoidRootPart, IndividualChestPartInstance, 1) 
        end
    end
end

local function ExecuteTouchInterestForDroppedFruitsCollection(PlayerCharacterInstanceReference, DroppedToolObjectInstance)
    if not PlayerCharacterInstanceReference or not PlayerCharacterInstanceReference:FindFirstChild("HumanoidRootPart") or not DroppedToolObjectInstance:IsA("Tool") or not DroppedToolObjectInstance:FindFirstChild("Handle") then return end
    firetouchinterest(PlayerCharacterInstanceReference.HumanoidRootPart, DroppedToolObjectInstance.Handle, 0) 
    firetouchinterest(PlayerCharacterInstanceReference.HumanoidRootPart, DroppedToolObjectInstance.Handle, 1)
end

HomeTabContainerReference:AddButton({Title = "Take All Chests", Description = "Collect Chests Immediately", Callback = function() ExecuteTouchInterestForGameChestsCollection(LocalPlayerReference.Character) end})
HomeTabContainerReference:AddButton({Title = "Redeem All Codes", Description = "Redeem all available codes in the game!", Callback = function()
    for _, IndividualCodeIdentifierString in pairs({"BugFix1", "BugFix2", "BugFix3", "Release"}) do
        pcall(function() 
            ReplicatedStorageServiceReference:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("CodesEvent"):FireServer("Redeem", IndividualCodeIdentifierString) 
        end)
    end
end})

HomeTabContainerReference:AddSection("Basic Settings")

local function IsToolInAvailableList(ToolNameParameter)
    for _, ToolNameIdentifier in pairs(AvailableToolsListContainer) do
        if ToolNameParameter == ToolNameIdentifier or ToolNameParameter:find(ToolNameIdentifier) then
            return true
        end
    end
    return false
end

HomeTabContainerReference:AddButton({Title = "Remove Waiting Time", Description = "Now the tools don't have any more Cooldown set! Your attacks will now be powerful.", Callback = function()
    if CooldownRemovalExecutedState then
        PrimaryDashboardWindowInstance:Dialog({Title = "MicaHub Information", Content = "Cooldown removal has already been executed! This function can only be used once per session to prevent conflicts.", Buttons = {
            {Title = "Ok", Callback = function() end}
        }})
        return
    end
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

local function CreateAutomatedStatusUpgradeProcedureRoutine(StatusTypeValidationFunction, StatusUpgradeTableConfiguration)
    return function()
        if not StatusTypeValidationFunction() then return end
        pcall(function() 
            ReplicatedStorageServiceReference:WaitForChild("BetweenSides"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("StatsEvent"):FireServer("UpgradeStat", StatusUpgradeTableConfiguration) 
        end)
        RunServiceReference.Heartbeat:wait() 
        return CreateAutomatedStatusUpgradeProcedureRoutine(StatusTypeValidationFunction, StatusUpgradeTableConfiguration)()
    end
end

local StatusUpgradeRoutinesContainer = {
    Defense = CreateAutomatedStatusUpgradeProcedureRoutine(function() return AutomatedDefenseStatusUpgradeActivationState end, {Defense = 1, Sword = 0, Gun = 0, Strength = 0, DevilFruit = 0}),
    Sword = CreateAutomatedStatusUpgradeProcedureRoutine(function() return AutomatedSwordStatusUpgradeActivationState end, {Defense = 0, Sword = 1, Gun = 0, Strength = 0, DevilFruit = 0}),
    Gun = CreateAutomatedStatusUpgradeProcedureRoutine(function() return AutomatedGunStatusUpgradeActivationState end, {Defense = 0, Sword = 0, Gun = 1, Strength = 0, DevilFruit = 0}),
    Strength = CreateAutomatedStatusUpgradeProcedureRoutine(function() return AutomatedStrengthStatusUpgradeActivationState end, {Defense = 0, Sword = 0, Gun = 0, Strength = 1, DevilFruit = 0}),
    DevilFruit = CreateAutomatedStatusUpgradeProcedureRoutine(function() return AutomatedDevilFruitStatusUpgradeActivationState end, {Defense = 0, Sword = 0, Gun = 0, Strength = 0, DevilFruit = 1})
}

local StatusActivationStates = {
    Defense = function(value) AutomatedDefenseStatusUpgradeActivationState = value end,
    Sword = function(value) AutomatedSwordStatusUpgradeActivationState = value end,
    Gun = function(value) AutomatedGunStatusUpgradeActivationState = value end,
    Strength = function(value) AutomatedStrengthStatusUpgradeActivationState = value end,
    DevilFruit = function(value) AutomatedDevilFruitStatusUpgradeActivationState = value end
}

local function CreateStatusUpgradeToggleConfiguration(StatusNameIdentifier)
    local ToggleControlReference = StatusTabContainerReference:AddToggle("Automated" .. StatusNameIdentifier .. "StatusUpgrade", {Title = "Auto Status " .. StatusNameIdentifier, Default = false})
    ToggleControlReference:OnChanged(function(ToggleActivationStateValue) 
        StatusActivationStates[StatusNameIdentifier](ToggleActivationStateValue)
        if ToggleActivationStateValue then 
            task.spawn(StatusUpgradeRoutinesContainer[StatusNameIdentifier]) 
        end 
    end)
end

for StatusName, _ in pairs(StatusUpgradeRoutinesContainer) do
    CreateStatusUpgradeToggleConfiguration(StatusName)
end

OthersTabContainerReference:AddSection("Fruits Functionality")

local DroppedToolsWorkspaceContainerReference = workspace:WaitForChild("Playability"):WaitForChild("DroppedTools")

local function ExecuteAutomatedFruitCollectionProcedureRoutine()
    if not AutomatedFruitCollectionActivationState then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then 
        RunServiceReference.Heartbeat:wait() 
        return ExecuteAutomatedFruitCollectionProcedureRoutine() 
    end
    for _, IndividualDroppedToolObjectInstance in pairs(DroppedToolsWorkspaceContainerReference:GetChildren()) do 
        ExecuteTouchInterestForDroppedFruitsCollection(LocalPlayerReference.Character, IndividualDroppedToolObjectInstance) 
    end
    RunServiceReference.Heartbeat:wait() 
    return ExecuteAutomatedFruitCollectionProcedureRoutine()
end

local AutomatedFruitCollectionToggleControlReference = OthersTabContainerReference:AddToggle("AutomatedFruitCollection", {Title = "Auto Collect Fruits", Default = false })
AutomatedFruitCollectionToggleControlReference:OnChanged(function(ToggleActivationStateValue) 
    AutomatedFruitCollectionActivationState = ToggleActivationStateValue 
    if AutomatedFruitCollectionActivationState then 
        task.spawn(ExecuteAutomatedFruitCollectionProcedureRoutine) 
    end 
end)

local AutomatedFruitStorageCoroutineReference
local function ExecuteAutomatedFruitStorageProcedureRoutine()
    if not AutomatedFruitStorageActivationState then return end
    if not LocalPlayerReference.Character or not LocalPlayerReference.Character:FindFirstChild("HumanoidRootPart") then 
        RunServiceReference.Heartbeat:wait()
        return ExecuteAutomatedFruitStorageProcedureRoutine() 
    end
    if ProcessSingleFruit() then
        return ExecuteAutomatedFruitStorageProcedureRoutine()
    end
    RunServiceReference.Heartbeat:wait()
    return ExecuteAutomatedFruitStorageProcedureRoutine()
end

local AutomatedFruitStorageToggleControlReference = OthersTabContainerReference:AddToggle("AutomatedFruitStorage", {Title = "Auto Store Fruits", Default = false })
AutomatedFruitStorageToggleControlReference:OnChanged(function(ToggleActivationStateValue) 
    AutomatedFruitStorageActivationState = ToggleActivationStateValue 
    if AutomatedFruitStorageActivationState then 
        if AutomatedFruitStorageCoroutineReference then
            task.cancel(AutomatedFruitStorageCoroutineReference)
        end
        AutomatedFruitStorageCoroutineReference = task.spawn(ExecuteAutomatedFruitStorageProcedureRoutine)
    else
        if AutomatedFruitStorageCoroutineReference then
            task.cancel(AutomatedFruitStorageCoroutineReference)
            AutomatedFruitStorageCoroutineReference = nil
        end
    end
end)

OthersTabContainerReference:AddSection("Teleporting World")

local function RetrieveAvailablePortalLocationsContainer()
    local PortalContainerFolderReference = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Portal")
    if not PortalContainerFolderReference then return {} end
    local AvailableLocationsListContainer = {}
    for _, IndividualPortalPartInstance in pairs(PortalContainerFolderReference:GetChildren()) do
        if IndividualPortalPartInstance:IsA("BasePart") then 
            table.insert(AvailableLocationsListContainer, IndividualPortalPartInstance.Name) 
        end
    end
    return AvailableLocationsListContainer
end

local TeleportationDestinationSelectionDropdownReference = OthersTabContainerReference:AddDropdown("TeleportationDestinationSelection", {Title = "Select Teleport Location", Values = RetrieveAvailablePortalLocationsContainer(), Multi = false, Default = 1})

OthersTabContainerReference:AddButton({Title = "Teleport to Location [ANTICHEAT DE MERDA]", Description = "Teleport to Selected Island", Callback = function()
    if AutomatedQuestFarmingActivationState or AutomatedMobBringingActivationState then
        PrimaryDashboardWindowInstance:Dialog({Title = "MicaHub Information", Content = "Cannot teleport while automated functions are running. Disable Auto Farm Quests and Auto Bring Mobs before teleporting.", Buttons = {
            {Title = "Ok", Callback = function() end}
        }})
        return
    end
    local SelectedTeleportationDestinationValue = TeleportationDestinationSelectionDropdownReference.Value
    if not SelectedTeleportationDestinationValue or not LocalPlayerReference.Character then return end
    local PortalContainerFolderReference = workspace:FindFirstChild("IgnoreList") and workspace.IgnoreList:FindFirstChild("Portal")
    if not PortalContainerFolderReference then return end
    local TargetPortalDestinationReference = PortalContainerFolderReference:FindFirstChild(SelectedTeleportationDestinationValue)
    if not TargetPortalDestinationReference or not TargetPortalDestinationReference:IsA("BasePart") then return end
    LocalPlayerReference.Character:PivotTo(TargetPortalDestinationReference.CFrame)
end})

OthersTabContainerReference:AddSection("Https Servers Connections")
OthersTabContainerReference:AddParagraph({Title = "How does it work?", Content = "Join servers with specific items using the code available on our Discord."})

local ServerConnectionCodeInputFieldReference = OthersTabContainerReference:AddInput("ServerConnectionCode", {Title = "Target Server Code", Default = "", Placeholder = "", Numeric = false, Finished = false})

OthersTabContainerReference:AddButton({Title = "Join the Server", Description = "Use this button to connect to the server", Callback = function()
    PrimaryDashboardWindowInstance:Dialog({Title = "Https Servers Connections", Content = "Are you sure you want to connect?", Buttons = {
        {Title = "Confirm", Callback = function()
            local ProvidedServerCodeValue = ServerConnectionCodeInputFieldReference.Value
            if ProvidedServerCodeValue and ProvidedServerCodeValue ~= "" then 
                pcall(function() 
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, ProvidedServerCodeValue, LocalPlayerReference) 
                end) 
            end
        end},
        {Title = "Cancel", Callback = function() end}
    }})
end})

getgenv().MicaHubMainInterfaceContainer = {
    ToggleStatesContainer = {
        QuestFarmingActivation = function() return AutomatedQuestFarmingActivationState end,
        MobBringingActivation = function() return AutomatedMobBringingActivationState end,
        FruitCollectionActivation = function() return AutomatedFruitCollectionActivationState end,
        FruitStorageActivation = function() return AutomatedFruitStorageActivationState end
    },
    PlayerReferencesContainer = {
        LocalPlayerInstance = LocalPlayerReference,
        CharacterInstance = function() return LocalPlayerReference.Character end,
        PlayerLevelValue = function() return tonumber(PlayerLevelDisplayElementReference.Text) or 1 end
    },
    RemoteConnectionsContainer = {
        DialogueEventReference = DialogueSystemRemoteEventHandlerReference,
        QuestEventReference = QuestManagementRemoteEventHandlerReference
    }
}

PrimaryDashboardWindowInstance:SelectTab(1)
