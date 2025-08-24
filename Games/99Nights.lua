repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui

local FramesPerSecondOptimizationSystemActivationStatusVariable = false
local PlayerMovementSpeedModificationSystemActivationStatusVariable = false
local InteractionCooldownRemovalSystemActivationStatusVariable = false

local ToraLibraryUserInterfaceSystemReference = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/ToraLibrarySource.lua"))()
local MainApplicationWindowContainerInterfaceReference = ToraLibraryUserInterfaceSystemReference:CreateWindow("99 Nights")

local function VerifyAllOptimizationSystemsActivationStatus()
    if FramesPerSecondOptimizationSystemActivationStatusVariable and PlayerMovementSpeedModificationSystemActivationStatusVariable and InteractionCooldownRemovalSystemActivationStatusVariable then
        pcall(function()
            if ToraLibraryUserInterfaceSystemReference and type(ToraLibraryUserInterfaceSystemReference.Close) == "function" then
                ToraLibraryUserInterfaceSystemReference:Close()
            end
        end)
    end
end

MainApplicationWindowContainerInterfaceReference:AddButton({
    text = "Remove Cooldowns",
    flag = "button",
    callback = function()
        if InteractionCooldownRemovalSystemActivationStatusVariable then return end
        InteractionCooldownRemovalSystemActivationStatusVariable = true
        
        local RunServiceInstanceForCooldownRemovalSystemReference = game:GetService("RunService")
        local WorkspaceInstanceForInteractionPromptOptimizationReference = game:GetService("Workspace")
        local ProcessedProximityPromptsTrackingCacheStorageSystem = {}
        local ProximityPromptProcessingThrottleControllerVariable = 0
        local MaximumProximityPromptsProcessedPerFrameCycleLimit = 50
        local PendingProximityPromptsProcessingQueueStorageArray = {}
        
        local function OptimizeProximityPromptHoldDurationConfiguration(ProximityPromptInstanceObjectReference)
            pcall(function()
                if ProximityPromptInstanceObjectReference and ProximityPromptInstanceObjectReference:IsA("ProximityPrompt") and ProximityPromptInstanceObjectReference.Parent then
                    ProximityPromptInstanceObjectReference.HoldDuration = 0
                end
            end)
        end
        
        local function ProcessInitialWorkspaceProximityPromptOptimization()
            for _, WorkspaceDescendantObjectReference in pairs(WorkspaceInstanceForInteractionPromptOptimizationReference:GetDescendants()) do
                if WorkspaceDescendantObjectReference:IsA("ProximityPrompt") then
                    table.insert(PendingProximityPromptsProcessingQueueStorageArray, WorkspaceDescendantObjectReference)
                end
            end
        end
        
        local function ProcessPendingProximityPromptOptimizationQueue()
            local ProcessedPromptsInCurrentFrameCycleCounter = 0
            local QueueArrayCurrentIndexPosition = 1
            
            while QueueArrayCurrentIndexPosition <= #PendingProximityPromptsProcessingQueueStorageArray and ProcessedPromptsInCurrentFrameCycleCounter < MaximumProximityPromptsProcessedPerFrameCycleLimit do
                local ProximityPromptInstanceReference = PendingProximityPromptsProcessingQueueStorageArray[QueueArrayCurrentIndexPosition]
                
                if ProximityPromptInstanceReference and ProximityPromptInstanceReference.Parent and not ProcessedProximityPromptsTrackingCacheStorageSystem[ProximityPromptInstanceReference] then
                    OptimizeProximityPromptHoldDurationConfiguration(ProximityPromptInstanceReference)
                    ProcessedProximityPromptsTrackingCacheStorageSystem[ProximityPromptInstanceReference] = true
                    ProcessedPromptsInCurrentFrameCycleCounter = ProcessedPromptsInCurrentFrameCycleCounter + 1
                end
                
                table.remove(PendingProximityPromptsProcessingQueueStorageArray, QueueArrayCurrentIndexPosition)
            end
        end
        
        local function HandleNewProximityPromptInstanceDetection(NewProximityPromptInstanceReference)
            if NewProximityPromptInstanceReference:IsA("ProximityPrompt") and not ProcessedProximityPromptsTrackingCacheStorageSystem[NewProximityPromptInstanceReference] then
                table.insert(PendingProximityPromptsProcessingQueueStorageArray, NewProximityPromptInstanceReference)
            end
        end
        
        local function HandleProximityPromptInstanceRemovalCleanup(RemovedProximityPromptInstanceReference)
            ProcessedProximityPromptsTrackingCacheStorageSystem[RemovedProximityPromptInstanceReference] = nil
        end
        
        ProcessInitialWorkspaceProximityPromptOptimization()
        
        WorkspaceInstanceForInteractionPromptOptimizationReference.DescendantAdded:Connect(HandleNewProximityPromptInstanceDetection)
        WorkspaceInstanceForInteractionPromptOptimizationReference.DescendantRemoving:Connect(HandleProximityPromptInstanceRemovalCleanup)
        
        RunServiceInstanceForCooldownRemovalSystemReference.Heartbeat:Connect(function()
            ProximityPromptProcessingThrottleControllerVariable = ProximityPromptProcessingThrottleControllerVariable + 1
            if ProximityPromptProcessingThrottleControllerVariable >= 8 then
                ProcessPendingProximityPromptOptimizationQueue()
                ProximityPromptProcessingThrottleControllerVariable = 0
            end
        end)
        
        VerifyAllOptimizationSystemsActivationStatus()
    end
})

MainApplicationWindowContainerInterfaceReference:AddButton({
    text = "Walk Speed",
    flag = "button",
    callback = function()
        if PlayerMovementSpeedModificationSystemActivationStatusVariable then return end
        PlayerMovementSpeedModificationSystemActivationStatusVariable = true
        
        local RunServiceInstanceForPlayerMovementOptimizationReference = game:GetService("RunService")
        local PlayersServiceInstanceForMovementControlReference = game:GetService("Players")
        local LocalPlayerInstanceForMovementModificationReference = PlayersServiceInstanceForMovementControlReference.LocalPlayer
        local PlayerMovementSpeedThrottleControllerVariable = 0
        local TargetPlayerCharacterMovementSpeedValue = 30
        
        local function ConfigurePlayerCharacterMovementSpeedOptimization()
            local LocalPlayerCharacterInstanceReference = LocalPlayerInstanceForMovementModificationReference.Character
            if LocalPlayerCharacterInstanceReference and LocalPlayerCharacterInstanceReference:FindFirstChild("Humanoid") then
                local PlayerCharacterHumanoidMovementControllerReference = LocalPlayerCharacterInstanceReference.Humanoid
                if PlayerCharacterHumanoidMovementControllerReference.WalkSpeed ~= TargetPlayerCharacterMovementSpeedValue then
                    PlayerCharacterHumanoidMovementControllerReference.WalkSpeed = TargetPlayerCharacterMovementSpeedValue
                end
            end
        end
        
        local function ConfigureMobileUserInterfaceSprintButtonVisibilityOptimization()
            pcall(function()
                local MobileUserInterfaceSprintButtonReference = LocalPlayerInstanceForMovementModificationReference.PlayerGui.MobileButtons.Frame.SprintButton
                if MobileUserInterfaceSprintButtonReference and MobileUserInterfaceSprintButtonReference.Visible then
                    MobileUserInterfaceSprintButtonReference.Visible = false
                end
            end)
        end
        
        RunServiceInstanceForPlayerMovementOptimizationReference.Heartbeat:Connect(function()
            PlayerMovementSpeedThrottleControllerVariable = PlayerMovementSpeedThrottleControllerVariable + 1
            if PlayerMovementSpeedThrottleControllerVariable >= 8 then
                ConfigurePlayerCharacterMovementSpeedOptimization()
                ConfigureMobileUserInterfaceSprintButtonVisibilityOptimization()
                PlayerMovementSpeedThrottleControllerVariable = 0
            end
        end)
        
        VerifyAllOptimizationSystemsActivationStatus()
    end
})

MainApplicationWindowContainerInterfaceReference:AddButton({
    text = "Unlock Fps [BETA]",
    flag = "button",
    callback = function()
        if FramesPerSecondOptimizationSystemActivationStatusVariable then return end
        FramesPerSecondOptimizationSystemActivationStatusVariable = true
        
        local RunServiceInstanceForGraphicalOptimizationReference = game:GetService("RunService")
        local WorkspaceInstanceForRenderingOptimizationReference = game:GetService("Workspace")
        local LightingServiceInstanceForVisualEffectsOptimizationReference = game:GetService("Lighting")
        
        local ProcessedWorkspaceObjectsOptimizationTrackingCacheSystem = {}
        local PendingWorkspaceObjectsOptimizationProcessingQueueArray = {}
        local GraphicalOptimizationProcessingThrottleControllerVariable = 0
        local MaximumWorkspaceObjectsProcessedPerFrameCycleLimit = 25
        local DestroyedObjectsCleanupThrottleControllerVariable = 0
        
        local function OptimizeWorkspaceObjectMaterialPropertiesAndVisualEffects(WorkspaceObjectInstanceReference)
            if not WorkspaceObjectInstanceReference or not WorkspaceObjectInstanceReference.Parent then
                return
            end
            
            pcall(function()
                if WorkspaceObjectInstanceReference:IsA("BasePart") or WorkspaceObjectInstanceReference:IsA("MeshPart") or WorkspaceObjectInstanceReference:IsA("UnionOperation") then
                    WorkspaceObjectInstanceReference.Material = Enum.Material.Plastic
                    WorkspaceObjectInstanceReference.Reflectance = 0
                elseif WorkspaceObjectInstanceReference:IsA("Texture") or WorkspaceObjectInstanceReference:IsA("Fire") or WorkspaceObjectInstanceReference:IsA("Smoke") or WorkspaceObjectInstanceReference:IsA("Sparkles") or WorkspaceObjectInstanceReference:IsA("ParticleEmitter") or WorkspaceObjectInstanceReference:IsA("Beam") or WorkspaceObjectInstanceReference:IsA("Trail") or WorkspaceObjectInstanceReference:IsA("Explosion") or WorkspaceObjectInstanceReference:IsA("PointLight") or WorkspaceObjectInstanceReference:IsA("SpotLight") or WorkspaceObjectInstanceReference:IsA("SurfaceLight") then
                    WorkspaceObjectInstanceReference:Destroy()
                end
            end)
        end
        
        local function ExecuteSpecializedMapElementsOptimizationProcess()
            pcall(function()
                local MainMapFolderInstanceReference = WorkspaceInstanceForRenderingOptimizationReference:FindFirstChild("Map")
                if not MainMapFolderInstanceReference then return end
                
                local FoliageElementsFolderInstanceReference = MainMapFolderInstanceReference:FindFirstChild("Foliage")
                if FoliageElementsFolderInstanceReference then
                    for _, FoliageModelInstanceReference in pairs(FoliageElementsFolderInstanceReference:GetChildren()) do
                        if FoliageModelInstanceReference:IsA("Model") and FoliageModelInstanceReference.Name ~= "Small Tree" then
                            FoliageModelInstanceReference:Destroy()
                        end
                    end
                end
                
                local LandmarksElementsFolderInstanceReference = MainMapFolderInstanceReference:FindFirstChild("Landmarks")
                if LandmarksElementsFolderInstanceReference then
                    for _, LandmarkModelInstanceReference in pairs(LandmarksElementsFolderInstanceReference:GetChildren()) do
                        if LandmarkModelInstanceReference:IsA("Model") then
                            if LandmarkModelInstanceReference.Name == "Flower" or LandmarkModelInstanceReference.Name == "Berry Bush" or LandmarkModelInstanceReference.Name == "FlowerRing1" then
                                LandmarkModelInstanceReference:Destroy()
                            elseif LandmarkModelInstanceReference.Name == "Hollow Log" then
                                local GrassElementReference = LandmarkModelInstanceReference:FindFirstChild("Grass1")
                                local LogHollowMeshReference = LandmarkModelInstanceReference:FindFirstChild("Meshes/loghollow")
                                if GrassElementReference then GrassElementReference:Destroy() end
                                if LogHollowMeshReference then LogHollowMeshReference:Destroy() end
                            elseif LandmarkModelInstanceReference.Name == "Bunny Burrow" then
                                for _, BurrowComponentReference in pairs(LandmarkModelInstanceReference:GetChildren()) do
                                    if BurrowComponentReference:IsA("BasePart") then
                                        if BurrowComponentReference.Name == "Main" then
                                            BurrowComponentReference.Transparency = 1
                                            BurrowComponentReference.Reflectance = 0
                                        else
                                            BurrowComponentReference:Destroy()
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                local BoundariesElementsFolderInstanceReference = MainMapFolderInstanceReference:FindFirstChild("Boundaries")
                if BoundariesElementsFolderInstanceReference then
                    for _, BoundaryElementInstanceReference in pairs(BoundariesElementsFolderInstanceReference:GetChildren()) do
                        if BoundaryElementInstanceReference.Name ~= "Fog" then
                            BoundaryElementInstanceReference:Destroy()
                        end
                    end
                end
                
                local ItemsElementsFolderInstanceReference = WorkspaceInstanceForRenderingOptimizationReference:FindFirstChild("Items")
                if ItemsElementsFolderInstanceReference then
                    for _, ItemModelInstanceReference in pairs(ItemsElementsFolderInstanceReference:GetChildren()) do
                        if ItemModelInstanceReference:IsA("Model") and (ItemModelInstanceReference.Name == "Bolt" or ItemModelInstanceReference.Name == "Carrot" or ItemModelInstanceReference.Name == "Berry") then
                            ItemModelInstanceReference:Destroy()
                        end
                    end
                end
            end)
        end
        
        local function ConfigureLightingServiceOptimizationSettings()
            pcall(function()
                LightingServiceInstanceForVisualEffectsOptimizationReference.Brightness = 5
                LightingServiceInstanceForVisualEffectsOptimizationReference.GlobalShadows = false
                LightingServiceInstanceForVisualEffectsOptimizationReference.FogStart = 0
                LightingServiceInstanceForVisualEffectsOptimizationReference.FogEnd = 100000
                LightingServiceInstanceForVisualEffectsOptimizationReference.EnvironmentSpecularScale = 0
                LightingServiceInstanceForVisualEffectsOptimizationReference.EnvironmentDiffuseScale = 0
                
                for _, LightingChildElementReference in pairs(LightingServiceInstanceForVisualEffectsOptimizationReference:GetChildren()) do
                    if LightingChildElementReference:IsA("PostEffect") or LightingChildElementReference:IsA("Atmosphere") then
                        LightingChildElementReference:Destroy()
                    end
                end
            end)
        end
        
        local function ProcessInitialWorkspaceOptimizationScan()
            ExecuteSpecializedMapElementsOptimizationProcess()
            ConfigureLightingServiceOptimizationSettings()
            
            for _, WorkspaceDescendantObjectReference in pairs(WorkspaceInstanceForRenderingOptimizationReference:GetDescendants()) do
                if WorkspaceDescendantObjectReference:IsA("BasePart") or WorkspaceDescendantObjectReference:IsA("MeshPart") or WorkspaceDescendantObjectReference:IsA("UnionOperation") or WorkspaceDescendantObjectReference:IsA("Texture") or WorkspaceDescendantObjectReference:IsA("Fire") or WorkspaceDescendantObjectReference:IsA("Smoke") or WorkspaceDescendantObjectReference:IsA("Sparkles") or WorkspaceDescendantObjectReference:IsA("ParticleEmitter") or WorkspaceDescendantObjectReference:IsA("Beam") or WorkspaceDescendantObjectReference:IsA("Trail") or WorkspaceDescendantObjectReference:IsA("Explosion") or WorkspaceDescendantObjectReference:IsA("PointLight") or WorkspaceDescendantObjectReference:IsA("SpotLight") or WorkspaceDescendantObjectReference:IsA("SurfaceLight") then
                    table.insert(PendingWorkspaceObjectsOptimizationProcessingQueueArray, WorkspaceDescendantObjectReference)
                end
            end
        end
        
        local function ProcessPendingWorkspaceObjectsOptimizationQueue()
            local ProcessedObjectsInCurrentFrameCycleCounter = 0
            local QueueArrayCurrentIndexPosition = 1
            
            while QueueArrayCurrentIndexPosition <= #PendingWorkspaceObjectsOptimizationProcessingQueueArray and ProcessedObjectsInCurrentFrameCycleCounter < MaximumWorkspaceObjectsProcessedPerFrameCycleLimit do
                local WorkspaceObjectInstanceReference = PendingWorkspaceObjectsOptimizationProcessingQueueArray[QueueArrayCurrentIndexPosition]
                
                if WorkspaceObjectInstanceReference and WorkspaceObjectInstanceReference.Parent and not ProcessedWorkspaceObjectsOptimizationTrackingCacheSystem[WorkspaceObjectInstanceReference] then
                    OptimizeWorkspaceObjectMaterialPropertiesAndVisualEffects(WorkspaceObjectInstanceReference)
                    ProcessedWorkspaceObjectsOptimizationTrackingCacheSystem[WorkspaceObjectInstanceReference] = true
                    ProcessedObjectsInCurrentFrameCycleCounter = ProcessedObjectsInCurrentFrameCycleCounter + 1
                end
                
                table.remove(PendingWorkspaceObjectsOptimizationProcessingQueueArray, QueueArrayCurrentIndexPosition)
            end
        end
        
        local function HandleNewWorkspaceObjectInstanceDetection(NewWorkspaceObjectInstanceReference)
            if (NewWorkspaceObjectInstanceReference:IsA("BasePart") or NewWorkspaceObjectInstanceReference:IsA("MeshPart") or NewWorkspaceObjectInstanceReference:IsA("UnionOperation") or NewWorkspaceObjectInstanceReference:IsA("Texture") or NewWorkspaceObjectInstanceReference:IsA("Fire") or NewWorkspaceObjectInstanceReference:IsA("Smoke") or NewWorkspaceObjectInstanceReference:IsA("Sparkles") or NewWorkspaceObjectInstanceReference:IsA("ParticleEmitter") or NewWorkspaceObjectInstanceReference:IsA("Beam") or NewWorkspaceObjectInstanceReference:IsA("Trail") or NewWorkspaceObjectInstanceReference:IsA("Explosion") or NewWorkspaceObjectInstanceReference:IsA("PointLight") or NewWorkspaceObjectInstanceReference:IsA("SpotLight") or NewWorkspaceObjectInstanceReference:IsA("SurfaceLight")) and not ProcessedWorkspaceObjectsOptimizationTrackingCacheSystem[NewWorkspaceObjectInstanceReference] then
                table.insert(PendingWorkspaceObjectsOptimizationProcessingQueueArray, NewWorkspaceObjectInstanceReference)
            end
        end
        
        local function HandleWorkspaceObjectInstanceRemovalCleanup(RemovedWorkspaceObjectInstanceReference)
            ProcessedWorkspaceObjectsOptimizationTrackingCacheSystem[RemovedWorkspaceObjectInstanceReference] = nil
        end
        
        local function PerformPeriodicCacheCleanupMaintenance()
            local ValidObjectsTrackingCacheSystem = {}
            for WorkspaceObjectReference, _ in pairs(ProcessedWorkspaceObjectsOptimizationTrackingCacheSystem) do
                if WorkspaceObjectReference and WorkspaceObjectReference.Parent then
                    ValidObjectsTrackingCacheSystem[WorkspaceObjectReference] = true
                end
            end
            ProcessedWorkspaceObjectsOptimizationTrackingCacheSystem = ValidObjectsTrackingCacheSystem
        end
        
        ProcessInitialWorkspaceOptimizationScan()
        
        WorkspaceInstanceForRenderingOptimizationReference.DescendantAdded:Connect(HandleNewWorkspaceObjectInstanceDetection)
        WorkspaceInstanceForRenderingOptimizationReference.DescendantRemoving:Connect(HandleWorkspaceObjectInstanceRemovalCleanup)
        
        RunServiceInstanceForGraphicalOptimizationReference.Heartbeat:Connect(function()
            GraphicalOptimizationProcessingThrottleControllerVariable = GraphicalOptimizationProcessingThrottleControllerVariable + 1
            DestroyedObjectsCleanupThrottleControllerVariable = DestroyedObjectsCleanupThrottleControllerVariable + 1
            
            if GraphicalOptimizationProcessingThrottleControllerVariable >= 8 then
                ProcessPendingWorkspaceObjectsOptimizationQueue()
                ConfigureLightingServiceOptimizationSettings()
                GraphicalOptimizationProcessingThrottleControllerVariable = 0
            end
            
            if DestroyedObjectsCleanupThrottleControllerVariable >= 300 then
                PerformPeriodicCacheCleanupMaintenance()
                DestroyedObjectsCleanupThrottleControllerVariable = 0
            end
        end)
        
        VerifyAllOptimizationSystemsActivationStatus()
    end
})

MainApplicationWindowContainerInterfaceReference:AddLabel({
    text = "GitHub: Mkklzz",
    type = "label"
})

ToraLibraryUserInterfaceSystemReference:Init()
