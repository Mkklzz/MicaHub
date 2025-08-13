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
    },
    ["Paul Desert Bandit"] = {
        QuestDescriptionIdentifier = "Defeat Desert Bandits",
        RequiredPlayerLevelRange = {175, 200},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Sandstorm Island"]
    },
    ["Paul Desert Guardian"] = {
        QuestDescriptionIdentifier = "Defeat Desert Guardians",
        RequiredPlayerLevelRange = {200, 225},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Sandstorm Island"]
    },
    ["Paul Pharaoh"] = {
        QuestDescriptionIdentifier = "Defeat Pharaoh",
        RequiredPlayerLevelRange = {225, 250},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Sandstorm Island"]
    },
    ["Ryan Snow Frozen Warrior"] = {
        QuestDescriptionIdentifier = "Defeat Frozen Warriors",
        RequiredPlayerLevelRange = {250, 275},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Frost Island"]
    },
    ["Ryan Snow Winter Soldier"] = {
        QuestDescriptionIdentifier = "Defeat Winter Soldiers",
        RequiredPlayerLevelRange = {275, 300},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Frost Island"]
    },
    ["Ryan Snow Ice King"] = {
        QuestDescriptionIdentifier = "Defeat Ice King",
        RequiredPlayerLevelRange = {300, 325},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Frost Island"]
    },
    ["Olliver Marine Officer"] = {
        QuestDescriptionIdentifier = "Defeat Marine Officers",
        RequiredPlayerLevelRange = {325, 375},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Marine Ford"]
    },
    ["Olliver Vice Admiral"] = {
        QuestDescriptionIdentifier = "Defeat Vice Admiral",
        RequiredPlayerLevelRange = {375, 400},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Marine Ford"]
    },
    ["Pedro Celestial Bandit"] = {
        QuestDescriptionIdentifier = "Defeat Celestial Bandits",
        RequiredPlayerLevelRange = {400, 425},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Skypie Down"]
    },
    ["Pedro Shadow Master"] = {
        QuestDescriptionIdentifier = "Defeat Shadow Masters",
        RequiredPlayerLevelRange = {425, 450},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Skypie Down"]
    },
    ["Jonas Prisoner"] = {
        QuestDescriptionIdentifier = "Defeat Prisoners",
        RequiredPlayerLevelRange = {450, 475},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Prison"]
    },
    ["Jonas Dangerous Prisoner"] = {
        QuestDescriptionIdentifier = "Defeat Dangerous Prisoners",
        RequiredPlayerLevelRange = {475, 500},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Prison"]
    },
    ["Guard Alex Valion Ironmaul"] = {
        QuestDescriptionIdentifier = "Defeat Valion Ironmaul",
        RequiredPlayerLevelRange = {500, 525},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Prison"]
    },
    ["Guard Alex Koaby"] = {
        QuestDescriptionIdentifier = "Defeat Koaby",
        RequiredPlayerLevelRange = {525, 550},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Prison"]
    },
    ["Guard Alex Muzzlejaw"] = {
        QuestDescriptionIdentifier = "Defeat Muzzlejaw",
        RequiredPlayerLevelRange = {550, 575},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Prison"]
    },
    ["Dex Veteran Gladiator"] = {
        QuestDescriptionIdentifier = "Defeat Veteran Gladiators",
        RequiredPlayerLevelRange = {575, 600},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Coliseum"]
    },
    ["Dex Veteran Warrior"] = {
        QuestDescriptionIdentifier = "Defeat Veteran Warriors",
        RequiredPlayerLevelRange = {600, 625},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Coliseum"]
    },
    ["Clay Magma Soldier"] = {
        QuestDescriptionIdentifier = "Defeat Magma Soldiers",
        RequiredPlayerLevelRange = {625, 650},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Vulcan Island"]
    },
    ["Clay Magma Spy"] = {
        QuestDescriptionIdentifier = "Defeat Magma Spys",
        RequiredPlayerLevelRange = {650, 675},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Vulcan Island"]
    },
    ["Clay Admiral Vulkran"] = {
        QuestDescriptionIdentifier = "Defeat Admiral Vulkran",
        RequiredPlayerLevelRange = {675, 700},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Vulcan Island"]
    },
    ["King Tritan Fishman"] = {
        QuestDescriptionIdentifier = "Defeat Fishmans",
        RequiredPlayerLevelRange = {700, 725},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Sharkman Park"]
    },
    ["King Tritan Triton Warrior"] = {
        QuestDescriptionIdentifier = "Defeat Triton Warriors",
        RequiredPlayerLevelRange = {725, 750},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Sharkman Park"]
    },
    ["King Tritan Lord Triton"] = {
        QuestDescriptionIdentifier = "Defeat Lord Triton",
        RequiredPlayerLevelRange = {750, 775},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Sharkman Park"]
    },
    ["Jhon Divine Guardian"] = {
        QuestDescriptionIdentifier = "Defeat Divine Guardians",
        RequiredPlayerLevelRange = {775, 800},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Skypie Upper"]
    },
    ["Jhon Shanda"] = {
        QuestDescriptionIdentifier = "Defeat Shandas",
        RequiredPlayerLevelRange = {800, 825},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Skypie Upper"]
    },
    ["Jhon Wysper"] = {
        QuestDescriptionIdentifier = "Defeat Wysper",
        RequiredPlayerLevelRange = {825, 850},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Skypie Upper"]
    },
    ["Sam Royal Squadron"] = {
        QuestDescriptionIdentifier = "Defeat Royal Squadrons",
        RequiredPlayerLevelRange = {850, 875},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Skypie Upper"]
    },
    ["Sam Royal Soldier"] = {
        QuestDescriptionIdentifier = "Defeat Royal Soldiers",
        RequiredPlayerLevelRange = {875, 900},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Skypie Upper"]
    },
    ["Sam Thunder God"] = {
        QuestDescriptionIdentifier = "Defeat Thunder God",
        RequiredPlayerLevelRange = {900, 925},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Skypie Upper"]
    },
    ["Arthur Pirate Fighter"] = {
        QuestDescriptionIdentifier = "Defeat Pirate Fighters",
        RequiredPlayerLevelRange = {925, 950},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Fountain"]
    },
    ["Arthur Pirate Henchman"] = {
        QuestDescriptionIdentifier = "Defeat Pirate Henchmans",
        RequiredPlayerLevelRange = {950, 975},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Fountain"]
    },
    ["Arthur Abandoned Experiment"] = {
        QuestDescriptionIdentifier = "Defeat Abandoned Experiment",
        RequiredPlayerLevelRange = {975, 1000},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Fountain"]
    },
    ["Scientist Experiment 13"] = {
        QuestDescriptionIdentifier = "Defeat Experiment #13",
        RequiredPlayerLevelRange = {1000, 1025},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Fountain"]
    },
    ["Scientist Experiment 14"] = {
        QuestDescriptionIdentifier = "Defeat Experiment #14",
        RequiredPlayerLevelRange = {1025, 1050},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = false,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Fountain"]
    },
    ["Scientist EX-77 Ironfist"] = {
        QuestDescriptionIdentifier = "Defeat EX-77 Ironfist",
        RequiredPlayerLevelRange = {1050, 1101},
        CurrentQuestActivationStatus = false,
        EnemyBossTypeClassification = true,
        EnemyFarmingLocationReference = workspace.Playability.Enemys["Fountain"]
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

function QuestManagementModuleContainer.GetQuestByLevel
