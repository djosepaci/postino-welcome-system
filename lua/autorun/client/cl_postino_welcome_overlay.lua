local draw = 0
local alpha = 1
local overlay_free = Material( "vgui/overlay_free.png","noclamp smooth" )
local overlay_premium = Material( "vgui/overlay_premium.png","noclamp smooth" )
local colorAlpha = ColorAlpha

local function readmsg()
	draw = net.ReadBool()
	surface.PlaySound("ui/welcome_postino/welcome".. math.random(1,6) ..".mp3")
end

hook.Add( "InitPostEntity", "FullyLoaded", function()
	net.Start( "PlayerFullyLoaded" )
    net.SendToServer()
end )

net.Receive("postino_welcome_overlay_draw",readmsg)

hook.Add( "HUDPaint", "postino_welcome_overlay", function()
	if draw then
		if (LocalPlayer():IsUserGroup("user") or LocalPlayer():IsUserGroup("regular") or LocalPlayer():IsUserGroup("operator") or LocalPlayer():IsUserGroup("admin")) then
			surface.SetMaterial( overlay_free ) -- Cache del materiale per poi chiamarlo, +ottimizzazione
		else
			surface.SetMaterial( overlay_premium )
		end
		
		surface.SetDrawColor(colorAlpha(color_white, alpha * 255))
		alpha = Lerp(RealFrameTime() * 0.3, alpha, 0)
		surface.DrawTexturedRect( ScrW()/5, ScrH()/13, ScrW()/1.6, ScrH()/1.27 )
		--surface.SetDrawColor( 255, 255, 255, 255 )
	end
end )