SWEP.Base				= "tfa_ravager_base"
SWEP.Category				= "IX Warhammer 40000" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = "" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "Poor Quality Lagun" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "Poor Lasgun M36"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 3				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.

--[[WEAPON HANDLING]]--

sound.Add( {
	name = "tfa_lasshot2",
	channel = CHAN_STATIC,
	volume = 0.7,
	level = 70,
	pitch = { 95, 110 },
	sound = "weapons/las1.wav"
} )
sound.Add( {
	name = "tfa_lasshot1",
	channel = CHAN_STATIC,
	volume = 0.7,
	level = 70,
	pitch = { 150 },
	sound = "weapons/las1.wav"
} )

sound.Add( {
	name = "TFA_RAVAGER.ClipIn",
	channel = CHAN_USER_BASE+12,
	volume = 1.0,
	level = 80,
	pitch = { 95, 110 },
	sound = ")weapons/ravager/rifle_clip_in_1.wav"
} )

sound.Add( {
	name = "TFA_RAVAGER.ClipOut",
	channel = CHAN_USER_BASE+12,
	volume = 1.0,
	level = 80,
	pitch = { 95, 110 },
	sound = ")weapons/ravager/rifle_clip_out_1.wav"
} )

--Firing related
SWEP.Primary.Sound 			= Sound("tfa_lasshot2")					-- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound 			= nil				-- This is the sound of the weapon, when silenced.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage		= 75					-- Damage, in standard damage points.
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.DamageType = bit.bor(DMG_BULLET,DMG_AIRBOAT) --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.
SWEP.Primary.NumShots	= 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic			= false					-- Automatic/Semi Auto
SWEP.Primary.RPM				= 350					-- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi				= 350					-- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst				= nil					-- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.BurstDelay				= 0.003					-- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = false

SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?

-- Selective Fire Stuff

SWEP.SelectiveFire		= true --Allow selecting your firemode?
SWEP.DisableBurstFire	= false --Only auto/single?
SWEP.OnlyBurstFire		= false --No auto, only burst/single?
SWEP.DefaultFireMode 	= "semi" --Default to auto or whatev
SWEP.FireModeName = nil --Change to a text value to override it

SWEP.FireModes = {
	"Single",
	"3Burst",
}

--Ammo Related

SWEP.Primary.ClipSize			= 60					-- This is the size of a clip
SWEP.Primary.DefaultClip			= 240					-- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo			= "ar2"					-- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.DisableChambering = false --Disable round-in-the-chamber

--Recoil Related
SWEP.Primary.KickUp			= 0.5					-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown			= 0.5 					-- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal			= 0.2					-- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.1 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

--Firing Cone Related

SWEP.Primary.Spread		= .01					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .01	-- Ironsight accuracy, should be the same for shotguns

--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.

SWEP.Primary.SpreadMultiplierMax = 4.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1 / 1.5 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 4 --How much the spread recovers, per second.

--Range Related
SWEP.Primary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.


--Penetration Related

SWEP.Primary.MaxPenetration=4--The maximum number of ricochets.  To prevent stack overflows.

--Misc
SWEP.IronRecoilMultiplier=0.3 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchRecoilMultiplier=0.65  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.JumpRecoilMultiplier=1.3  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.WallRecoilMultiplier=1.1  --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.
SWEP.ChangeStateRecoilMultiplier=1.3  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier=0.5--Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
SWEP.ChangeStateAccuracyMultiplier=1.5 --Less is more.  A change of state is when we're in the progress of doing something, like crouching or ironsighting.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.JumpAccuracyMultiplier=2--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.WalkAccuracyMultiplier=1.35--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.IronSightTime = 0.3 --The time to enter ironsights/exit it.
SWEP.NearWallTime = 0.25 --The time to pull up  your weapon or put it back down
SWEP.ToCrouchTime = 0.05 --The time it takes to enter crouching state
SWEP.WeaponLength = 40 --Almost 3 feet Feet.  This should be how far the weapon sticks out from the player.  This is used for calculating the nearwall trace.
SWEP.MoveSpeed = 0.925 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.925*0.8 --Multiply the player's movespeed by this when sighting.
SWEP.SprintFOVOffset = 3.75 --Add this onto the FOV when we're sprinting.

--[[PROJECTILES]]--

SWEP.ProjectileEntity = nil --Entity to shoot
SWEP.ProjectileVelocity = 0 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model

--[[VIEWMODEL]]--

SWEP.ViewModel			= "models/hosti/m36_lasgun.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 75		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.MaterialTable = nil --Make sure the viewmodel and the worldmodel have the same material ids.  Next, fill this in with your desired submaterials.
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(3,0,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(-2,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.CameraOffset = Angle(0,0,0)

SWEP.VMBodyGroups = nil --{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}

--[[WORLDMODEL]]--

SWEP.WorldModel			= "models/hosti/w_m36_lasgun.mdl" -- Weapon world model path

SWEP.WMBodyGroups = nil--{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}

SWEP.HoldType 				= "ar2"		-- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up =  -3.1,
        Right = 1,
        Forward = -14,
        },
        Ang = {
        Up = -90,
        Right = -1,
        Forward = 176
        },
		Scale = 1
}

SWEP.ThirdPersonReloadDisable=false --Disable third person reload?  True disables.

--[[SCOPES]]--

SWEP.IronSightsSensitivity = 1--0.25 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction			= false  --Unscope/sight after you shoot?
SWEP.BoltAction_Forced			= false  --Unscope/sight after you shoot?
SWEP.Scoped				= false  --Draw a scope overlay?

SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.

SWEP.ScopeScale = 0.5 --Scale of the scope overlay
SWEP.ReticleScale = 0.7 --Scale of the reticle overlay

--GDCW Overlay Options.  Only choose one.

SWEP.Secondary.UseACOG			= false	 --Overlay option
SWEP.Secondary.UseMilDot			= false			 --Overlay option
SWEP.Secondary.UseSVD			= false		 --Overlay option
SWEP.Secondary.UseParabolic		= false		 --Overlay option
SWEP.Secondary.UseElcan			= false	 --Overlay option
SWEP.Secondary.UseGreenDuplex		= false		 --Overlay option

if surface then
	SWEP.Secondary.ScopeTable = nil --[[
		{
			scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
			reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
			dottex = surface.GetTextureID("scope/gdcw_acogcross")
		}
	]]--
end

--[[SHOTGUN CODE]]--

SWEP.Shotgun = false --Enable shotgun style reloading.

SWEP.ShellTime			= .35 -- For shotguns, how long it takes to insert a shell.

--[[SPRINTING]]--

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-11.869, 17.129, -16.056)
--[[IRONSIGHTS]]--

SWEP.data 				= {}
SWEP.data.ironsights			= 1 --Enable Ironsights
SWEP.Secondary.IronFOV			= 70					-- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

--[[INSPECTION]]--

--SWEP.InspectPos = Vector(0,0,0) --Replace with a vector, in style of ironsights position, to be used for inspection
--SWEP.InspectAng = Vector(0,0,0) --Replace with a vector, in style of ironsights angle, to be used for inspection

--[[VIEWMODEL ANIMATION HANDLING]]--

SWEP.ShootWhileDraw=false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw=false --Can you reload while draw anim plays?
SWEP.SightWhileDraw=false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster=true --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster=true --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster=false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload=true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting=false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall=false --Can you reload when close to a wall and facing it?
SWEP.SprintBobMult=1.5 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.
SWEP.IronBobMult=0  -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this < 1 for sighting, 0 to outright disable.
SWEP.IronBobMultWalk=0.2  -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this < 1 for sighting, 0 to outright disable.
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS!!!!11111oneONEELEVEN


--[[VIEWMODEL BLOWBACK]]--

SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0.03,-5,0.00) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = false --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false
SWEP.Blowback_Shell_Effect = ""


--[[VIEWMODEL PROCEDURAL ANIMATION]]--

SWEP.DoProceduralReload = false--Animate first person reload using lua?
SWEP.ProceduralReloadTime = 1 --Procedural reload time?

--[[HOLDTYPES]]--

SWEP.IronSightHoldTypeOverride=""  --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride=""  --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.

--[[ANIMATION]]--

SWEP.ForceDryFireOff = true --Disables dryfire.  Set to false to enable them.
SWEP.DisableIdleAnimations = false --Disables idle animations.  Set to false to enable them.
SWEP.ForceEmptyFireOff = true --Disables empty fire animations.  Set to false to enable them.

--If you really want, you can remove things from SWEP.actlist and manually enable animations and set their lengths.

SWEP.SequenceEnabled = {} --Self explanitory.  This can forcefully enable or disable a certain ACT_VM
SWEP.SequenceLength = {}  --This controls the length of a certain ACT_VM
SWEP.SequenceLengthOverride={

} --Override this if you want to change the length of a sequence but not the next idle

--[[EFFECTS]]--

--Muzzle Flash

SWEP.MuzzleAttachment			= "1" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
--SWEP.MuzzleAttachmentRaw = 1 --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.ShellAttachment			= "2" 		-- Should be "2" for CSS models or "shell" for hl2 models

SWEP.DoMuzzleFlash = true --Do a muzzle flash?
SWEP.CustomMuzzleFlash = true --Disable muzzle anim events and use our custom flashes?
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = "pele_muzzle" --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.

--Shell eject override

SWEP.LuaShellEject = false
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = "ShotgunShellEject" --Defaults to blowback

--Tracer Stuff

SWEP.Tracer				= 0		--Bullet tracer.  TracerName overrides this.
SWEP.TracerName 		= "thetalaser"	--Change to a string of your tracer name.  Can be custom.
								--There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 1 	--0 disables, otherwise, 1 in X chance


SWEP.TracerLua 			= false --Use lua effect, TFA Muzzle syntax.  Currently obsolete.
SWEP.TracerDelay		= 0.01 --Delay for lua tracer effect

--Impact Effects

SWEP.ImpactEffect = nil--Impact Effect
SWEP.ImpactDecal = nil--Impact Decal

--[[EVENT TABLE]]--

SWEP.EventTable = {} --Event Table, used for custom events when an action is played.  This can even do stuff like playing a pump animation after shooting.

--example:
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{
			['time'] = 0.4,
			['type'] = "sound",
			['value'] = Sound("TFA_RAVAGER.ClipOut")
		},
		{
			['time'] = 1.3,
			['type'] = "sound",
			['value'] = Sound("TFA_RAVAGER.ClipIn")
		}
	}
}


--[[RENDER TARGET]]--

SWEP.RTMaterialOverride = -1 -- Take the material you want out of



--[[AKIMBO]]--

SWEP.Akimbo = false --Akimbo gun?  Alternates between primary and secondary attacks.
SWEP.AnimCycle = 0 -- Start on the right

--[[TTT]]--

local gm = engine.ActiveGamemode()
if string.find(gm,"ttt") or string.find(gm,"terrorist") then
	SWEP.Kind = WEAPON_HEAVY
	SWEP.AutoSpawnable = false
	SWEP.AllowDrop = true
	SWEP.AmmoEnt = "item_ammo_smg1_ttt"
end


--[[MISC INFO FOR MODELERS]]--

--[[

Used Animations (for modelers):

ACT_VM_DRAW - Draw
ACT_VM_DRAW_EMPTY - Draw empty
ACT_VM_DRAW_SILENCED - Draw silenced, overrides empty

ACT_VM_IDLE - Idle
ACT_VM_IDLE_SILENCED - Idle empty, overwritten by silenced
ACT_VM_IDLE_SILENCED - Idle silenced

ACT_VM_PRIMARYATTACK - Shoot
ACT_VM_PRIMARYATTACK_EMPTY - Shoot last chambered bullet
ACT_VM_PRIMARYATTACK_SILENCED - Shoot silenced, overrides empty
ACT_VM_PRIMARYATTACK_1 - Shoot ironsights, overriden by everything besides normal shooting
ACT_VM_DRYFIRE - Dryfire

ACT_VM_RELOAD - Reload / Tactical Reload / Insert Shotgun Shell
ACT_SHOTGUN_RELOAD_START - Start shotgun reload, unless ACT_VM_RELOAD_EMPTY is there.
ACT_SHOTGUN_RELOAD_FINISH - End shotgun reload.
ACT_VM_RELOAD_EMPTY - Empty mag reload, chambers the new round.  Works for shotguns too, where applicable.
ACT_VM_RELOAD_SILENCED - Silenced reload, overwrites all


ACT_VM_HOLSTER - Holster
ACT_VM_HOLSTER_SILENCED - Holster empty, overwritten by silenced
ACT_VM_HOLSTER_SILENCED - Holster silenced

]]--

--[[Stuff you SHOULD NOT touch after this]]--

--Allowed VAnimations.  These are autodetected, so not really needed except as an extra precaution.  Do NOT change these, unless absolutely necessary.

SWEP.CanDrawAnimate=true
SWEP.CanDrawAnimateEmpty=false
SWEP.CanDrawAnimateSilenced=false
SWEP.CanHolsterAnimate=true
SWEP.CanHolsterAnimateEmpty=false
SWEP.CanIdleAnimate=true
SWEP.CanIdleAnimateEmpty=false
SWEP.CanIdleAnimateSilenced=false
SWEP.CanShootAnimate=true
SWEP.CanShootAnimateSilenced=false
SWEP.CanReloadAnimate=true
SWEP.CanReloadAnimateEmpty=false
SWEP.CanReloadAnimateSilenced=false
SWEP.CanDryFireAnimate=false
SWEP.CanDryFireAnimateSilenced=false
SWEP.CanSilencerAttachAnimate=false
SWEP.CanSilencerDetachAnimate=false

--Misc

SWEP.ShouldDrawAmmoHUD=false--THIS IS PROCEDURALLY CHANGED AND SHOULD NOT BE TWEAKED.  BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.DefaultFOV=90 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.

--Disable secondary crap

SWEP.Secondary.ClipSize			= 0					-- Size of a clip
SWEP.Secondary.DefaultClip			= 0					-- Default ammo to give...
SWEP.Secondary.Automatic			= false					-- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none" -- Self explanitory, ammo type.

--Convar support

SWEP.ConDamageMultiplier = 1

SWEP.Secondary.BashDamage = 95
SWEP.Secondary.BashDelay = 0.1


SWEP.RTMaterialOverride = -1

local cd = {}
local crosscol = Color(255, 255, 255, 255)
local rtmod = Color(255,0,0,4)
SWEP.RTOpaque = true

SWEP.RTCode = nil--[[ function(self, rt, scrw, scrh)
	if not IsValid(self.Owner) then return end
	local wcol = self.Owner:GetWeaponColor()
	rtmod.r = wcol.x * 255
	rtmod.g = wcol.y * 255
	rtmod.b = wcol.z * 255
	if not self.myreticule then
		self.myreticule = Material(self.ScopeReticule and self.ScopeReticule or "scope/gdcw_scopesightonly")
	end

	local vm = self.Owner:GetViewModel()

	if not self.LastOwnerPos then
		self.LastOwnerPos = self.Owner:GetShootPos()
	end

	local owoff = self.Owner:GetShootPos() - self.LastOwnerPos
	self.LastOwnerPos = self.Owner:GetShootPos()
	render.OverrideAlphaWriteEnable(true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-512, -512, 1024, 1024)
	render.OverrideAlphaWriteEnable(true, true)
	local ang = self.Owner:EyeAngles()
	cd.angles = ang
	cd.origin = self.Owner:GetShootPos()
	local rtw, rth = 512, 512
	cd.x = 0
	cd.y = 0
	cd.w = rtw
	cd.h = rth
	cd.fov = 5
	cd.drawviewmodel = false
	cd.drawhud = false
	render.Clear(0, 0, 0, 255, true, true)
	render.SetScissorRect(0, 0, rtw, rth, true)

	if self.CLIronSightsProgress > 0.005 then
		render.RenderView(cd)
	end

	render.SetScissorRect(0, 0, rtw, rth, false)
	render.OverrideAlphaWriteEnable(false, true)
	cam.Start2D()
	draw.NoTexture()
	surface.SetDrawColor(ColorAlpha(color_black, 255 * (1 - self.CLIronSightsProgress)))
	surface.DrawRect(0, 0, rtw, rth)
	surface.SetMaterial(self.myreticule)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRect(128, 128, 256, 256)
	surface.SetDrawColor(rtmod)
	surface.DrawRect(0, 0, 512, 512)
	cam.End2D()
end
]]--

SWEP.Attachments = {
	[6] = {
		header = "Bayonet",
		offset = {0, 0},
		atts = {"ravager_bayo"},
		sel = 1
	}
}

SWEP.AttachmentExclusions = {
}



SWEP.IronSightsPos = Vector(-3.58, -6.633, 2.539) - SWEP.VMPos
SWEP.IronSightsAng = Vector(-2, -0.491, 0)- SWEP.VMAng




SWEP.Secondary.CanBash = false