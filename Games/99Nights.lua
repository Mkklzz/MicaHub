repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer
repeat task.wait() until game:GetService("Players").LocalPlayer.Character
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
    text = "Unlock Optimization [BETA]",
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
