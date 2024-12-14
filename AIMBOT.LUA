local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local cam = workspace.CurrentCamera
local DIST_MAX = 30

-- Função para encontrar o jogador mais próximo
local function encontrarMaisProximo()
    local prox, menorDist = nil, math.huge
    for _, alvo in pairs(game.Players:GetPlayers()) do
        if alvo ~= player and alvo.Character then
            -- Verifica se o personagem do alvo tem o UpperTorso
            local torso = alvo.Character:FindFirstChild("UpperTorso") or alvo.Character:FindFirstChild("Torso")
            if torso then
                local dist = (torso.Position - char.HumanoidRootPart.Position).magnitude
                if dist < menorDist then
                    prox, menorDist = alvo, dist
                end
            end
        end
    end
    return prox
end

-- Atualiza a câmera para olhar para o jogador mais próximo
while task.wait(0.01) do
    local alvo = encontrarMaisProximo()
    if alvo then
        -- Seleciona a parte do torso do jogador mais próximo
        local torso = alvo.Character:FindFirstChild("UpperTorso") or alvo.Character:FindFirstChild("Torso")
        if torso and (torso.Position - char.HumanoidRootPart.Position).magnitude <= DIST_MAX then
            cam.CFrame = CFrame.lookAt(cam.CFrame.Position, torso.Position)
        end
    end
end
