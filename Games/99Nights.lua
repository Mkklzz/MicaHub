repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui

local UnlockFramesPerSecondExecutionStatusVariable = false
local WalkSpeedModificationExecutionStatusVariable = false

local ToraLibraryInterfaceReference = loadstring(game:HttpGet("https://raw.githubusercontent.com/Mkklzz/MicaHub/Home/ToraLibrarySource.lua"))()
local MainWindowTabInterfaceContainer = ToraLibraryInterfaceReference:CreateWindow("99 Nights")

MainWindowTabInterfaceContainer:AddButton({
    text = "Walk Speed",
    flag = "button",
    callback = function()
        if WalkSpeedModificationExecutionStatusVariable then return end
        WalkSpeedModificationExecutionStatusVariable = true
        
        local RunServiceInstanceForWalkSpeed = game:GetService("RunService")
        
        local function MaintainWalkSpeedAtThirty()
            local LocalPlayerCharacterReference = game:GetService("Players").LocalPlayer.Character
            if LocalPlayerCharacterReference and LocalPlayerCharacterReference:FindFirstChild("Humanoid") then
                local PlayerCharacterHumanoidReference = LocalPlayerCharacterReference.Humanoid
                if PlayerCharacterHumanoidReference.WalkSpeed ~= 30 then
                    PlayerCharacterHumanoidReference.WalkSpeed = 30
                end
            end
        end
        
        RunServiceInstanceForWalkSpeed.Heartbeat:Connect(MaintainWalkSpeedAtThirty)
    end
})

MainWindowTabInterfaceContainer:AddButton({
    text = "Unlock Fps [BETA]",
    flag = "button",
    callback = function()
        if UnlockFramesPerSecondExecutionStatusVariable then return end
        UnlockFramesPerSecondExecutionStatusVariable = true
        
        local RunServiceInstanceReference = game:GetService("RunService")
        local WorkspaceInstanceReference = game:GetService("Workspace")
        local LightingServiceInstanceReference = game:GetService("Lighting")
        local ProcessedObjectsCacheStorageVariable = {}
        
        local function OptimizeWorkspaceObjectMaterialsAndTextures(WorkspaceObjectInstanceReference)
            pcall(function()
                if WorkspaceObjectInstanceReference:IsA("BasePart") then
                    WorkspaceObjectInstanceReference.Material = Enum.Material.Plastic
                elseif WorkspaceObjectInstanceReference:IsA("MeshPart") then
                    WorkspaceObjectInstanceReference.Material = Enum.Material.Plastic
                elseif WorkspaceObjectInstanceReference:IsA("UnionOperation") then
                    WorkspaceObjectInstanceReference.Material = Enum.Material.Plastic
                elseif WorkspaceObjectInstanceReference:IsA("Texture") then
                    WorkspaceObjectInstanceReference:Destroy()
                elseif WorkspaceObjectInstanceReference:IsA("Fire") or WorkspaceObjectInstanceReference:IsA("Smoke") or WorkspaceObjectInstanceReference:IsA("Sparkles") or WorkspaceObjectInstanceReference:IsA("ParticleEmitter") or WorkspaceObjectInstanceReference:IsA("Beam") or WorkspaceObjectInstanceReference:IsA("Trail") then
                    WorkspaceObjectInstanceReference.Enabled = false
                elseif WorkspaceObjectInstanceReference:IsA("Explosion") then
                    WorkspaceObjectInstanceReference:Destroy()
                end
            end)
        end
        
        local function OptimizeFoliageElementsAndItemsFolder()
            pcall(function()
                local MapFolderInstanceReference = WorkspaceInstanceReference:FindFirstChild("Map")
                if MapFolderInstanceReference then
                    local FoliageFolderInstanceReference = MapFolderInstanceReference:FindFirstChild("Foliage")
                    if FoliageFolderInstanceReference then
                        for _, FoliageModelInstanceReference in pairs(FoliageFolderInstanceReference:GetChildren()) do
                            if FoliageModelInstanceReference:IsA("Model") and FoliageModelInstanceReference.Name ~= "Small Tree" then
                                FoliageModelInstanceReference:Destroy()
                            end
                        end
                    end
                    
                    local LandmarksFolderInstanceReference = MapFolderInstanceReference:FindFirstChild("Landmarks")
                    if LandmarksFolderInstanceReference then
                        for _, LandmarkModelInstanceReference in pairs(LandmarksFolderInstanceReference:GetChildren()) do
                            if LandmarkModelInstanceReference:IsA("Model") and (LandmarkModelInstanceReference.Name == "Flower" or LandmarkModelInstanceReference.Name == "Berry Bush") then
                                LandmarkModelInstanceReference:Destroy()
                            elseif LandmarkModelInstanceReference:IsA("Model") and LandmarkModelInstanceReference.Name == "FlowerRing1" then
                                LandmarkModelInstanceReference:Destroy()
                            elseif LandmarkModelInstanceReference:IsA("Model") and LandmarkModelInstanceReference.Name == "Hollow Log" then
                                local Grass1Object = LandmarkModelInstanceReference:FindFirstChild("Grass1")
                                if Grass1Object then
                                    Grass1Object:Destroy()
                                end
                                local LogHollowMeshObject = LandmarkModelInstanceReference:FindFirstChild("Meshes/loghollow")
                                if LogHollowMeshObject then
                                    LogHollowMeshObject:Destroy()
                                end
                            elseif LandmarkModelInstanceReference:IsA("Model") and LandmarkModelInstanceReference.Name == "Bunny Burrow" then
                                for _, BunnyBurrowPartReference in pairs(LandmarkModelInstanceReference:GetChildren()) do
                                    if BunnyBurrowPartReference:IsA("BasePart") and BunnyBurrowPartReference.Name == "Main" then
                                        BunnyBurrowPartReference.Transparency = 1
                                    elseif BunnyBurrowPartReference:IsA("BasePart") and BunnyBurrowPartReference.Name ~= "Main" then
                                        BunnyBurrowPartReference:Destroy()
                                    end
                                end
                            end
                        end
                    end
                    
                    local BoundariesFolderInstanceReference = MapFolderInstanceReference:FindFirstChild("Boundaries")
                    if BoundariesFolderInstanceReference then
                        for _, BoundaryInstanceReference in pairs(BoundariesFolderInstanceReference:GetChildren()) do
                            if BoundaryInstanceReference.Name ~= "Fog" then
                                BoundaryInstanceReference:Destroy()
                            end
                        end
                    end
                end
                
                local ItemsFolderInstanceReference = WorkspaceInstanceReference:FindFirstChild("Items")
                if ItemsFolderInstanceReference then
                    for _, ItemModelInstanceReference in pairs(ItemsFolderInstanceReference:GetChildren()) do
                        if ItemModelInstanceReference:IsA("Model") and (ItemModelInstanceReference.Name == "Bolt" or ItemModelInstanceReference.Name == "Carrot" or ItemModelInstanceReference.Name == "Berry") then
                            ItemModelInstanceReference:Destroy()
                        end
                    end
                end
            end)
        end
        
        local function ExecuteInitialCompleteOptimizationProcess()
            OptimizeFoliageElementsAndItemsFolder()
            
            for _, WorkspaceObjectInstanceReference in pairs(WorkspaceInstanceReference:GetDescendants()) do
                OptimizeWorkspaceObjectMaterialsAndTextures(WorkspaceObjectInstanceReference)
                ProcessedObjectsCacheStorageVariable[WorkspaceObjectInstanceReference] = true
            end
            
            pcall(function()
                LightingServiceInstanceReference.Brightness = 5
                LightingServiceInstanceReference.GlobalShadows = false
                
                for _, LightingChildInstance in pairs(LightingServiceInstanceReference:GetChildren()) do
                    LightingChildInstance:Destroy()
                end
            end)
        end
        
        local function OptimizeNewlyCreatedWorkspaceObjects()
            OptimizeFoliageElementsAndItemsFolder()
            
            for _, WorkspaceObjectInstanceReference in pairs(WorkspaceInstanceReference:GetDescendants()) do
                if not ProcessedObjectsCacheStorageVariable[WorkspaceObjectInstanceReference] then
                    OptimizeWorkspaceObjectMaterialsAndTextures(WorkspaceObjectInstanceReference)
                    ProcessedObjectsCacheStorageVariable[WorkspaceObjectInstanceReference] = true
                end
            end
            
            pcall(function()
                LightingServiceInstanceReference.Brightness = 5
                LightingServiceInstanceReference.GlobalShadows = false
            end)
        end
        
        ExecuteInitialCompleteOptimizationProcess()
        RunServiceInstanceReference.Heartbeat:Connect(OptimizeNewlyCreatedWorkspaceObjects)
    end
})

MainWindowTabInterfaceContainer:AddLabel({
    text = "GitHub: Mkklzz",
    type = "label"
})

ToraLibraryInterfaceReference:Init()
