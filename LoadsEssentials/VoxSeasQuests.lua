local QuestManagementModule = {}

local AutomatedQuestManagementSystemDatabase = {
    ["Bandits Hunter"] = {
        QuestDescriptionIdentifier = "Defeat Bandits",
        RequiredPlayerLevelRange = {1, 25},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Foosha Village"]
    },
    ["Mark Hunter"] = {
        QuestDescriptionIdentifier = "Defeat Shadow Werewolfs",
        RequiredPlayerLevelRange = {25, 50},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Werewolf's Island"]
    },
    ["Mark Hunter Forest"] = {
        QuestDescriptionIdentifier = "Defeat Forest Hunters",
        RequiredPlayerLevelRange = {50, 75},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Werewolf's Island"]
    },
    ["Mark Hunter King"] = {
        QuestDescriptionIdentifier = "Defeat King Werewolf",
        RequiredPlayerLevelRange = {75, 100},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Werewolf's Island"]
    },
    ["Joy Pirate Hunter Bills"] = {
        QuestDescriptionIdentifier = "Defeat Pirate Bills",
        RequiredPlayerLevelRange = {100, 125},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Orange Town"]
    },
    ["Joy Pirate Hunter Officer"] = {
        QuestDescriptionIdentifier = "Defeat Pirate Officer",
        RequiredPlayerLevelRange = {125, 150},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Orange Town"]
    },
    ["Joy Pirate Hunter Clown"] = {
        QuestDescriptionIdentifier = "Defeat Mad Clown",
        RequiredPlayerLevelRange = {150, 175},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Orange Town"]
    }
}

local QuestManagementActiveStatus = false
local QuestLevelMonitoringConnection = nil

local function ExecuteQuestCancellationProcessForCurrentActiveQuest()
    if not getgenv().MicaHubMainInterface then return end
    
    local QuestCancellationArgumentsTable = {"CancelQuest"}
    getgenv().MicaHubMainInterface.RemoteConnections.QuestEvent:FireServer(unpack(QuestCancellationArgumentsTable))
    
    for QuestNpcIdentifierName, QuestInformationDataTable in pairs(AutomatedQuestManagementSystemDatabase) do
        if QuestInformationDataTable.CurrentQuestActivationStatus then
            QuestInformationDataTable.CurrentQuestActivationStatus = false
            break
        end
    end
end

local function ExecuteQuestActivationProcessBySpecificNpcName(SelectedTargetNpcName, QuestDescriptionText)
    if not getgenv().MicaHubMainInterface then return end
    
    local QuestActivationArgumentsTable = {
        "Quests",
        {
            NpcName = SelectedTargetNpcName,
            QuestName = QuestDescriptionText
        }
    }
    getgenv().MicaHubMainInterface.RemoteConnections.DialogueEvent:FireServer(unpack(QuestActivationArgumentsTable))
    
    AutomatedQuestManagementSystemDatabase[SelectedTargetNpcName].CurrentQuestActivationStatus = true
end

local function SearchForSuitableQuestBasedOnPlayerLevelRequirements(CurrentPlayerLevelValue)
    for QuestNpcIdentifierName, QuestInformationDataTable in pairs(AutomatedQuestManagementSystemDatabase) do
        local MinimumRequiredPlayerLevel = QuestInformationDataTable.RequiredPlayerLevelRange[1]
        local MaximumRequiredPlayerLevel = QuestInformationDataTable.RequiredPlayerLevelRange[2]
        
        if CurrentPlayerLevelValue >= MinimumRequiredPlayerLevel and CurrentPlayerLevelValue <= MaximumRequiredPlayerLevel then
            return QuestNpcIdentifierName, QuestInformationDataTable
        end
    end
    return nil, nil
end

local function ExecuteAutomatedQuestManagementSystemUpdateBasedOnPlayerLevel()
    if not QuestManagementActiveStatus then return end
    if not getgenv().MicaHubMainInterface then return end
    if not getgenv().MicaHubMainInterface.ToggleStates.QuestFarming() then return end
    
    local CurrentPlayerLevelValue = getgenv().MicaHubMainInterface.PlayerReferences.PlayerLevel()
    local SuitableQuestNpcIdentifierName, SuitableQuestInformationDataTable = SearchForSuitableQuestBasedOnPlayerLevelRequirements(CurrentPlayerLevelValue)
    
    if SuitableQuestNpcIdentifierName and not SuitableQuestInformationDataTable.CurrentQuestActivationStatus then
        for QuestNpcIdentifierName, QuestInformationDataTable in pairs(AutomatedQuestManagementSystemDatabase) do
            if QuestInformationDataTable.CurrentQuestActivationStatus and QuestNpcIdentifierName ~= SuitableQuestNpcIdentifierName then
                ExecuteQuestCancellationProcessForCurrentActiveQuest()
                break
            end
        end
        
        local HasCurrentlyActiveQuestStatus = false
        for _, QuestInformationDataTable in pairs(AutomatedQuestManagementSystemDatabase) do
            if QuestInformationDataTable.CurrentQuestActivationStatus then
                HasCurrentlyActiveQuestStatus = true
                break
            end
        end
        
        if not HasCurrentlyActiveQuestStatus then
            ExecuteQuestActivationProcessBySpecificNpcName(SuitableQuestNpcIdentifierName, SuitableQuestInformationDataTable.QuestDescriptionIdentifier)
        end
    end
end

function QuestManagementModule.StartQuestManagement()
    if QuestManagementActiveStatus then return end
    
    QuestManagementActiveStatus = true
    ExecuteAutomatedQuestManagementSystemUpdateBasedOnPlayerLevel()
    
    if getgenv().MicaHubMainInterface and getgenv().MicaHubMainInterface.PlayerReferences.LocalPlayer then
        local PlayerLevelDisplayElement = getgenv().MicaHubMainInterface.PlayerReferences.LocalPlayer.PlayerGui.MainUI.MainFrame.StastisticsFrame.BaseFrame.Level
        QuestLevelMonitoringConnection = PlayerLevelDisplayElement:GetPropertyChangedSignal("Text"):Connect(ExecuteAutomatedQuestManagementSystemUpdateBasedOnPlayerLevel)
    end
end

function QuestManagementModule.StopQuestManagement()
    if not QuestManagementActiveStatus then return end
    
    QuestManagementActiveStatus = false
    ExecuteQuestCancellationProcessForCurrentActiveQuest()
    
    if QuestLevelMonitoringConnection then
        QuestLevelMonitoringConnection:Disconnect()
        QuestLevelMonitoringConnection = nil
    end
end

function QuestManagementModule.GetQuestDatabase()
    return AutomatedQuestManagementSystemDatabase
end

function QuestManagementModule.GetCurrentActiveQuest()
    for QuestNpcIdentifierName, QuestInformationDataTable in pairs(AutomatedQuestManagementSystemDatabase) do
        if QuestInformationDataTable.CurrentQuestActivationStatus then
            return QuestNpcIdentifierName, QuestInformationDataTable
        end
    end
    return nil, nil
end

function QuestManagementModule.UpdateQuestStatus(QuestNpcName, NewStatus)
    if AutomatedQuestManagementSystemDatabase[QuestNpcName] then
        AutomatedQuestManagementSystemDatabase[QuestNpcName].CurrentQuestActivationStatus = NewStatus
        return true
    end
    return false
end

function QuestManagementModule.GetQuestByLevel(PlayerLevel)
    return SearchForSuitableQuestBasedOnPlayerLevelRequirements(PlayerLevel)
end

function QuestManagementModule.IsQuestManagementActive()
    return QuestManagementActiveStatus
end

return QuestManagementModule
