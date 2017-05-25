song = math.random(1,6)

util.AddNetworkString("postino_welcome_overlay_draw")
util.AddNetworkString( "PlayerFullyLoaded" )

net.Receive( "PlayerFullyLoaded", function( _, ply )
	if not ply.IsFullyLoaded then
		ply.IsFullyLoaded = true
		hook.Call( "PlayerFullyLoaded", GAMEMODE, ply )
	end
end )

local function spawnnetmsg(ply)
	net.Start("postino_welcome_overlay_draw")
	net.WriteBool(1)
	net.Send(ply)
	--ply:SendLua("surface.PlaySound('ui/welcome_postino/welcome".. song ..".mp3')")
end

hook.Add("PlayerFullyLoaded","postino_welcome_overlay_fullyloaded",spawnnetmsg)