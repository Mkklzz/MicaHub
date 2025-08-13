OthersTabContainerReference:AddButton({Title = "Teleport to Location [BETA]", Description = "Teleport to Selected Island", Callback = function()
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
