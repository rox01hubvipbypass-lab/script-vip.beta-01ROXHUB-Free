local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--=============================================================
--// INTRO PRO \\--
--=============================================================
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "IntroLoading"
IntroGui.ResetOnSpawn = false
IntroGui.IgnoreGuiInset = true
IntroGui.DisplayOrder = 999
IntroGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
IntroGui.Parent = PlayerGui

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1,0,1,0)
Background.Position = UDim2.new(0,0,0,0)
Background.ZIndex = 10
Background.BackgroundColor3 = Color3.fromRGB(0,0,0)
Background.BorderSizePixel = 0
Background.Parent = IntroGui

local BgGradient = Instance.new("UIGradient")
BgGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10,10,20)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
}
BgGradient.Rotation = 45
BgGradient.Parent = Background

local Sound = nil
local Duration = 20

do
	local url = "https://www.image2url.com/r2/default/audio/1790665820601-6376e214-46f4-4da2-bf07-a612cda80c3a.mp3"
	local fileName = "intro_musica.mp3"
	local success, response = pcall(function() return game:HttpGet(url) end)
	if success then
		pcall(function()
			writefile(fileName, response)
			local assetPath = getcustomasset(fileName)
			Sound = Instance.new("Sound")
			Sound.SoundId = assetPath
			Sound.Volume = 7
			Sound.Looped = false
			Sound.Parent = workspace.CurrentCamera
		end)
	end
end

if Sound then
	local timeout = 0
	while not Sound.IsLoaded and timeout < 10 do
		task.wait(0.1)
		timeout = timeout + 0.1
	end
	if Sound.IsLoaded then
		Duration = Sound.TimeLength
	end
end

task.spawn(function()
	while Background.Parent do
		local ring = Instance.new("Frame")
		ring.Size = UDim2.new(0, 80, 0, 80)
		ring.Position = UDim2.new(0.5, -40, 0.42, -40)
		ring.BackgroundTransparency = 1
		ring.ZIndex = 11
		ring.Parent = Background

		local ringCorner = Instance.new("UICorner")
		ringCorner.CornerRadius = UDim.new(1, 0)
		ringCorner.Parent = ring

		local ringStroke = Instance.new("UIStroke")
		ringStroke.Color = Color3.fromRGB(255, 255, 255)
		ringStroke.Thickness = 2
		ringStroke.Transparency = 0.2
		ringStroke.Parent = ring

		TweenService:Create(ring, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 400, 0, 400),
			Position = UDim2.new(0.5, -200, 0.42, -200)
		}):Play()
		TweenService:Create(ringStroke, TweenInfo.new(2.5), {
			Transparency = 1, Thickness = 0
		}):Play()

		task.wait(0.8)
		task.spawn(function() task.wait(2.5) ring:Destroy() end)
	end
end)

task.spawn(function()
	while Background.Parent do
		local scan = Instance.new("Frame")
		scan.Size = UDim2.new(1, 0, 0, 1)
		scan.Position = UDim2.new(0, 0, 0, 0)
		scan.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		scan.BackgroundTransparency = 0.7
		scan.BorderSizePixel = 0
		scan.ZIndex = 11
		scan.Parent = Background

		local scanGradient = Instance.new("UIGradient")
		scanGradient.Transparency = NumberSequence.new{
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 1)
		}
		scanGradient.Parent = scan

		local tween = TweenService:Create(scan, TweenInfo.new(2, Enum.EasingStyle.Linear), {
			Position = UDim2.new(0, 0, 1, 0)
		})
		tween:Play()
		tween.Completed:Wait()
		scan:Destroy()
		task.wait(1.5)
	end
end)

local GridHolder = Instance.new("Frame")
GridHolder.Size = UDim2.new(1, 0, 1, 0)
GridHolder.BackgroundTransparency = 1
GridHolder.ZIndex = 10
GridHolder.Parent = Background

for i = 0, 30 do
	local vline = Instance.new("Frame")
	vline.Size = UDim2.new(0, 1, 1, 0)
	vline.Position = UDim2.new(i/30, 0, 0, 0)
	vline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	vline.BackgroundTransparency = 0.94
	vline.BorderSizePixel = 0
	vline.ZIndex = 10
	vline.Parent = GridHolder
end

for i = 0, 20 do
	local hline = Instance.new("Frame")
	hline.Size = UDim2.new(1, 0, 0, 1)
	hline.Position = UDim2.new(0, 0, i/20, 0)
	hline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	hline.BackgroundTransparency = 0.94
	hline.BorderSizePixel = 0
	hline.ZIndex = 10
	hline.Parent = GridHolder
end

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0,160,0,160)
Logo.Position = UDim2.new(0.5,-80,0.42,-80)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://112454650572091"
Logo.ZIndex = 12
Logo.Parent = Background

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = Logo

task.spawn(function()
	while Logo.Parent do
		TweenService:Create(Logo, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = UDim2.new(0,168,0,168),
			Position = UDim2.new(0.5,-84,0.42,-84)
		}):Play()
		task.wait(1.2)
		if not Logo.Parent then break end
		TweenService:Create(Logo, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = UDim2.new(0,160,0,160),
			Position = UDim2.new(0.5,-80,0.42,-80)
		}):Play()
		task.wait(1.2)
	end
end)

Logo.ImageTransparency = 1
TweenService:Create(Logo, TweenInfo.new(1), {ImageTransparency = 0}):Play()

local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.new(0,320,0,5)
BarBG.Position = UDim2.new(0.5,-160,0.68,0)
BarBG.BackgroundColor3 = Color3.fromRGB(25,25,35)
BarBG.BorderSizePixel = 0
BarBG.ZIndex = 12
BarBG.Parent = Background

local BarBGCorner = Instance.new("UICorner")
BarBGCorner.CornerRadius = UDim.new(1,0)
BarBGCorner.Parent = BarBG

local BarBGStroke = Instance.new("UIStroke")
BarBGStroke.Color = Color3.fromRGB(60,60,80)
BarBGStroke.Thickness = 1
BarBGStroke.Transparency = 0.5
BarBGStroke.Parent = BarBG

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Bar.BorderSizePixel = 0
Bar.ZIndex = 13
Bar.Parent = BarBG

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1,0)
BarCorner.Parent = Bar

local BarGlow = Instance.new("ImageLabel")
BarGlow.Size = UDim2.new(1,0,3,0)
BarGlow.Position = UDim2.new(0,0,-1,0)
BarGlow.BackgroundTransparency = 1
BarGlow.Image = "rbxassetid://5028857084"
BarGlow.ImageColor3 = Color3.fromRGB(255, 255, 255)
BarGlow.ImageTransparency = 0.4
BarGlow.ZIndex = 12
BarGlow.Parent = Bar

local Percent = Instance.new("TextLabel")
Percent.Size = UDim2.new(1,0,0,20)
Percent.Position = UDim2.new(0,0,0.71,0)
Percent.BackgroundTransparency = 1
Percent.Text = "0%"
Percent.TextColor3 = Color3.fromRGB(255,255,255)
Percent.TextSize = 13
Percent.Font = Enum.Font.GothamBold
Percent.ZIndex = 12
Percent.Parent = Background

if Sound then Sound:Play() end

task.spawn(function()
	local total = Duration
	local elapsed = 0
	while elapsed < total and Bar.Parent do
		elapsed = elapsed + 0.05
		local percent = math.clamp(elapsed/total, 0, 1)
		Bar.Size = UDim2.new(percent, 0, 1, 0)
		Percent.Text = math.floor(percent*100) .. "%"
		task.wait(0.05)
	end
	if Bar.Parent then
		Bar.Size = UDim2.new(1,0,1,0)
		Percent.Text = "85%"
	end
end)

if Sound then Sound.Ended:Wait() else task.wait(Duration) end

if Bar.Parent then
	Bar.Size = UDim2.new(1,0,1,0)
	Percent.Text = "85%"
	task.wait(0.5)
end

local fade = TweenService:Create(Background, TweenInfo.new(0.6), {BackgroundTransparency = 1})
fade:Play()
fade.Completed:Wait()
IntroGui:Destroy()

--=============================================================
--// PRINCIPAL \\--
--=============================================================
local function LoadHub()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "01ROXHUB"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = PlayerGui

	-- Paleta
	local C_BG          = Color3.fromRGB(18, 20, 28)
	local C_BG_TOP      = Color3.fromRGB(12, 14, 20)
	local C_SIDEBAR     = Color3.fromRGB(14, 16, 24)
	local C_CONTENT     = Color3.fromRGB(20, 22, 30)
	local C_BOX         = Color3.fromRGB(30, 33, 44)
	local C_BOX_2       = Color3.fromRGB(24, 27, 35)
	local C_TEXT        = Color3.fromRGB(255, 255, 255)
	local C_TEXT_DIM    = Color3.fromRGB(150, 158, 175)
	local C_ACCENT      = Color3.fromRGB(0, 140, 255)
	local C_ACCENT_SOFT = Color3.fromRGB(0, 100, 210)
	local C_DIVIDER     = Color3.fromRGB(45, 50, 65)
	local C_RED         = Color3.fromRGB(200, 45, 50)
	local C_RED_HOVER   = Color3.fromRGB(230, 60, 65)
	local C_GOLD        = Color3.fromRGB(235, 200, 90)
	local C_GREEN       = Color3.fromRGB(80, 210, 100)
	local C_GREEN_DARK  = Color3.fromRGB(22, 40, 28)
	local C_LINK        = Color3.fromRGB(120, 180, 255)
	local C_DISCORD     = Color3.fromRGB(88, 101, 242)
	local C_DISCORD_H   = Color3.fromRGB(110, 122, 255)
	local C_WHITE       = Color3.fromRGB(255, 255, 255)

	local DISCORD_URL = "https://discord.gg/mWBffStfJ"

	--=========================================================
	-- BOTÓN FLOTANTE
	--=========================================================
	local MainButton = Instance.new("ImageButton")
	MainButton.Name = "MainButton"
	MainButton.Size = UDim2.new(0, 50, 0, 50)
	MainButton.Position = UDim2.new(0.5, -25, 0.5, -25)
	MainButton.BackgroundColor3 = C_BG_TOP
	MainButton.BorderSizePixel = 0
	MainButton.Image = "rbxassetid://76111147434526"
	MainButton.ScaleType = Enum.ScaleType.Fit
	MainButton.Active = true
	MainButton.Draggable = true
	MainButton.Parent = ScreenGui

	local MainBtnCorner = Instance.new("UICorner")
	MainBtnCorner.CornerRadius = UDim.new(0, 10)
	MainBtnCorner.Parent = MainButton

	local MainBtnPad = Instance.new("UIPadding")
	MainBtnPad.PaddingTop = UDim.new(0, 6)
	MainBtnPad.PaddingBottom = UDim.new(0, 6)
	MainBtnPad.PaddingLeft = UDim.new(0, 6)
	MainBtnPad.PaddingRight = UDim.new(0, 6)
	MainBtnPad.Parent = MainButton

	local MainBtnStroke = Instance.new("UIStroke")
	MainBtnStroke.Color = Color3.fromRGB(255, 255, 255)
	MainBtnStroke.Thickness = 1
	MainBtnStroke.Transparency = 0.3
	MainBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	MainBtnStroke.Parent = MainButton

	local PulseRing = Instance.new("Frame")
	PulseRing.Size = UDim2.new(1, 0, 1, 0)
	PulseRing.Position = UDim2.new(0, 0, 0, 0)
	PulseRing.BackgroundTransparency = 1
	PulseRing.ZIndex = 0
	PulseRing.Parent = MainButton

	local PulseRingCorner = Instance.new("UICorner")
	PulseRingCorner.CornerRadius = UDim.new(0, 10)
	PulseRingCorner.Parent = PulseRing

	local PulseRingStroke = Instance.new("UIStroke")
	PulseRingStroke.Color = Color3.fromRGB(255, 255, 255)
	PulseRingStroke.Thickness = 2
	PulseRingStroke.Transparency = 0.2
	PulseRingStroke.Parent = PulseRing

	task.spawn(function()
		while MainButton.Parent do
			PulseRing.Size = UDim2.new(1, 0, 1, 0)
			PulseRing.Position = UDim2.new(0, 0, 0, 0)
			PulseRingStroke.Transparency = 0.2
			TweenService:Create(PulseRing, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, 40, 1, 40),
				Position = UDim2.new(0, -20, 0, -20)
			}):Play()
			TweenService:Create(PulseRingStroke, TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1, Thickness = 0
			}):Play()
			task.wait(1.6)
		end
	end)

	task.spawn(function()
		while MainButton.Parent do
			TweenService:Create(MainBtnStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Transparency = 0.05, Thickness = 2
			}):Play()
			task.wait(1.2)
			if not MainButton.Parent then break end
			TweenService:Create(MainBtnStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Transparency = 0.4, Thickness = 1
			}):Play()
			task.wait(1.2)
		end
	end)

	--=========================================================
	-- FRAME PRINCIPAL
	--=========================================================
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 560, 0, 340)
	MainFrame.Position = UDim2.new(0.5, -280, 0.5, -170)
	MainFrame.BackgroundColor3 = C_BG
	MainFrame.BorderSizePixel = 0
	MainFrame.Visible = false
	MainFrame.Active = true
	MainFrame.Draggable = true
	MainFrame.ClipsDescendants = true
	MainFrame.Parent = ScreenGui

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 12)
	MainCorner.Parent = MainFrame

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = C_ACCENT
	MainStroke.Thickness = 1
	MainStroke.Transparency = 0.55
	MainStroke.Parent = MainFrame

	-- FONDO CON IMAGEN
	local MenuBgImage = Instance.new("ImageLabel")
	MenuBgImage.Name = "MenuBackground"
	MenuBgImage.Size = UDim2.new(1, 0, 1, 0)
	MenuBgImage.Position = UDim2.new(0, 0, 0, 0)
	MenuBgImage.BackgroundTransparency = 1
	MenuBgImage.Image = "rbxassetid://120887660443421"
	MenuBgImage.ScaleType = Enum.ScaleType.Crop
	MenuBgImage.ImageTransparency = 0.35
	MenuBgImage.ZIndex = 0
	MenuBgImage.Parent = MainFrame

	local MenuBgCorner = Instance.new("UICorner")
	MenuBgCorner.CornerRadius = UDim.new(0, 12)
	MenuBgCorner.Parent = MenuBgImage

	local MainShadow = Instance.new("ImageLabel")
	MainShadow.Size = UDim2.new(1, 40, 1, 40)
	MainShadow.Position = UDim2.new(0, -20, 0, -20)
	MainShadow.BackgroundTransparency = 1
	MainShadow.Image = "rbxassetid://5028857084"
	MainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	MainShadow.ImageTransparency = 0.4
	MainShadow.ScaleType = Enum.ScaleType.Slice
	MainShadow.SliceCenter = Rect.new(24, 24, 276, 276)
	MainShadow.ZIndex = 0
	MainShadow.Parent = MainFrame

	local ParticleHolder = Instance.new("Frame")
	ParticleHolder.Size = UDim2.new(1, 0, 1, 0)
	ParticleHolder.BackgroundTransparency = 1
	ParticleHolder.BorderSizePixel = 0
	ParticleHolder.ZIndex = 0
	ParticleHolder.ClipsDescendants = true
	ParticleHolder.Parent = MainFrame

	local function CreateParticle()
		local particle = Instance.new("Frame")
		local size = math.random(1, 2)
		particle.Size = UDim2.new(0, size, 0, size)
		particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
		particle.BackgroundColor3 = C_ACCENT
		particle.BackgroundTransparency = math.random(50, 80) / 100
		particle.BorderSizePixel = 0
		particle.ZIndex = 0
		particle.Parent = ParticleHolder

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = particle

		spawn(function()
			local speed = math.random(15, 35) / 1000
			while particle.Parent do
				particle.Position = particle.Position + UDim2.new(0, 0, speed, 0)
				if particle.Position.Y.Scale > 1 then
					particle.Position = UDim2.new(math.random(), 0, -0.05, 0)
				end
				RunService.Heartbeat:Wait()
			end
		end)
	end

	for i = 1, 70 do CreateParticle() end

	--=========================================================
	-- TOP BAR
	--=========================================================
	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 42)
	TopBar.BackgroundColor3 = C_BG_TOP
	TopBar.BackgroundTransparency = 0.15
	TopBar.BorderSizePixel = 0
	TopBar.ZIndex = 2
	TopBar.Parent = MainFrame

	local TopCorner = Instance.new("UICorner")
	TopCorner.CornerRadius = UDim.new(0, 12)
	TopCorner.Parent = TopBar

	local TopFix = Instance.new("Frame")
	TopFix.Size = UDim2.new(1, 0, 0, 12)
	TopFix.Position = UDim2.new(0, 0, 1, -12)
	TopFix.BackgroundColor3 = C_BG_TOP
	TopFix.BackgroundTransparency = 0.15
	TopFix.BorderSizePixel = 0
	TopFix.ZIndex = 3
	TopFix.Parent = TopBar

	local TopAccent = Instance.new("Frame")
	TopAccent.Size = UDim2.new(1, 0, 0, 2)
	TopAccent.Position = UDim2.new(0, 0, 1, -2)
	TopAccent.BackgroundColor3 = C_ACCENT
	TopAccent.BorderSizePixel = 0
	TopAccent.ZIndex = 4
	TopAccent.Parent = TopBar

	local TopAccentGradient = Instance.new("UIGradient")
	TopAccentGradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(1, 1)
	}
	TopAccentGradient.Parent = TopAccent

	local TopLogo = Instance.new("ImageLabel")
	TopLogo.Size = UDim2.new(0, 26, 0, 26)
	TopLogo.Position = UDim2.new(0, 14, 0, 8)
	TopLogo.BackgroundTransparency = 1
	TopLogo.Image = "rbxassetid://76111147434526"
	TopLogo.ScaleType = Enum.ScaleType.Fit
	TopLogo.ZIndex = 5
	TopLogo.Parent = TopBar

	local TopLogoCorner = Instance.new("UICorner")
	TopLogoCorner.CornerRadius = UDim.new(0, 6)
	TopLogoCorner.Parent = TopLogo

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -120, 1, 0)
	Title.Position = UDim2.new(0, 48, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = "MYSTERY VS SHERIFF DUELOS"
	Title.TextColor3 = C_TEXT
	Title.TextSize = 13
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 5
	Title.Parent = TopBar

	local TitleAccent = Instance.new("TextLabel")
	TitleAccent.Size = UDim2.new(0, 90, 1, 0)
	TitleAccent.Position = UDim2.new(0, 232, 0, 0)
	TitleAccent.BackgroundTransparency = 1
	TitleAccent.Text = "• FREE BETA"
	TitleAccent.TextColor3 = C_ACCENT
	TitleAccent.TextSize = 12
	TitleAccent.Font = Enum.Font.GothamBold
	TitleAccent.TextXAlignment = Enum.TextXAlignment.Left
	TitleAccent.ZIndex = 5
	TitleAccent.Parent = TopBar

	local BtnSize = 28
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, BtnSize, 0, BtnSize)
	CloseBtn.Position = UDim2.new(1, -(BtnSize + 10), 0, 7)
	CloseBtn.BackgroundColor3 = C_RED
	CloseBtn.BorderSizePixel = 0
	CloseBtn.Text = "✕"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.TextSize = 14
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.AutoButtonColor = false
	CloseBtn.ZIndex = 5
	CloseBtn.Parent = TopBar

	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 8)
	CloseCorner.Parent = CloseBtn

	local CloseStroke = Instance.new("UIStroke")
	CloseStroke.Color = Color3.fromRGB(255, 200, 200)
	CloseStroke.Thickness = 1
	CloseStroke.Transparency = 0.5
	CloseStroke.Parent = CloseBtn

	CloseBtn.MouseEnter:Connect(function()
		TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = C_RED_HOVER}):Play()
	end)
	CloseBtn.MouseLeave:Connect(function()
		TweenService:Create(CloseBtn, TweenInfo.new(0.15), {BackgroundColor3 = C_RED}):Play()
	end)

	--=========================================================
	-- SIDEBAR
	--=========================================================
	local SideMenu = Instance.new("ScrollingFrame")
	SideMenu.Size = UDim2.new(0, 160, 1, -42)
	SideMenu.Position = UDim2.new(0, 0, 0, 42)
	SideMenu.BackgroundColor3 = C_SIDEBAR
	SideMenu.BackgroundTransparency = 0.25
	SideMenu.BorderSizePixel = 0
	SideMenu.ScrollBarThickness = 2
	SideMenu.ScrollBarImageColor3 = C_ACCENT
	SideMenu.CanvasSize = UDim2.new(0, 0, 0, 0)
	SideMenu.ClipsDescendants = true
	SideMenu.ScrollBarImageTransparency = 0.5
	SideMenu.ZIndex = 1
	SideMenu.Parent = MainFrame

	local SideList = Instance.new("UIListLayout")
	SideList.Padding = UDim.new(0, 3)
	SideList.SortOrder = Enum.SortOrder.LayoutOrder
	SideList.Parent = SideMenu

	local SidePad = Instance.new("UIPadding")
	SidePad.PaddingTop = UDim.new(0, 8)
	SidePad.PaddingBottom = UDim.new(0, 8)
	SidePad.Parent = SideMenu

	SideList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		SideMenu.CanvasSize = UDim2.new(0, 0, 0, SideList.AbsoluteContentSize.Y + 16)
	end)

	local VDivider = Instance.new("Frame")
	VDivider.Size = UDim2.new(0, 1, 1, -42)
	VDivider.Position = UDim2.new(0, 160, 0, 42)
	VDivider.BackgroundColor3 = C_DIVIDER
	VDivider.BorderSizePixel = 0
	VDivider.ZIndex = 2
	VDivider.Parent = MainFrame

	--=========================================================
	-- CONTENIDO
	--=========================================================
	local ContentHolder = Instance.new("Frame")
	ContentHolder.Size = UDim2.new(1, -161, 1, -42)
	ContentHolder.Position = UDim2.new(0, 161, 0, 42)
	ContentHolder.BackgroundColor3 = C_CONTENT
	ContentHolder.BackgroundTransparency = 0.35
	ContentHolder.BorderSizePixel = 0
	ContentHolder.ClipsDescendants = true
	ContentHolder.ZIndex = 1
	ContentHolder.Parent = MainFrame

	--=========================================================
	-- HOME PANEL
	--=========================================================
	local HomePanel = Instance.new("ScrollingFrame")
	HomePanel.Size = UDim2.new(1, 0, 1, 0)
	HomePanel.BackgroundTransparency = 1
	HomePanel.BorderSizePixel = 0
	HomePanel.ScrollBarThickness = 3
	HomePanel.ScrollBarImageColor3 = C_ACCENT
	HomePanel.ScrollBarImageTransparency = 0.6
	HomePanel.CanvasSize = UDim2.new(0, 0, 0, 500)
	HomePanel.Visible = true
	HomePanel.ZIndex = 1
	HomePanel.Parent = ContentHolder

	local HomeHeader = Instance.new("Frame")
	HomeHeader.Size = UDim2.new(1, -16, 0, 34)
	HomeHeader.Position = UDim2.new(0, 8, 0, 8)
	HomeHeader.BackgroundTransparency = 1
	HomeHeader.Parent = HomePanel

	local HomeTitle = Instance.new("TextLabel")
	HomeTitle.Size = UDim2.new(1, 0, 1, 0)
	HomeTitle.BackgroundTransparency = 1
	HomeTitle.Text = "PROFILE"
	HomeTitle.TextColor3 = C_TEXT
	HomeTitle.TextSize = 15
	HomeTitle.Font = Enum.Font.GothamBold
	HomeTitle.TextXAlignment = Enum.TextXAlignment.Left
	HomeTitle.Parent = HomeHeader

	local HeaderLine = Instance.new("Frame")
	HeaderLine.Size = UDim2.new(0, 40, 0, 2)
	HeaderLine.Position = UDim2.new(0, 0, 1, 2)
	HeaderLine.BackgroundColor3 = C_ACCENT
	HeaderLine.BorderSizePixel = 0
	HeaderLine.Parent = HomeHeader

	local HeaderLineGrad = Instance.new("UIGradient")
	HeaderLineGrad.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1)
	}
	HeaderLineGrad.Parent = HeaderLine

	local ProfileCard = Instance.new("Frame")
	ProfileCard.Size = UDim2.new(1, -16, 0, 200)
	ProfileCard.Position = UDim2.new(0, 8, 0, 50)
	ProfileCard.BackgroundColor3 = C_BOX_2
	ProfileCard.BackgroundTransparency = 0.15
	ProfileCard.BorderSizePixel = 0
	ProfileCard.Parent = HomePanel

	local ProfileCorner = Instance.new("UICorner")
	ProfileCorner.CornerRadius = UDim.new(0, 10)
	ProfileCorner.Parent = ProfileCard

	local ProfileStroke = Instance.new("UIStroke")
	ProfileStroke.Color = C_GREEN
	ProfileStroke.Thickness = 1.5
	ProfileStroke.Transparency = 0.4
	ProfileStroke.Parent = ProfileCard

	local CardGrad = Instance.new("UIGradient")
	CardGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 34, 44)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 22, 30))
	}
	CardGrad.Rotation = 45
	CardGrad.Parent = ProfileCard

	local CardGrid = Instance.new("Frame")
	CardGrid.Size = UDim2.new(1, 0, 1, 0)
	CardGrid.BackgroundTransparency = 1
	CardGrid.ClipsDescendants = true
	CardGrid.ZIndex = 2
	CardGrid.Parent = ProfileCard

	local CardGridCorner = Instance.new("UICorner")
	CardGridCorner.CornerRadius = UDim.new(0, 10)
	CardGridCorner.Parent = CardGrid

	for i = 0, 20 do
		local vl = Instance.new("Frame")
		vl.Size = UDim2.new(0, 1, 1, 0)
		vl.Position = UDim2.new(i/20, 0, 0, 0)
		vl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		vl.BackgroundTransparency = 0.97
		vl.BorderSizePixel = 0
		vl.ZIndex = 2
		vl.Parent = CardGrid
	end

	local AvatarFrame = Instance.new("Frame")
	AvatarFrame.Size = UDim2.new(0, 120, 0, 120)
	AvatarFrame.Position = UDim2.new(0, 16, 0, 16)
	AvatarFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
	AvatarFrame.BorderSizePixel = 0
	AvatarFrame.ZIndex = 3
	AvatarFrame.Parent = ProfileCard

	local AvatarFrameCorner = Instance.new("UICorner")
	AvatarFrameCorner.CornerRadius = UDim.new(0, 10)
	AvatarFrameCorner.Parent = AvatarFrame

	local AvatarGrad = Instance.new("UIGradient")
	AvatarGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, C_GREEN),
		ColorSequenceKeypoint.new(0.5, C_ACCENT),
		ColorSequenceKeypoint.new(1, C_GREEN)
	}
	AvatarGrad.Rotation = 45
	AvatarGrad.Parent = AvatarFrame

	local AvatarFrameStroke = Instance.new("UIStroke")
	AvatarFrameStroke.Color = C_GREEN
	AvatarFrameStroke.Thickness = 2
	AvatarFrameStroke.Transparency = 0.1
	AvatarFrameStroke.Parent = AvatarFrame

	local AvatarInner = Instance.new("Frame")
	AvatarInner.Size = UDim2.new(1, -6, 1, -6)
	AvatarInner.Position = UDim2.new(0, 3, 0, 3)
	AvatarInner.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
	AvatarInner.BorderSizePixel = 0
	AvatarInner.ZIndex = 4
	AvatarInner.Parent = AvatarFrame

	local AvatarInnerCorner = Instance.new("UICorner")
	AvatarInnerCorner.CornerRadius = UDim.new(0, 8)
	AvatarInnerCorner.Parent = AvatarInner

	local AvatarImage = Instance.new("ImageLabel")
	AvatarImage.Size = UDim2.new(1, 0, 1, 0)
	AvatarImage.BackgroundTransparency = 1
	AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=150&h=150"
	AvatarImage.ScaleType = Enum.ScaleType.Fit
	AvatarImage.ZIndex = 5
	AvatarImage.Parent = AvatarInner

	local AvatarImgCorner = Instance.new("UICorner")
	AvatarImgCorner.CornerRadius = UDim.new(0, 8)
	AvatarImgCorner.Parent = AvatarImage

	local OnlineDot = Instance.new("Frame")
	OnlineDot.Size = UDim2.new(0, 18, 0, 18)
	OnlineDot.Position = UDim2.new(1, -10, 1, -10)
	OnlineDot.BackgroundColor3 = C_GREEN
	OnlineDot.BorderSizePixel = 0
	OnlineDot.ZIndex = 6
	OnlineDot.Parent = AvatarFrame

	local OnlineDotCorner = Instance.new("UICorner")
	OnlineDotCorner.CornerRadius = UDim.new(1, 0)
	OnlineDotCorner.Parent = OnlineDot

	local OnlineDotInner = Instance.new("Frame")
	OnlineDotInner.Size = UDim2.new(1, -6, 1, -6)
	OnlineDotInner.Position = UDim2.new(0, 3, 0, 3)
	OnlineDotInner.BackgroundColor3 = C_GREEN
	OnlineDotInner.BorderSizePixel = 0
	OnlineDotInner.ZIndex = 7
	OnlineDotInner.Parent = OnlineDot

	local OnlineDotInnerCorner = Instance.new("UICorner")
	OnlineDotInnerCorner.CornerRadius = UDim.new(1, 0)
	OnlineDotInnerCorner.Parent = OnlineDotInner

	task.spawn(function()
		while OnlineDot.Parent do
			TweenService:Create(OnlineDot, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				BackgroundTransparency = 0.7
			}):Play()
			task.wait(1)
			if not OnlineDot.Parent then break end
			TweenService:Create(OnlineDot, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				BackgroundTransparency = 0
			}):Play()
			task.wait(1)
		end
	end)

	local AvatarName = Instance.new("TextLabel")
	AvatarName.Size = UDim2.new(1, -8, 0, 16)
	AvatarName.Position = UDim2.new(0, 4, 1, 4)
	AvatarName.BackgroundTransparency = 1
	AvatarName.Text = Player.DisplayName
	AvatarName.TextColor3 = C_TEXT
	AvatarName.TextSize = 11
	AvatarName.Font = Enum.Font.GothamBold
	AvatarName.TextTruncate = Enum.TextTruncate.AtEnd
	AvatarName.ZIndex = 6
	AvatarName.Parent = AvatarFrame

	local InfoX = 152

	local NameLabel = Instance.new("TextLabel")
	NameLabel.Size = UDim2.new(0, 80, 0, 20)
	NameLabel.Position = UDim2.new(0, InfoX, 0, 20)
	NameLabel.BackgroundTransparency = 1
	NameLabel.Text = "Name User:"
	NameLabel.TextColor3 = C_GOLD
	NameLabel.TextSize = 13
	NameLabel.Font = Enum.Font.GothamBold
	NameLabel.TextXAlignment = Enum.TextXAlignment.Left
	NameLabel.ZIndex = 3
	NameLabel.Parent = ProfileCard

	local NameValue = Instance.new("TextLabel")
	NameValue.Size = UDim2.new(1, InfoX + 82, 0, 20)
	NameValue.Position = UDim2.new(0, InfoX + 82, 0, 20)
	NameValue.BackgroundTransparency = 1
	NameValue.Text = Player.Name
	NameValue.TextColor3 = C_TEXT
	NameValue.TextSize = 13
	NameValue.Font = Enum.Font.Gotham
	NameValue.TextXAlignment = Enum.TextXAlignment.Left
	NameValue.TextTruncate = Enum.TextTruncate.AtEnd
	NameValue.ZIndex = 3
	NameValue.Parent = ProfileCard

	local IdLabel = Instance.new("TextLabel")
	IdLabel.Size = UDim2.new(0, 80, 0, 20)
	IdLabel.Position = UDim2.new(0, InfoX, 0, 46)
	IdLabel.BackgroundTransparency = 1
	IdLabel.Text = "ID User:"
	IdLabel.TextColor3 = C_GOLD
	IdLabel.TextSize = 13
	IdLabel.Font = Enum.Font.GothamBold
	IdLabel.TextXAlignment = Enum.TextXAlignment.Left
	IdLabel.ZIndex = 3
	IdLabel.Parent = ProfileCard

	local IdValue = Instance.new("TextLabel")
	IdValue.Size = UDim2.new(1, InfoX + 82, 0, 20)
	IdValue.Position = UDim2.new(0, InfoX + 82, 0, 46)
	IdValue.BackgroundTransparency = 1
	IdValue.Text = tostring(Player.UserId)
	IdValue.TextColor3 = C_TEXT
	IdValue.TextSize = 13
	IdValue.Font = Enum.Font.Gotham
	IdValue.TextXAlignment = Enum.TextXAlignment.Left
	IdValue.ZIndex = 3
	IdValue.Parent = ProfileCard

	local StatusLabel = Instance.new("TextLabel")
	StatusLabel.Size = UDim2.new(0, 80, 0, 22)
	StatusLabel.Position = UDim2.new(0, InfoX, 0, 72)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.Text = "Status:"
	StatusLabel.TextColor3 = C_GOLD
	StatusLabel.TextSize = 13
	StatusLabel.Font = Enum.Font.GothamBold
	StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	StatusLabel.ZIndex = 3
	StatusLabel.Parent = ProfileCard

	local StatusBadge = Instance.new("Frame")
	StatusBadge.Size = UDim2.new(0, 90, 0, 22)
	StatusBadge.Position = UDim2.new(0, InfoX + 82, 0, 72)
	StatusBadge.BackgroundColor3 = C_GREEN_DARK
	StatusBadge.BorderSizePixel = 0
	StatusBadge.ZIndex = 3
	StatusBadge.Parent = ProfileCard

	local StatusBadgeCorner = Instance.new("UICorner")
	StatusBadgeCorner.CornerRadius = UDim.new(0, 6)
	StatusBadgeCorner.Parent = StatusBadge

	local StatusBadgeStroke = Instance.new("UIStroke")
	StatusBadgeStroke.Color = C_GREEN
	StatusBadgeStroke.Thickness = 1
	StatusBadgeStroke.Transparency = 0.2
	StatusBadgeStroke.Parent = StatusBadge

	local StatusDot = Instance.new("Frame")
	StatusDot.Size = UDim2.new(0, 8, 0, 8)
	StatusDot.Position = UDim2.new(0, 8, 0.5, -4)
	StatusDot.BackgroundColor3 = C_GREEN
	StatusDot.BorderSizePixel = 0
	StatusDot.ZIndex = 4
	StatusDot.Parent = StatusBadge

	local StatusDotCorner = Instance.new("UICorner")
	StatusDotCorner.CornerRadius = UDim.new(1, 0)
	StatusDotCorner.Parent = StatusDot

	local StatusText = Instance.new("TextLabel")
	StatusText.Size = UDim2.new(1, -25, 1, 0)
	StatusText.Position = UDim2.new(0, 22, 0, 0)
	StatusText.BackgroundTransparency = 1
	StatusText.Text = "Activo"
	StatusText.TextColor3 = C_GREEN
	StatusText.TextSize = 12
	StatusText.Font = Enum.Font.GothamBold
	StatusText.TextXAlignment = Enum.TextXAlignment.Left
	StatusText.ZIndex = 4
	StatusText.Parent = StatusBadge

	local FooterLine = Instance.new("Frame")
	FooterLine.Size = UDim2.new(1, -32, 0, 1)
	FooterLine.Position = UDim2.new(0, 16, 0, 165)
	FooterLine.BackgroundColor3 = C_DIVIDER
	FooterLine.BorderSizePixel = 0
	FooterLine.ZIndex = 3
	FooterLine.Parent = ProfileCard

	local VersionLabel = Instance.new("TextLabel")
	VersionLabel.Size = UDim2.new(0, 100, 0, 20)
	VersionLabel.Position = UDim2.new(0, 16, 0, 172)
	VersionLabel.BackgroundTransparency = 1
	VersionLabel.Text = "BETA"
	VersionLabel.TextColor3 = C_TEXT_DIM
	VersionLabel.TextSize = 11
	VersionLabel.Font = Enum.Font.Gotham
	VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
	VersionLabel.ZIndex = 3
	VersionLabel.Parent = ProfileCard

	local BuildLabel = Instance.new("TextLabel")
	BuildLabel.Size = UDim2.new(0, 150, 0, 20)
	BuildLabel.Position = UDim2.new(1, -166, 0, 172)
	BuildLabel.BackgroundTransparency = 1
	BuildLabel.Text = " "
	BuildLabel.TextColor3 = C_TEXT_DIM
	BuildLabel.TextSize = 11
	BuildLabel.Font = Enum.Font.Gotham
	BuildLabel.TextXAlignment = Enum.TextXAlignment.Right
	BuildLabel.ZIndex = 3
	BuildLabel.Parent = ProfileCard

	local CommunitySection = Instance.new("Frame")
	CommunitySection.Size = UDim2.new(1, -16, 0, 100)
	CommunitySection.Position = UDim2.new(0, 8, 0, 262)
	CommunitySection.BackgroundColor3 = C_BOX
	CommunitySection.BackgroundTransparency = 0.15
	CommunitySection.BorderSizePixel = 0
	CommunitySection.Parent = HomePanel

	local CommunityCorner = Instance.new("UICorner")
	CommunityCorner.CornerRadius = UDim.new(0, 10)
	CommunityCorner.Parent = CommunitySection

	local CommunityGrad = Instance.new("UIGradient")
	CommunityGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 38, 60)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 27, 40))
	}
	CommunityGrad.Rotation = 45
	CommunityGrad.Parent = CommunitySection

	local CommunityStroke = Instance.new("UIStroke")
	CommunityStroke.Color = C_DISCORD
	CommunityStroke.Thickness = 1
	CommunityStroke.Transparency = 0.3
	CommunityStroke.Parent = CommunitySection

	local CommunityTitle = Instance.new("TextLabel")
	CommunityTitle.Size = UDim2.new(1, -20, 0, 22)
	CommunityTitle.Position = UDim2.new(0, 14, 0, 10)
	CommunityTitle.BackgroundTransparency = 1
	CommunityTitle.Text = "ÚNETE A NUESTRO DISCORD"
	CommunityTitle.TextColor3 = C_TEXT
	CommunityTitle.TextSize = 13
	CommunityTitle.Font = Enum.Font.GothamBold
	CommunityTitle.TextXAlignment = Enum.TextXAlignment.Left
	CommunityTitle.Parent = CommunitySection

	local CommunitySub = Instance.new("TextLabel")
	CommunitySub.Size = UDim2.new(1, -20, 0, 16)
	CommunitySub.Position = UDim2.new(0, 14, 0, 32)
	CommunitySub.BackgroundTransparency = 1
	CommunitySub.Text = "Únete al servidor de Discord para soporte y updates."
	CommunitySub.TextColor3 = C_TEXT_DIM
	CommunitySub.TextSize = 11
	CommunitySub.Font = Enum.Font.Gotham
	CommunitySub.TextXAlignment = Enum.TextXAlignment.Left
	CommunitySub.Parent = CommunitySection

	local DiscordBtn = Instance.new("TextButton")
	DiscordBtn.Size = UDim2.new(0, 170, 0, 34)
	DiscordBtn.Position = UDim2.new(0, 14, 0, 54)
	DiscordBtn.BackgroundColor3 = C_DISCORD
	DiscordBtn.BorderSizePixel = 0
	DiscordBtn.Text = "COPIAR DISCORD"
	DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	DiscordBtn.TextSize = 12
	DiscordBtn.Font = Enum.Font.GothamBold
	DiscordBtn.AutoButtonColor = false
	DiscordBtn.Parent = CommunitySection

	local DiscordBtnCorner = Instance.new("UICorner")
	DiscordBtnCorner.CornerRadius = UDim.new(0, 8)
	DiscordBtnCorner.Parent = DiscordBtn

	local DiscordBtnStroke = Instance.new("UIStroke")
	DiscordBtnStroke.Color = Color3.fromRGB(255, 255, 255)
	DiscordBtnStroke.Thickness = 1
	DiscordBtnStroke.Transparency = 0.75
	DiscordBtnStroke.Parent = DiscordBtn

	local LinkLabel = Instance.new("TextLabel")
	LinkLabel.Size = UDim2.new(1, -200, 0, 20)
	LinkLabel.Position = UDim2.new(0, 194, 0, 61)
	LinkLabel.BackgroundTransparency = 1
	LinkLabel.Text = "discord.gg/mWBffStfJ"
	LinkLabel.TextColor3 = C_LINK
	LinkLabel.TextSize = 11
	LinkLabel.Font = Enum.Font.Gotham
	LinkLabel.TextXAlignment = Enum.TextXAlignment.Left
	LinkLabel.TextTruncate = Enum.TextTruncate.AtEnd
	LinkLabel.Parent = CommunitySection

	local copied = false
	DiscordBtn.MouseEnter:Connect(function()
		if not copied then
			TweenService:Create(DiscordBtn, TweenInfo.new(0.15), {BackgroundColor3 = C_DISCORD_H}):Play()
		end
	end)
	DiscordBtn.MouseLeave:Connect(function()
		if not copied then
			TweenService:Create(DiscordBtn, TweenInfo.new(0.15), {BackgroundColor3 = C_DISCORD}):Play()
		end
	end)
	DiscordBtn.MouseButton1Click:Connect(function()
		pcall(function() setclipboard(DISCORD_URL) end)
		copied = true
		DiscordBtn.Text = "✓  COPIADO"
		TweenService:Create(DiscordBtn, TweenInfo.new(0.15), {BackgroundColor3 = C_GREEN}):Play()
		task.wait(1.5)
		copied = false
		DiscordBtn.Text = "COPIAR DISCORD"
		TweenService:Create(DiscordBtn, TweenInfo.new(0.25), {BackgroundColor3 = C_DISCORD}):Play()
	end)

	--=========================================================
	-- STATS CON PING
	--=========================================================
	local InfoRow = Instance.new("Frame")
	InfoRow.Size = UDim2.new(1, -16, 0, 60)
	InfoRow.Position = UDim2.new(0, 8, 0, 372)
	InfoRow.BackgroundTransparency = 1
	InfoRow.Parent = HomePanel

	local function CreateStatCard(x, w, title, value, color)
		local card = Instance.new("Frame")
		card.Size = UDim2.new(0, w, 1, 0)
		card.Position = UDim2.new(0, x, 0, 0)
		card.BackgroundColor3 = C_BOX
		card.BackgroundTransparency = 0.15
		card.BorderSizePixel = 0
		card.Parent = InfoRow

		local cc = Instance.new("UICorner")
		cc.CornerRadius = UDim.new(0, 8)
		cc.Parent = card

		local cs = Instance.new("UIStroke")
		cs.Color = color
		cs.Thickness = 1
		cs.Transparency = 0.5
		cs.Parent = card

		local accent = Instance.new("Frame")
		accent.Size = UDim2.new(0, 3, 0, 22)
		accent.Position = UDim2.new(0, 8, 0.5, -11)
		accent.BackgroundColor3 = color
		accent.BorderSizePixel = 0
		accent.Parent = card

		local accentCorner = Instance.new("UICorner")
		accentCorner.CornerRadius = UDim.new(1, 0)
		accentCorner.Parent = accent

		local t = Instance.new("TextLabel")
		t.Size = UDim2.new(1, -20, 0, 16)
		t.Position = UDim2.new(0, 16, 0, 10)
		t.BackgroundTransparency = 1
		t.Text = title
		t.TextColor3 = C_TEXT_DIM
		t.TextSize = 10
		t.Font = Enum.Font.Gotham
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.Parent = card

		local v = Instance.new("TextLabel")
		v.Size = UDim2.new(1, -20, 0, 20)
		v.Position = UDim2.new(0, 16, 0, 28)
		v.BackgroundTransparency = 1
		v.Text = value
		v.TextColor3 = color
		v.TextSize = 14
		v.Font = Enum.Font.GothamBold
		v.TextXAlignment = Enum.TextXAlignment.Left
		v.Parent = card

		return v, accent, card, cs
	end

	CreateStatCard(0, 122, "STATUS", "ONLINE", C_GREEN)
	local PingValueLabel, PingAccent, PingCard, PingStroke = CreateStatCard(130, 122, "PING", "...", C_ACCENT)
	CreateStatCard(260, 112, "BUILD", "STABLE", C_GOLD)

	local function GetPing()
		local ping = 0
		pcall(function()
			ping = math.floor(Player:GetNetworkPing() * 1000)
		end)
		if ping <= 0 then
			ping = math.random(28, 65)
		end
		return ping
	end

	local currentDisplayPing = GetPing()
	local targetPing = currentDisplayPing

	task.spawn(function()
		while PingValueLabel.Parent do
			targetPing = GetPing()
			task.wait(1)
		end
	end)

	task.spawn(function()
		while PingValueLabel.Parent do
			currentDisplayPing = currentDisplayPing + (targetPing - currentDisplayPing) * 0.15

			local shownPing = math.floor(currentDisplayPing + 0.5)

			local color
			if shownPing < 60 then
				color = C_GREEN
			elseif shownPing < 100 then
				color = C_ACCENT
			elseif shownPing < 180 then
				color = C_GOLD
			else
				color = C_RED
			end

			PingValueLabel.Text = shownPing .. " ms"
			PingValueLabel.TextColor3 = color
			PingAccent.BackgroundColor3 = color
			PingStroke.Color = color

			RunService.Heartbeat:Wait()
		end
	end)

	--=========================================================
	-- PANEL SETTINGS (VACÍO)
	--=========================================================
	local SettingsPanel = Instance.new("ScrollingFrame")
	SettingsPanel.Size = UDim2.new(1, 0, 1, 0)
	SettingsPanel.BackgroundTransparency = 1
	SettingsPanel.BorderSizePixel = 0
	SettingsPanel.ScrollBarThickness = 2
	SettingsPanel.ScrollBarImageColor3 = C_ACCENT
	SettingsPanel.ScrollBarImageTransparency = 0.5
	SettingsPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
	SettingsPanel.Visible = false
	SettingsPanel.ZIndex = 1
	SettingsPanel.Parent = ContentHolder

	--=========================================================
	-- PANEL ANIMACIONES
	--=========================================================
	local AnimPanel = Instance.new("ScrollingFrame")
	AnimPanel.Size = UDim2.new(1, 0, 1, 0)
	AnimPanel.BackgroundTransparency = 1
	AnimPanel.BorderSizePixel = 0
	AnimPanel.ScrollBarThickness = 2
	AnimPanel.ScrollBarImageColor3 = C_ACCENT
	AnimPanel.ScrollBarImageTransparency = 0.5
	AnimPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
	AnimPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
	AnimPanel.Visible = false
	AnimPanel.ZIndex = 1
	AnimPanel.Parent = ContentHolder

	local AnimLayout = Instance.new("UIListLayout")
	AnimLayout.Padding = UDim.new(0, 8)
	AnimLayout.SortOrder = Enum.SortOrder.LayoutOrder
	AnimLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	AnimLayout.Parent = AnimPanel

	local AnimPad = Instance.new("UIPadding")
	AnimPad.PaddingTop = UDim.new(0, 10)
	AnimPad.PaddingBottom = UDim.new(0, 10)
	AnimPad.PaddingLeft = UDim.new(0, 10)
	AnimPad.PaddingRight = UDim.new(0, 10)
	AnimPad.Parent = AnimPanel

	-- Toggle visual para animaciones
	local AnimToggleFrame = Instance.new("Frame")
	AnimToggleFrame.Size = UDim2.new(1, -20, 0, 50)
	AnimToggleFrame.BackgroundColor3 = C_BOX
	AnimToggleFrame.BackgroundTransparency = 0.15
	AnimToggleFrame.BorderSizePixel = 0
	AnimToggleFrame.LayoutOrder = 0
	AnimToggleFrame.Parent = AnimPanel

	local AnimToggleCorner = Instance.new("UICorner")
	AnimToggleCorner.CornerRadius = UDim.new(0, 10)
	AnimToggleCorner.Parent = AnimToggleFrame

	local AnimToggleStroke = Instance.new("UIStroke")
	AnimToggleStroke.Color = C_DIVIDER
	AnimToggleStroke.Thickness = 1
	AnimToggleStroke.Transparency = 0.4
	AnimToggleStroke.Parent = AnimToggleFrame

	local AnimToggleLabel = Instance.new("TextLabel")
	AnimToggleLabel.Size = UDim2.new(1, -80, 0, 20)
	AnimToggleLabel.Position = UDim2.new(0, 16, 0, 8)
	AnimToggleLabel.BackgroundTransparency = 1
	AnimToggleLabel.Text = "ANIMACIONES"
	AnimToggleLabel.TextColor3 = C_TEXT
	AnimToggleLabel.TextSize = 13
	AnimToggleLabel.Font = Enum.Font.GothamBold
	AnimToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
	AnimToggleLabel.Parent = AnimToggleFrame

	local AnimToggleSub = Instance.new("TextLabel")
	AnimToggleSub.Size = UDim2.new(1, -80, 0, 14)
	AnimToggleSub.Position = UDim2.new(0, 16, 0, 28)
	AnimToggleSub.BackgroundTransparency = 1
	AnimToggleSub.Text = "Cambia las animaciones de tu personaje"
	AnimToggleSub.TextColor3 = C_TEXT_DIM
	AnimToggleSub.TextSize = 10
	AnimToggleSub.Font = Enum.Font.Gotham
	AnimToggleSub.TextXAlignment = Enum.TextXAlignment.Left
	AnimToggleSub.Parent = AnimToggleFrame

	local AnimToggleBtn = Instance.new("TextButton")
	AnimToggleBtn.Size = UDim2.new(0, 52, 0, 28)
	AnimToggleBtn.Position = UDim2.new(1, -68, 0.5, -14)
	AnimToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 44, 56)
	AnimToggleBtn.BorderSizePixel = 0
	AnimToggleBtn.Text = ""
	AnimToggleBtn.AutoButtonColor = false
	AnimToggleBtn.Parent = AnimToggleFrame

	local ToggleCorner = Instance.new("UICorner")
	ToggleCorner.CornerRadius = UDim.new(1, 0)
	ToggleCorner.Parent = AnimToggleBtn

	local ToggleKnob = Instance.new("Frame")
	ToggleKnob.Size = UDim2.new(0, 22, 0, 22)
	ToggleKnob.Position = UDim2.new(0, 3, 0.5, -11)
	ToggleKnob.BackgroundColor3 = Color3.fromRGB(180, 185, 200)
	ToggleKnob.BorderSizePixel = 0
	ToggleKnob.Parent = AnimToggleBtn

	local ToggleKnobCorner = Instance.new("UICorner")
	ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
	ToggleKnobCorner.Parent = ToggleKnob

	local AnimListContainer = Instance.new("Frame")
	AnimListContainer.Size = UDim2.new(1, 0, 0, 0)
	AnimListContainer.AutomaticSize = Enum.AutomaticSize.Y
	AnimListContainer.BackgroundTransparency = 1
	AnimListContainer.LayoutOrder = 1
	AnimListContainer.Visible = false
	AnimListContainer.Parent = AnimPanel

	local AnimListLayout = Instance.new("UIListLayout")
	AnimListLayout.Padding = UDim.new(0, 6)
	AnimListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	AnimListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	AnimListLayout.Parent = AnimListContainer

	--=========================================================
	-- LÓGICA DE ANIMACIONES
	--=========================================================
	local animState = { enabled = false, gui = nil }
	local animSelected = {}

	local function ApplyAnims(ids)
		local char = Player.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local Animate = char:FindFirstChild("Animate")
		if not Animate or not hum then return end
		local animator = hum:FindFirstChildOfClass("Animator")
		if animator then
			for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
				track:Stop(0)
			end
		end
		local function setAnimId(parentName, childName, newId)
			local parentObj = Animate:FindFirstChild(parentName)
			if parentObj then
				local animObj = parentObj:FindFirstChild(childName)
				if animObj and animObj:IsA("Animation") then
					animObj.AnimationId = newId or "rbxassetid://0"
				end
			end
		end
		setAnimId("idle", "Animation1", ids.idle1)
		setAnimId("idle", "Animation2", ids.idle2)
		setAnimId("walk", "WalkAnim", ids.walk)
		setAnimId("run", "RunAnim", ids.run)
		setAnimId("jump", "JumpAnim", ids.jump)
		setAnimId("fall", "FallAnim", ids.fall)
		Animate.Enabled = false
		task.wait(0.03)
		Animate.Enabled = true
		if hum.Health > 0 then
			hum:ChangeState(Enum.HumanoidStateType.Landed)
		end
	end

	-- Crear botón de animación
	local function CreateAnimButton(name, ids)
		local Btn = Instance.new("TextButton")
		Btn.Size = UDim2.new(1, -8, 0, 44)
		Btn.Text = ""
		Btn.BackgroundColor3 = C_BOX_2
		Btn.BackgroundTransparency = 0.05
		Btn.AutoButtonColor = false
		Btn.Parent = AnimListContainer

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 10)
		corner.Parent = Btn

		local stroke = Instance.new("UIStroke")
		stroke.Color = C_DIVIDER
		stroke.Thickness = 1
		stroke.Transparency = 0.3
		stroke.Parent = Btn

		local accentBar = Instance.new("Frame")
		accentBar.Size = UDim2.new(0, 3, 0, 20)
		accentBar.Position = UDim2.new(0, 0, 0.5, -10)
		accentBar.BackgroundColor3 = C_ACCENT
		accentBar.BorderSizePixel = 0
		accentBar.Parent = Btn

		local accentCorner = Instance.new("UICorner")
		accentCorner.CornerRadius = UDim.new(1, 0)
		accentCorner.Parent = accentBar

		local txt = Instance.new("TextLabel")
		txt.Size = UDim2.new(1, -60, 0, 20)
		txt.Position = UDim2.new(0, 20, 0, 6)
		txt.BackgroundTransparency = 1
		txt.Text = name
		txt.TextColor3 = C_TEXT
		txt.Font = Enum.Font.GothamBold
		txt.TextSize = 13
		txt.TextXAlignment = Enum.TextXAlignment.Left
		txt.Parent = Btn

		local sub = Instance.new("TextLabel")
		sub.Size = UDim2.new(1, -60, 0, 14)
		sub.Position = UDim2.new(0, 20, 0, 24)
		sub.BackgroundTransparency = 1
		sub.Text = "Animación completa · 6 tracks"
		sub.TextColor3 = C_TEXT_DIM
		sub.Font = Enum.Font.Gotham
		sub.TextSize = 10
		sub.TextXAlignment = Enum.TextXAlignment.Left
		sub.Parent = Btn

		local arrow = Instance.new("TextLabel")
		arrow.Size = UDim2.new(0, 30, 1, 0)
		arrow.Position = UDim2.new(1, -35, 0, 0)
		arrow.BackgroundTransparency = 1
		arrow.Text = "›"
		arrow.TextColor3 = C_TEXT_DIM
		arrow.Font = Enum.Font.GothamBold
		arrow.TextSize = 22
		arrow.Parent = Btn

		Btn.MouseEnter:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.22), {BackgroundColor3 = C_BOX}):Play()
			TweenService:Create(stroke, TweenInfo.new(0.22), {Color = C_ACCENT, Transparency = 0.1}):Play()
			TweenService:Create(txt, TweenInfo.new(0.22), {TextColor3 = C_WHITE}):Play()
			TweenService:Create(arrow, TweenInfo.new(0.22), {TextColor3 = C_ACCENT, Position = UDim2.new(1, -30, 0, 0)}):Play()
		end)

		Btn.MouseLeave:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.22), {BackgroundColor3 = C_BOX_2}):Play()
			TweenService:Create(stroke, TweenInfo.new(0.22), {Color = C_DIVIDER, Transparency = 0.3}):Play()
			TweenService:Create(txt, TweenInfo.new(0.22), {TextColor3 = C_TEXT}):Play()
			TweenService:Create(arrow, TweenInfo.new(0.22), {TextColor3 = C_TEXT_DIM, Position = UDim2.new(1, -35, 0, 0)}):Play()
		end)

		Btn.MouseButton1Click:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = C_ACCENT_SOFT}):Play()
			TweenService:Create(accentBar, TweenInfo.new(0.1), {BackgroundColor3 = C_WHITE}):Play()
			task.delay(0.15, function()
				TweenService:Create(Btn, TweenInfo.new(0.3), {BackgroundColor3 = C_BOX_2}):Play()
				TweenService:Create(accentBar, TweenInfo.new(0.3), {BackgroundColor3 = C_ACCENT}):Play()
			end)
			animSelected = ids
			ApplyAnims(ids)
		end)

		return Btn
	end

	-- Lista de animaciones
	local anims = {
		{name = "Astronaut", ids = {
			idle1 = "http://www.roblox.com/asset/?id=891621366",
			idle2 = "http://www.roblox.com/asset/?id=891633237",
			walk  = "http://www.roblox.com/asset/?id=891667138",
			run   = "http://www.roblox.com/asset/?id=891636393",
			jump  = "http://www.roblox.com/asset/?id=891627522",
			fall  = "http://www.roblox.com/asset/?id=891617961"
		}},
		{name = "Bubbly", ids = {
			idle1 = "http://www.roblox.com/asset/?id=910004836",
			idle2 = "http://www.roblox.com/asset/?id=910009958",
			walk  = "http://www.roblox.com/asset/?id=910034870",
			run   = "http://www.roblox.com/asset/?id=910025107",
			jump  = "http://www.roblox.com/asset/?id=910016857",
			fall  = "http://www.roblox.com/asset/?id=910001910"
		}},
		{name = "Cartoony", ids = {
			idle1 = "http://www.roblox.com/asset/?id=742637544",
			idle2 = "http://www.roblox.com/asset/?id=742638445",
			walk  = "http://www.roblox.com/asset/?id=742640026",
			run   = "http://www.roblox.com/asset/?id=742638842",
			jump  = "http://www.roblox.com/asset/?id=742637942",
			fall  = "http://www.roblox.com/asset/?id=742637151"
		}},
		{name = "Elder", ids = {
			idle1 = "http://www.roblox.com/asset/?id=845397899",
			idle2 = "http://www.roblox.com/asset/?id=845400520",
			walk  = "http://www.roblox.com/asset/?id=845403856",
			run   = "http://www.roblox.com/asset/?id=845386501",
			jump  = "http://www.roblox.com/asset/?id=845398858",
			fall  = "http://www.roblox.com/asset/?id=845396048"
		}},
		{name = "Knight", ids = {
			idle1 = "http://www.roblox.com/asset/?id=657595757",
			idle2 = "http://www.roblox.com/asset/?id=657568135",
			walk  = "http://www.roblox.com/asset/?id=657552124",
			run   = "http://www.roblox.com/asset/?id=657564596",
			jump  = "http://www.roblox.com/asset/?id=658409194",
			fall  = "http://www.roblox.com/asset/?id=657600338"
		}},
		{name = "Levitation", ids = {
			idle1 = "http://www.roblox.com/asset/?id=616006778",
			idle2 = "http://www.roblox.com/asset/?id=616008087",
			walk  = "http://www.roblox.com/asset/?id=616013216",
			run   = "http://www.roblox.com/asset/?id=616010382",
			jump  = "http://www.roblox.com/asset/?id=616008936",
			fall  = "http://www.roblox.com/asset/?id=616005863"
		}},
		{name = "Mage", ids = {
			idle1 = "http://www.roblox.com/asset/?id=707742142",
			idle2 = "http://www.roblox.com/asset/?id=707855907",
			walk  = "http://www.roblox.com/asset/?id=707897309",
			run   = "http://www.roblox.com/asset/?id=707861613",
			jump  = "http://www.roblox.com/asset/?id=707853694",
			fall  = "http://www.roblox.com/asset/?id=707829716"
		}},
		{name = "Ninja", ids = {
			idle1 = "http://www.roblox.com/asset/?id=656117400",
			idle2 = "http://www.roblox.com/asset/?id=656118341",
			walk  = "http://www.roblox.com/asset/?id=656121766",
			run   = "http://www.roblox.com/asset/?id=656118852",
			jump  = "http://www.roblox.com/asset/?id=656117878",
			fall  = "http://www.roblox.com/asset/?id=656115606"
		}},
		{name = "Pirate", ids = {
			idle1 = "http://www.roblox.com/asset/?id=750781874",
			idle2 = "http://www.roblox.com/asset/?id=750782770",
			walk  = "http://www.roblox.com/asset/?id=750785693",
			run   = "http://www.roblox.com/asset/?id=750783738",
			jump  = "http://www.roblox.com/asset/?id=750782230",
			fall  = "http://www.roblox.com/asset/?id=750780242"
		}},
		{name = "Robot", ids = {
			idle1 = "http://www.roblox.com/asset/?id=616088211",
			idle2 = "http://www.roblox.com/asset/?id=616089559",
			walk  = "http://www.roblox.com/asset/?id=616095330",
			run   = "http://www.roblox.com/asset/?id=616091570",
			jump  = "http://www.roblox.com/asset/?id=616090535",
			fall  = "http://www.roblox.com/asset/?id=616087089"
		}},
		{name = "Stylish", ids = {
			idle1 = "http://www.roblox.com/asset/?id=616136790",
			idle2 = "http://www.roblox.com/asset/?id=616138447",
			walk  = "http://www.roblox.com/asset/?id=616146177",
			run   = "http://www.roblox.com/asset/?id=616140816",
			jump  = "http://www.roblox.com/asset/?id=616139451",
			fall  = "http://www.roblox.com/asset/?id=616134815"
		}},
		{name = "SuperHero", ids = {
			idle1 = "http://www.roblox.com/asset/?id=616111295",
			idle2 = "http://www.roblox.com/asset/?id=616113536",
			walk  = "http://www.roblox.com/asset/?id=616122287",
			run   = "http://www.roblox.com/asset/?id=616117076",
			jump  = "http://www.roblox.com/asset/?id=616115533",
			fall  = "http://www.roblox.com/asset/?id=616108001"
		}},
		{name = "Toy", ids = {
			idle1 = "http://www.roblox.com/asset/?id=782841498",
			idle2 = "http://www.roblox.com/asset/?id=782845736",
			walk  = "http://www.roblox.com/asset/?id=782843345",
			run   = "http://www.roblox.com/asset/?id=782842708",
			jump  = "http://www.roblox.com/asset/?id=782847020",
			fall  = "http://www.roblox.com/asset/?id=782846423"
		}},
		{name = "Vampire", ids = {
			idle1 = "http://www.roblox.com/asset/?id=1083445855",
			idle2 = "http://www.roblox.com/asset/?id=1083450166",
			walk  = "http://www.roblox.com/asset/?id=1083473930",
			run   = "http://www.roblox.com/asset/?id=1083462077",
			jump  = "http://www.roblox.com/asset/?id=1083455352",
			fall  = "http://www.roblox.com/asset/?id=1083443587"
		}},
		{name = "Werewolf", ids = {
			idle1 = "http://www.roblox.com/asset/?id=1083195517",
			idle2 = "http://www.roblox.com/asset/?id=1083214717",
			walk  = "http://www.roblox.com/asset/?id=1083178339",
			run   = "http://www.roblox.com/asset/?id=1083216690",
			jump  = "http://www.roblox.com/asset/?id=1083218792",
			fall  = "http://www.roblox.com/asset/?id=1083189019"
		}},
		{name = "Zombie", ids = {
			idle1 = "http://www.roblox.com/asset/?id=616158929",
			idle2 = "http://www.roblox.com/asset/?id=616160636",
			walk  = "http://www.roblox.com/asset/?id=616168032",
			run   = "http://www.roblox.com/asset/?id=616163682",
			jump  = "http://www.roblox.com/asset/?id=616161997",
			fall  = "http://www.roblox.com/asset/?id=616157476"
		}},
		{name = "Patrol", ids = {
			idle1 = "http://www.roblox.com/asset/?id=1149612882",
			idle2 = "http://www.roblox.com/asset/?id=1150842221",
			walk  = "http://www.roblox.com/asset/?id=1151231493",
			run   = "http://www.roblox.com/asset/?id=1150967949",
			jump  = "http://www.roblox.com/asset/?id=1148811837",
			fall  = "http://www.roblox.com/asset/?id=1148863382"
		}},
		{name = "Confident", ids = {
			idle1 = "http://www.roblox.com/asset/?id=1069977950",
			idle2 = "http://www.roblox.com/asset/?id=1069987858",
			walk  = "http://www.roblox.com/asset/?id=1070017263",
			run   = "http://www.roblox.com/asset/?id=1070001516",
			jump  = "http://www.roblox.com/asset/?id=1069984524",
			fall  = "http://www.roblox.com/asset/?id=1069973677"
		}},
		{name = "Popstar", ids = {
			idle1 = "http://www.roblox.com/asset/?id=1212900985",
			idle2 = "http://www.roblox.com/asset/?id=1150842221",
			walk  = "http://www.roblox.com/asset/?id=1212980338",
			run   = "http://www.roblox.com/asset/?id=1212980348",
			jump  = "http://www.roblox.com/asset/?id=1212954642",
			fall  = "http://www.roblox.com/asset/?id=1212900995"
		}},
		{name = "Cowboy", ids = {
			idle1 = "http://www.roblox.com/asset/?id=1014390418",
			idle2 = "http://www.roblox.com/asset/?id=1014398616",
			walk  = "http://www.roblox.com/asset/?id=1014421541",
			run   = "http://www.roblox.com/asset/?id=1014401683",
			jump  = "http://www.roblox.com/asset/?id=1014394726",
			fall  = "http://www.roblox.com/asset/?id=1014384571"
		}},
		{name = "Ghost", ids = {
			idle1 = "http://www.roblox.com/asset/?id=616006778",
			idle2 = "http://www.roblox.com/asset/?id=616008087",
			walk  = "http://www.roblox.com/asset/?id=616013216",
			run   = "http://www.roblox.com/asset/?id=616010382",
			jump  = "http://www.roblox.com/asset/?id=616008936",
			fall  = "http://www.roblox.com/asset/?id=616005863"
		}},
		{name = "Sneaky", ids = {
			idle1 = "http://www.roblox.com/asset/?id=1132473842",
			idle2 = "http://www.roblox.com/asset/?id=1132477671",
			walk  = "http://www.roblox.com/asset/?id=1132510133",
			run   = "http://www.roblox.com/asset/?id=1132494274",
			jump  = "http://www.roblox.com/asset/?id=1132489853",
			fall  = "http://www.roblox.com/asset/?id=1132469004"
		}},
		{name = "Princess", ids = {
			idle1 = "http://www.roblox.com/asset/?id=941003647",
			idle2 = "http://www.roblox.com/asset/?id=941013098",
			walk  = "http://www.roblox.com/asset/?id=941028902",
			run   = "http://www.roblox.com/asset/?id=941015281",
			jump  = "http://www.roblox.com/asset/?id=941008832",
			fall  = "http://www.roblox.com/asset/?id=941000007"
		}},
		{name = "None", ids = {
			idle1 = "http://www.roblox.com/asset/?id=0",
			idle2 = "http://www.roblox.com/asset/?id=0",
			walk  = "http://www.roblox.com/asset/?id=0",
			run   = "http://www.roblox.com/asset/?id=0",
			jump  = "http://www.roblox.com/asset/?id=0",
			fall  = "http://www.roblox.com/asset/?id=0"
		}},
		{name = "Anthro (Default)", ids = {
			idle1 = "http://www.roblox.com/asset/?id=2510196951",
			idle2 = "http://www.roblox.com/asset/?id=2510197257",
			walk  = "http://www.roblox.com/asset/?id=2510202577",
			run   = "http://www.roblox.com/asset/?id=2510198475",
			jump  = "http://www.roblox.com/asset/?id=2510197830",
			fall  = "http://www.roblox.com/asset/?id=2510195892"
		}},
	}

	for _, anim in ipairs(anims) do
		CreateAnimButton(anim.name, anim.ids)
	end

	-- Toggle handler
	AnimToggleBtn.MouseButton1Click:Connect(function()
		animState.enabled = not animState.enabled
		if animState.enabled then
			animSelected = {}
			TweenService:Create(AnimToggleBtn, TweenInfo.new(0.25), {BackgroundColor3 = C_ACCENT}):Play()
			TweenService:Create(ToggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
				Position = UDim2.new(1, -25, 0.5, -11)
			}):Play()
			AnimListContainer.Visible = true
			-- Re-aplicar animación si se cierra y reabre
			if animSelected and animSelected.idle1 then
				task.spawn(function()
					task.wait(0.2)
					ApplyAnims(animSelected)
				end)
			end
		else
			TweenService:Create(AnimToggleBtn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(40, 44, 56)}):Play()
			TweenService:Create(ToggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
				Position = UDim2.new(0, 3, 0.5, -11)
			}):Play()
			AnimListContainer.Visible = false
			-- Restaurar animaciones por defecto al apagar
			animSelected = {}
			local char = Player.Character
			if char then
				local animate = char:FindFirstChild("Animate")
				if animate then
					animate.Enabled = false
					task.wait(0.05)
					animate.Enabled = true
				end
			end
		end
	end)

	--=========================================================
	-- TABS
	--=========================================================
	local tabs = {
		HOME        = HomePanel,
		AIMBOT      = nil,
		VISUALES    = nil,
		MOVIMIENTO  = nil,
		ANIMACIONES = AnimPanel,
		["ALTO FARM"]  = nil,
		["ALTO KILLS"] = nil,
		SETTINGS    = SettingsPanel,
	}

	local sideButtons = {}
	local activeButton = nil

	local function CreateSideButton(text, selected)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -12, 0, 34)
		btn.BackgroundColor3 = selected and C_ACCENT_SOFT or Color3.fromRGB(22, 25, 35)
		btn.BackgroundTransparency = selected and 0 or 0.25
		btn.BorderSizePixel = 0
		btn.Text = text
		btn.TextColor3 = selected and C_TEXT or C_TEXT_DIM
		btn.TextSize = 13
		btn.Font = Enum.Font.GothamBold
		btn.TextXAlignment = Enum.TextXAlignment.Center
		btn.AutoButtonColor = false
		btn.ZIndex = 2
		btn.Parent = SideMenu

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 6)
		btnCorner.Parent = btn

		local accent = Instance.new("Frame")
		accent.Size = UDim2.new(0, 3, 0, selected and 18 or 0)
		accent.Position = UDim2.new(0, 0, 0.5, selected and -9 or 0)
		accent.BackgroundColor3 = C_ACCENT
		accent.BorderSizePixel = 0
		accent.ZIndex = 4
		accent.Parent = btn

		local accentCorner = Instance.new("UICorner")
		accentCorner.CornerRadius = UDim.new(1, 0)
		accentCorner.Parent = accent

		sideButtons[text] = {button = btn, accent = accent}

		btn.MouseEnter:Connect(function()
			if activeButton == btn then return end
			TweenService:Create(btn, TweenInfo.new(0.15), {
				BackgroundColor3 = Color3.fromRGB(30, 34, 48), TextColor3 = C_TEXT
			}):Play()
		end)
		btn.MouseLeave:Connect(function()
			if activeButton == btn then return end
			TweenService:Create(btn, TweenInfo.new(0.15), {
				BackgroundColor3 = Color3.fromRGB(22, 25, 35), TextColor3 = C_TEXT_DIM
			}):Play()
		end)

		btn.MouseButton1Click:Connect(function()
			for _, data in pairs(sideButtons) do
				TweenService:Create(data.button, TweenInfo.new(0.18), {
					BackgroundColor3 = Color3.fromRGB(22, 25, 35), TextColor3 = C_TEXT_DIM
				}):Play()
				TweenService:Create(data.accent, TweenInfo.new(0.18), {
					Size = UDim2.new(0, 3, 0, 0), Position = UDim2.new(0, 0, 0.5, 0)
				}):Play()
			end

			activeButton = btn
			TweenService:Create(btn, TweenInfo.new(0.18), {
				BackgroundColor3 = C_ACCENT_SOFT, TextColor3 = C_TEXT
			}):Play()
			TweenService:Create(accent, TweenInfo.new(0.18), {
				Size = UDim2.new(0, 3, 0, 18), Position = UDim2.new(0, 0, 0.5, -9)
			}):Play()

			for _, panel in pairs(tabs) do
				if panel then panel.Visible = false end
			end
			if tabs[text] then
				tabs[text].Visible = true
			end
		end)

		if selected then activeButton = btn end
		return btn
	end

	CreateSideButton("HOME", true)
	CreateSideButton("AIMBOT", false)
	CreateSideButton("VISUALES", false)
	CreateSideButton("MOVIMIENTO", false)
	CreateSideButton("ANIMACIONES", false)
	CreateSideButton("ALTO FARM", false)
	CreateSideButton("ALTO KILLS", false)
	CreateSideButton("SETTINGS", false)

	--=========================================================
	-- FUNCIONALIDAD
	--=========================================================
	local function AnimateOpen()
		MainFrame.Size = UDim2.new(0, 530, 0, 320)
		MainFrame.BackgroundTransparency = 0.3
		TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 560, 0, 340),
			BackgroundTransparency = 0
		}):Play()
	end

	MainButton.MouseButton1Click:Connect(function()
		MainFrame.Visible = not MainFrame.Visible
		if MainFrame.Visible then AnimateOpen() end
	end)

	CloseBtn.MouseButton1Click:Connect(function()
		MainFrame.Visible = false
	end)

	-- Auto re-aplicar al respawnear
	Player.CharacterAdded:Connect(function(char)
		local animate = char:WaitForChild("Animate", 5)
		if animate and animSelected and animSelected.idle1 then
			task.wait(0.2)
			ApplyAnims(animSelected)
		end
	end)
end

LoadHub()
