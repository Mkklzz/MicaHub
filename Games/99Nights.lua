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
        
        local WorkspaceInstanceForInteractionPromptOptimizationReference = game:GetService("Workspace")
        
        local function OptimizeProximityPromptHoldDurationConfiguration(ProximityPromptInstanceObjectReference)
            pcall(function()
                if ProximityPromptInstanceObjectReference and ProximityPromptInstanceObjectReference:IsA("ProximityPrompt") and ProximityPromptInstanceObjectReference.Parent then
                    ProximityPromptInstanceObjectReference.HoldDuration = 0
                end
            end)
        end
        
        for _, WorkspaceDescendantObjectReference in pairs(WorkspaceInstanceForInteractionPromptOptimizationReference:GetDescendants()) do
            if WorkspaceDescendantObjectReference:IsA("ProximityPrompt") then
                OptimizeProximityPromptHoldDurationConfiguration(WorkspaceDescendantObjectReference)
            end
        end
        
        WorkspaceInstanceForInteractionPromptOptimizationReference.DescendantAdded:Connect(function(NewProximityPromptInstanceReference)
            if NewProximityPromptInstanceReference:IsA("ProximityPrompt") then
                OptimizeProximityPromptHoldDurationConfiguration(NewProximityPromptInstanceReference)
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
        local TargetPlayerCharacterMovementSpeedValue = 30
        
        local function ConfigurePlayerCharacterMovementSpeedOptimization()
            local LocalPlayerCharacterInstanceReference = LocalPlayerInstanceForMovementModificationReference.Character
            if LocalPlayerCharacterInstanceReference and LocalPlayerCharacterInstanceReference:FindFirstChild("Humanoid") then
                local PlayerCharacterHumanoidMovementControllerReference = LocalPlayerCharacterInstanceReference.Humanoid
                if PlayerCharacterHumanoidMovementControllerReference.WalkSpeed ~= TargetPlayerCharacterMovementSpeedValue then
                    PlayerCharacterHumanoidMovementControllerReference.WalkSpeed = TargetPlayerCharacterMovementSpeedValue
                end
            end
            
            pcall(function()
                local MobileUserInterfaceSprintButtonReference = LocalPlayerInstanceForMovementModificationReference.PlayerGui.MobileButtons.Frame.SprintButton
                if MobileUserInterfaceSprintButtonReference and MobileUserInterfaceSprintButtonReference.Visible then
                    MobileUserInterfaceSprintButtonReference.Visible = false
                end
            end)
        end
        
        RunServiceInstanceForPlayerMovementOptimizationReference.Heartbeat:Connect(ConfigurePlayerCharacterMovementSpeedOptimization)
        
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
        
        local function OptimizeAllWorkspaceElementsAndConfigurations(WorkspaceObjectInstanceReference)
            pcall(function()
                if WorkspaceObjectInstanceReference:IsA("BasePart") or WorkspaceObjectInstanceReference:IsA("MeshPart") or WorkspaceObjectInstanceReference:IsA("UnionOperation") then
                    WorkspaceObjectInstanceReference.Material = Enum.Material.Plastic
                    WorkspaceObjectInstanceReference.Reflectance = 0
                elseif WorkspaceObjectInstanceReference:IsA("Texture") or WorkspaceObjectInstanceReference:IsA("Fire") or WorkspaceObjectInstanceReference:IsA("Smoke") or WorkspaceObjectInstanceReference:IsA("Sparkles") or WorkspaceObjectInstanceReference:IsA("ParticleEmitter") or WorkspaceObjectInstanceReference:IsA("Beam") or WorkspaceObjectInstanceReference:IsA("Trail") or WorkspaceObjectInstanceReference:IsA("Explosion") or WorkspaceObjectInstanceReference:IsA("PointLight") or WorkspaceObjectInstanceReference:IsA("SpotLight") or WorkspaceObjectInstanceReference:IsA("SurfaceLight") then
                    WorkspaceObjectInstanceReference:Destroy()
                elseif WorkspaceObjectInstanceReference:IsA("Model") then
                    local ParentInstanceReference = WorkspaceObjectInstanceReference.Parent
                    if ParentInstanceReference then
                        local GrandParentInstanceReference = ParentInstanceReference.Parent
                        if GrandParentInstanceReference and GrandParentInstanceReference.Name == "Map" then
                            if ParentInstanceReference.Name == "Foliage" and WorkspaceObjectInstanceReference.Name ~= "Small Tree" then
                                WorkspaceObjectInstanceReference:Destroy()
                            elseif ParentInstanceReference.Name == "Landmarks" then
                                if WorkspaceObjectInstanceReference.Name == "Flower" or WorkspaceObjectInstanceReference.Name == "Berry Bush" or WorkspaceObjectInstanceReference.Name == "FlowerRing1" then
                                    WorkspaceObjectInstanceReference:Destroy()
                                elseif WorkspaceObjectInstanceReference.Name == "Hollow Log" then
                                    local GrassElementReference = WorkspaceObjectInstanceReference:FindFirstChild("Grass1")
                                    local LogHollowMeshReference = WorkspaceObjectInstanceReference:FindFirstChild("Meshes/loghollow")
                                    if GrassElementReference then GrassElementReference:Destroy() end
                                    if LogHollowMeshReference then LogHollowMeshReference:Destroy() end
                                elseif WorkspaceObjectInstanceReference.Name == "Bunny Burrow" then
                                    for _, BurrowComponentReference in pairs(WorkspaceObjectInstanceReference:GetChildren()) do
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
                            elseif ParentInstanceReference.Name == "Boundaries" and WorkspaceObjectInstanceReference.Name ~= "Fog" then
                                WorkspaceObjectInstanceReference:Destroy()
                            end
                        elseif ParentInstanceReference.Name == "Items" and (WorkspaceObjectInstanceReference.Name == "Bolt" or WorkspaceObjectInstanceReference.Name == "Carrot" or WorkspaceObjectInstanceReference.Name == "Berry") then
                            WorkspaceObjectInstanceReference:Destroy()
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
                    LightingChildElementReference:Destroy()
                end
            end)
        end
        
        ConfigureLightingServiceOptimizationSettings()
        
        for _, WorkspaceDescendantObjectReference in pairs(WorkspaceInstanceForRenderingOptimizationReference:GetDescendants()) do
            OptimizeAllWorkspaceElementsAndConfigurations(WorkspaceDescendantObjectReference)
        end
        
        WorkspaceInstanceForRenderingOptimizationReference.DescendantAdded:Connect(OptimizeAllWorkspaceElementsAndConfigurations)
        
        RunServiceInstanceForGraphicalOptimizationReference.Heartbeat:Connect(ConfigureLightingServiceOptimizationSettings)
        
        VerifyAllOptimizationSystemsActivationStatus()
    end
})

MainApplicationWindowContainerInterfaceReference:AddLabel({
    text = "GitHub: Mkklzz",
    type = "label"
})

ToraLibraryUserInterfaceSystemReference:Init()
