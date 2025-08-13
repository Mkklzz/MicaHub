local QuestManagementModuleContainer = {}

local AutomatedQuestManagementSystemDatabaseContainer = {
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

local QuestManagementActiveStatusReference = false
local QuestLevelMonitoringConnectionReference = nil

local function ExecuteQuestCancellationProcessForCurrentActiveQuestRoutine()
    if not getgenv().MicaHubMainInterfaceContainer then return end
    
    local QuestCancellationArgumentsTableReference = {"CancelQuest"}
    getgenv().MicaHubMainInterfaceContainer.RemoteConnectionsContainer.QuestEventReference:FireServer(unpack(QuestCancellationArgumentsTableReference))
    
    for QuestNpcIdentifierNameReference, QuestInformationDataTableContainer in pairs(AutomatedQuestManagementSystemDatabaseContainer) do
        if QuestInformationDataTableContainer.CurrentQuestActivationStatus then
            QuestInformationDataTableContainer.CurrentQuestActivationStatus = false
            break
        end
    end
end

local function ExecuteQuestActivationProcessBySpecificNpcNameRoutine(SelectedTargetNpcNameReference, QuestDescriptionTextReference)
    if not getgenv().MicaHubMainInterfaceContainer then return end
    
    local QuestActivationArgumentsTableConfiguration = {
        "Quests",
        {
            NpcName = SelectedTargetNpcNameReference,
            QuestName = QuestDescriptionTextReference
        }
    }
    getgenv().MicaHubMainInterfaceContainer.RemoteConnectionsContainer.DialogueEventReference:FireServer(unpack(QuestActivationArgumentsTableConfiguration))
    
    AutomatedQuestManagementSystemDatabaseContainer[SelectedTargetNpcNameReference].CurrentQuestActivationStatus = true
end

local function SearchForSuitableQuestBasedOnPlayerLevelRequirementsValidation(CurrentPlayerLevelValueReference)
    for QuestNpcIdentifierNameReference, QuestInformationDataTableContainer in pairs(AutomatedQuestManagementSystemDatabaseContainer) do
        local MinimumRequiredPlayerLevelValue = QuestInformationDataTableContainer.RequiredPlayerLevelRange[1]
        local MaximumRequiredPlayerLevelValue = QuestInformationDataTableContainer.RequiredPlayerLevelRange[2]
        
        if CurrentPlayerLevelValueReference >= MinimumRequiredPlayerLevelValue and CurrentPlayerLevelValueReference <= MaximumRequiredPlayerLevelValue then
            return QuestNpcIdentifierNameReference, QuestInformationDataTableContainer
        end
    end
    return nil, nil
end

local function ExecuteAutomatedQuestManagementSystemUpdateBasedOnPlayerLevelRoutine()
    if not QuestManagementActiveStatusReference then return end
    if not getgenv().MicaHubMainInterfaceContainer then return end
    if not getgenv().MicaHubMainInterfaceContainer.ToggleStatesContainer.QuestFarmingActivation() then return end
    
    local CurrentPlayerLevelValueReference = getgenv().MicaHubMainInterfaceContainer.PlayerReferencesContainer.PlayerLevelValue()
    local SuitableQuestNpcIdentifierNameReference, SuitableQuestInformationDataTableContainer = SearchForSuitableQuestBasedOnPlayerLevelRequirementsValidation(CurrentPlayerLevelValueReference)
    
    if SuitableQuestNpcIdentifierNameReference and not SuitableQuestInformationDataTableContainer.CurrentQuestActivationStatus then
        for QuestNpcIdentifierNameReference, QuestInformationDataTableContainer in pairs(AutomatedQuestManagementSystemDatabaseContainer) do
            if QuestInformationDataTableContainer.CurrentQuestActivationStatus and QuestNpcIdentifierNameReference ~= SuitableQuestNpcIdentifierNameReference then
                ExecuteQuestCancellationProcessForCurrentActiveQuestRoutine()
                break
            end
        end
        
        local HasCurrentlyActiveQuestStatusValidation = false
        for _, QuestInformationDataTableContainer in pairs(AutomatedQuestManagementSystemDatabaseContainer) do
            if QuestInformationDataTableContainer.CurrentQuestActivationStatus then
                HasCurrentlyActiveQuestStatusValidation = true
                break
            end
        end
        
        if not HasCurrentlyActiveQuestStatusValidation then
            ExecuteQuestActivationProcessBySpecificNpcNameRoutine(SuitableQuestNpcIdentifierNameReference, SuitableQuestInformationDataTableContainer.QuestDescriptionIdentifier)
        end
    end
end

function QuestManagementModuleContainer.StartQuestManagement()
    if QuestManagementActiveStatusReference then return end
    
    QuestManagementActiveStatusReference = true
    ExecuteAutomatedQuestManagementSystemUpdateBasedOnPlayerLevelRoutine()
    
    if getgenv().MicaHubMainInterfaceContainer and getgenv().MicaHubMainInterfaceContainer.PlayerReferencesContainer.LocalPlayerInstance then
        local PlayerLevelDisplayElementReference = getgenv().MicaHubMainInterfaceContainer.PlayerReferencesContainer.LocalPlayerInstance.PlayerGui.MainUI.MainFrame.StastisticsFrame.BaseFrame.Level
        QuestLevelMonitoringConnectionReference = PlayerLevelDisplayElementReference:GetPropertyChangedSignal("Text"):Connect(ExecuteAutomatedQuestManagementSystemUpdateBasedOnPlayerLevelRoutine)
    end
end

function QuestManagementModuleContainer.StopQuestManagement()
    if not QuestManagementActiveStatusReference then return end
    
    QuestManagementActiveStatusReference = false
    ExecuteQuestCancellationProcessForCurrentActiveQuestRoutine()
    
    if QuestLevelMonitoringConnectionReference then
        QuestLevelMonitoringConnectionReference:Disconnect()
        QuestLevelMonitoringConnectionReference = nil
    end
end

function QuestManagementModuleContainer.GetQuestDatabase()
    return AutomatedQuestManagementSystemDatabaseContainer
end

function QuestManagementModuleContainer.GetCurrentActiveQuest()
    for QuestNpcIdentifierNameReference, QuestInformationDataTableContainer in pairs(AutomatedQuestManagementSystemDatabaseContainer) do
        if QuestInformationDataTableContainer.CurrentQuestActivationStatus then
            return QuestNpcIdentifierNameReference, QuestInformationDataTableContainer
        end
    end
    return nil, nil
end

function QuestManagementModuleContainer.UpdateQuestStatus(QuestNpcNameParameter, NewStatusParameter)
    if AutomatedQuestManagementSystemDatabaseContainer[QuestNpcNameParameter] then
        AutomatedQuestManagementSystemDatabaseContainer[QuestNpcNameParameter].CurrentQuestActivationStatus = NewStatusParameter
        return true
    end
    return false
end

function QuestManagementModuleContainer.GetQuestByLevel(PlayerLevelParameter)
    return SearchForSuitableQuestBasedOnPlayerLevelRequirementsValidation(PlayerLevelParameter)
end

function QuestManagementModuleContainer.IsQuestManagementActive()
    return QuestManagementActiveStatusReference
end

return QuestManagementModuleContainer
