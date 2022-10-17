repeat wait() until game:IsLoaded()
syn.queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/Idktbh12z/DWCrasher/main/zz.lua", true))()]])
local trees = false
print("executed")
for _,v in pairs(game.Workspace:GetDescendants()) do
	if v.Name == "Interact" and v.Parent.Name == "Leaf" then
		trees = true
		---
		local ServerScriptService = game:GetService("ServerScriptService")
		local SoundService = game:GetService("SoundService")
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://261082034" -- Will play a notification song when it finds, you can change if u want just change the id.
		SoundService:PlayLocalSound(sound)
		----
		local BillboardGui = Instance.new("BillboardGui") --UI
		local TextLabel = Instance.new("TextLabel")
		BillboardGui.Parent = v.Parent
		BillboardGui.AlwaysOnTop = true
		BillboardGui.LightInfluence = 1
		BillboardGui.Size = UDim2.new(0, 50, 0, 50)
		BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
 
		TextLabel.Parent = BillboardGui
		TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderColor3 = Color3.new(27, 42, 53)
		TextLabel.BorderSizePixel = 0
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.TextStrokeTransparency = -0.010
		TextLabel.Text = "Purple tree here"
		TextLabel.TextColor3 = Color3.fromRGB(107, 38, 255)
		TextLabel.TextScaled = true
	end
end

if not trees then --Server Hopper
	while trees == false do
		wait(1) -- Decrease for fast hopping, recommended between 10-20
		print("Hopping, if hop fails just wait.")
		local Player = game.Players.LocalPlayer
		local Http = game:GetService("HttpService")
		local TPS = game:GetService("TeleportService")
		local Api = "https://games.roblox.com/v1/games/"
 
		local _place,_id = game.PlaceId, game.JobId
		local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
		function ListServers(cursor)
			local wasitdone = false
			repeat
				local s,r = pcall(function() return game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or "")) end)
				if s then
				    wasitdone = true
					return Http:JSONDecode(r)
				end
				wait(1)
			until wasitdone
		end
		local Next
		repeat
			local Servers = ListServers(Next)
			for i,v in pairs(Servers.data) do
				if v.playing < v.maxPlayers and v.id ~= _id and Next then
					local s,r = pcall(function() return TPS:TeleportToPlaceInstance(_place,v.id,Player) end)
					if s then Next = false end
				end
			end
			Next = Servers.nextPageCursor
		until not Next
	end
end
