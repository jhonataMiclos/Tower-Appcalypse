local composer = require( "composer" )

local scene = composer.newScene()


composer.isDebug = true

physics = require "physics"
physics.start()
physics.setGravity( 0, 0 )
--physics.setDrawMode( "hybrid" )

local enemies = require "enemies"

local enemyTank = require "enemyTank"

local SniperTower = require "sniperTower"

local NormalTower = require "NormalTower"

local MineSpawned = require "MineTower"

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here


local map  =   {{0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5},
		 		{0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		  		{0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,0,6,1,1,3,0,0},
		  		{0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,2,0,0},
			  	{0.5,0.5,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,2,0,0},
			  	{0,0,0,0,0,0,6,1,3,0,0,6,1,1,4,0,0,2,0,0},
			  	{0,0,0,0,0,0,2,0,2,0,0,2,0,0,0,0,0,2,0,0},
				{0,0,0,0,0,0,2,0,2,0,0,2,0,0,0,0,6,4,0,0},
				{1,1,1,1,3,0,2,0,5,1,1,4,0,0,0,0,2,0,0,0},
				{0,0,0,0,2,0,2,0,0,0,0,0,0,0,0,6,4,0,0,0},
				{0,0,0,0,5,1,4,0,0,0,0,0,0,0,0,2,0,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,3,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0},
				{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0}}

local AiHealth = {"HealthBar10%.png","HealthBar20%.png","HealthBar30%.png","HealthBar40%.png","HealthBar50%.png",
				 "HealthBar60%.png","HealthBar70%.png","HealthBar80%.png","HealthBar90%.png","HealthBar100%.png",}
		  
local	draging = false

local	timeToCallMoveAi = 90
local	timerToSpawn = 4000
local	timerToSpawn2 =4500
local	timerToSetNextWave = 4500

local	firstTime = true
local	waveIsOn = false
local	fastMode = false
local	wCounter = 4
local	numberOfWaves = 0
local	lastNumberOfwave = 0
local	nextWave = true

local	pHealth = 100
local	pHealthBefore = 0

local	researchAmount = 100
local	researchAmountB = 0
	
local	moves = 0
	
	
local	timerC = 0

local turretsSpawned = {}
local	tCounter = 1

local	mineSpawned = {}
local	mCounter = 1

local sniperSpawned = {}
local	sCounter = 1

local enemySpawned = {}
local	aCounter = 1

local	totalOfEnemy = 0
local	numOfSmallAi = 2
	
local	currentEnemyScanned = 1
local	numberOfEnemyPerWave = 6
local	numberOfTank = 1
local	curentTotalOfEnemy = 0

local	healthSeg = {}

local   researchSeg = {}

local	bulletSpeed1 = 200

local range
local range2

local	money = 200

local myMoney

local waveNum2

local countingDown

local menuButtom

local 	base
local	tmr6
local	tmr7
local	tmr8
local	tmr9
local	tmr10
local	tmr3
local   tmr5
local	tmr4

local backgroundMusic 
local backgroundMusicChannel
local shootMusic
local baseCollision
local pickTurret
local gainMoney
local openMenu
local researchSound 
--local infoT
-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view
    	--making the lvl


    	--backgroundMusic = audio.loadStream( "backGroundM.wav" )
		shootMusic =  audio.loadStream( "shots.wav" )
		baseCollision =  audio.loadStream( "defenceHits.wav" )
		pickTurret =  audio.loadStream( "pickTurret.wav" )
		gainMoney =audio.loadStream( "gainMoney.wav" )
		openMenu =audio.loadStream( "openMenu.wav" )
		researchSound =audio.loadStream( "research.wav" )
		--infoT =audio.loadStream( "info.wav" )
		for i = 1,20 do
					for j = 1, 15 do
					
						if map[j][i] < 1 then
						
						local	grass = display.newImage("grass.png")
								grass.anchorX=0
								grass.anchorY=0
								grass.x = (i-1)*64
								grass.y = (j-1) *64
								sceneGroup:insert(grass)
						elseif 	map[j][i] == 1	then
						local	StraightHorizontal = display.newImage("StraightHorizontal.png")
								StraightHorizontal.anchorX=0
								StraightHorizontal.anchorY=0
								StraightHorizontal.x = (i-1)*64
								StraightHorizontal.y = (j-1) *64
								sceneGroup:insert(StraightHorizontal)
							moves = moves + 1
						elseif 	map[j][i] == 2		then
							local	StraightVertical = display.newImage("StraightVertical.png")
								StraightVertical.anchorX=0
								StraightVertical.anchorY=0
								StraightVertical.x = (i-1)*64
								StraightVertical.y = (j-1) *64
								sceneGroup:insert(StraightVertical)
							moves = moves + 1

						elseif 	map[j][i] == 3			then
							local	LeftDown = display.newImage("Left-Down.png")
								LeftDown.anchorX=0
								LeftDown.anchorY=0
								LeftDown.x = (i-1)*64
								LeftDown.y = (j-1) *64
								sceneGroup:insert(LeftDown)
							moves = moves + 1

						elseif 	map[j][i] == 4		then
							local	LeftUp = display.newImage("Left-Up.png")
								LeftUp.anchorX=0
								LeftUp.anchorY=0
								LeftUp.x = (i-1)*64
								LeftUp.y = (j-1) *64
								sceneGroup:insert(LeftUp)
							moves = moves + 1
						elseif 	map[j][i] == 5			then
							local	RightUp = display.newImage("Right-Up.png")
								RightUp.anchorX=0
								RightUp.anchorY=0
								RightUp.x = (i-1)*64
								RightUp.y = (j-1) *64
								sceneGroup:insert(RightUp)
							moves = moves + 1
						elseif 	map[j][i] == 6			then
							local	RightDown = display.newImage("Right-Down.png")
								RightDown.anchorX=0
								RightDown.anchorY=0
								RightDown.x = (i-1)*64
								RightDown.y = (j-1) *64
								sceneGroup:insert(RightDown)
							moves = moves + 1
						end
					end
				end


				local HUD = display.newImage("MenuHUDBar.png")
						HUD.anchorX=0
						HUD.anchorY=0
						HUD.x = 0
						HUD.y = 0
						sceneGroup:insert(HUD)

				 menuButtom = display.newImage("Menu.png", 0, 0)
						 menuButtom.anchorX = 0
						   menuButtom.anchorY = 0
						    menuButtom.x = 0*64
						    menuButtom.y = 0*64
							menuButtom.status = 1
							sceneGroup:insert(menuButtom)
							

				local myText = display.newText( "cells:", 2.7*64, .5*64, native.systemFontBold, 25 )
						myText:setFillColor( .9, 0.3, 0.3  )
						sceneGroup:insert(myText)
				 myMoney = display.newText( money , 4*64, .5*64, native.systemFontBold, 25 )
						myMoney:setFillColor( .9, 0.3, 0.3 )
						sceneGroup:insert(myMoney)
				 countingDown = display.newText( wCounter , 10*64, .5*64, native.systemFontBold, 25 )
						countingDown:setFillColor( 1, 0, 0 )
						sceneGroup:insert(countingDown)
				local waveNum = display.newText( "wave:", 8*64, .5*64, native.systemFontBold, 25 )
								waveNum:setFillColor( .9, 0.3, 0.3 )
						sceneGroup:insert(waveNum)
				 waveNum2 = display.newText( numberOfWaves, 8.9*64, .5*64, native.systemFontBold, 25 )
						waveNum2:setFillColor( .9, 0.3, 0.3 )
						sceneGroup:insert(waveNum2)

					
						



				local  healthBar = display.newImage("PlayerHealthBar.png")
						healthBar.anchorX = 0
						healthBar.anchorY = 0
						healthBar.x = 17*64
						healthBar.y = 0.5*64
						sceneGroup:insert(healthBar)

				



				local  researchBar = display.newImage("ResearchBar.png")
						researchBar.anchorX = 0
						researchBar.anchorY = 0
						researchBar.x = 17*64
						researchBar.y = 0.1*64
						sceneGroup:insert(researchBar)

    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then

    		--backgroundMusicChannel = audio.play( backgroundMusic, { loops=-1 , fadein=5000} )
    				base = display.newImage("Gate.png")
						base.anchorX = 0
						base.anchorY = 0
						base.x = 15*64
						base.y = 14*64
						base.id = 12
						sceneGroup:insert(base)
						physics.addBody(base,"dynamic",{density = 1,bounce = 0,friction = .9,radius = 30 })


    					--bit of health 
						for i=1,pHealth - 5 do
							healthSeg[i] = display.newImage("PlayerHealth.png")
							healthSeg[i].anchorX = 0
							healthSeg[i].anchorY = 0
							healthSeg[i].x = (20*64)- (i*2)
							healthSeg[i].y = 0.53*64
							sceneGroup:insert(healthSeg[i])
						end



    					--bit of research
						for i=1,researchAmount - 5 do
							researchSeg[i] = display.newImage("ResearchSeg.png")
							researchSeg[i].anchorX = 0
							researchSeg[i].anchorY = 0
							researchSeg[i].x = (20*64)- (i*2)
							researchSeg[i].y = 0.13*64	
							sceneGroup:insert(researchSeg[i])
						end


		-- health display and research

		function PlayerHealth(event )
			if 	pHealth ~= pHealthBefore	then
				for i=100,pHealth - 5,-1 do
					display.remove(healthSeg[i] )
				end
				pHealthBefore = pHealth
				print(pHealth)
			end

			if 	researchAmount ~= researchAmountB	then
					for i=100,researchAmount - 5,-1 do
						display.remove(researchSeg[i] )
						
					end
					researchAmountB = researchAmount
					print(researchAmount)
				end

		end





--spawning all the enemies and seting up next waves
--===============================================================================================================================================##

		--this spawns the normal enemies
		function spawnAi()
			curentTotalOfEnemy = curentTotalOfEnemy +1
			for x1 = 1,15 do
				if map[x1][1] == 1 then 
					--enemySpawned[aCounter] = enemies.enemiesTypes[1]

					enemySpawned[aCounter] = display.newImage("proto.png")	
					enemySpawned[aCounter].anchorX=0.5
					enemySpawned[aCounter].anchorY=0.5
					enemySpawned[aCounter].x = (0)*64 +32
					enemySpawned[aCounter].y =  (x1-1)* 64  + 32
					enemySpawned[aCounter].speed = enemies.speed
					enemySpawned[aCounter].health = enemies.health
					--enemySpawned[aCounter].healthImage = display.newImage(AiHealth[10])
					--enemySpawned[aCounter].healthImage.anchorX=0
					--enemySpawned[aCounter].healthImage.anchorY=0.5
					--enemySpawned[aCounter].healthImage.x =(0)*64
					--enemySpawned[aCounter].healthImage.y =(x1-1)* 64 
					enemySpawned[aCounter].lastX = enemies.lastX
					enemySpawned[aCounter].lastY = enemies.lastY
					enemySpawned[aCounter].id = aCounter
					enemySpawned[aCounter].type = enemies.type
					enemySpawned[aCounter].timer = enemies.timer
					enemySpawned[aCounter].coolDown = enemies.cooldown
					enemySpawned[aCounter].resource = enemies.resource
					enemySpawned[aCounter].damage = enemies.damage
					physics.addBody(enemySpawned[aCounter],"static",{density = .1,bounce = 0.1,friction = .2,radius = 20 })
					--enemySpawned[aCounter].x = (0)*64
					--enemySpawned[aCounter].x = (x1-1)*64
					--enemySpawned[aCounter].id = aCounter
					sceneGroup:insert(enemySpawned[aCounter])
					--sceneGroup:insert(enemySpawned[aCounter].healthImage)
					enemySpawned[aCounter].collision = onCollision
					enemySpawned[aCounter]:addEventListener( "collision", enemySpawned[aCounter] )
				end
			end
			
			enemySpawned[aCounter].enterFrame = CallmoveAi
			Runtime:addEventListener("enterFrame",enemySpawned[aCounter])
			--print(aCounter)
			aCounter = aCounter + 1
			totalOfEnemy = totalOfEnemy + 1
			--curentTotalOfEnemy = totalOfEnemy
		end

		--this spawns the Tanks
		function spawnAiTank()
			curentTotalOfEnemy = curentTotalOfEnemy +1
			for x1 = 1,15 do
				if map[x1][1] == 1 then 
					--enemySpawned[aCounter] = enemies.enemiesTypes[1]

					enemySpawned[aCounter] = display.newImage("Tank.png")--i googled this for 2d top view image i couldnt find the creator but this is the url  https://www.google.com/search?sa=G&hl=en&q=pattern&tbm=isch&tbs=simg:CAQSjAEaiQELEKjU2AQaAggKDAsQsIynCBpiCmAIAxIooQizCK8IuQiHA7oImAO0CKIIowi0NLM0lCS1NJMn_1jPhKa80rTSxNBow0VMYoAu30jOjY9vSoagrOPfrKd6qg5biCi6YtOf8CFXIEYSHZjZPYc5iwnylk84tIAMMCxCOrv4IGgoKCAgBEgQnbOx4DA&ved=0ahUKEwiV-baqhqLMAhXICsAKHcWpB60Qwg4IGigA&biw=1920&bih=947#imgrc=6L_fQdl37jEBuM%3A	
					enemySpawned[aCounter].anchorX=0.5
					enemySpawned[aCounter].anchorY=0.5
					enemySpawned[aCounter].x = (0)*64 + 32
					enemySpawned[aCounter].y =  (x1-1)* 64 + 32
					enemySpawned[aCounter].speed = enemyTank.speed
					enemySpawned[aCounter].health = enemyTank.health
					--enemySpawned[aCounter].healthImage = display.newImage(AiHealth[10])
					--enemySpawned[aCounter].healthImage.anchorX=0
					--enemySpawned[aCounter].healthImage.anchorY=0.5
					--enemySpawned[aCounter].healthImage.x =(0)*64
					--enemySpawned[aCounter].healthImage.y =(x1-1)* 64
					enemySpawned[aCounter].lastX = enemyTank.lastX
					enemySpawned[aCounter].lastY = enemyTank.lastY
					enemySpawned[aCounter].id = aCounter
					enemySpawned[aCounter].type = enemyTank.type
					enemySpawned[aCounter].timer = enemyTank.timer
					enemySpawned[aCounter].coolDown = enemyTank.cooldown
					enemySpawned[aCounter].resource = enemyTank.resource
					enemySpawned[aCounter].damage = enemyTank.damage
					physics.addBody(enemySpawned[aCounter],"static",{density = .1,bounce = 0.1,friction = .2,radius = 30 })
					--enemySpawned[aCounter].x = (0)*64
					--enemySpawned[aCounter].x = (x1-1)*64
					--enemySpawned[aCounter].id = aCounter
					sceneGroup:insert(enemySpawned[aCounter])
					--sceneGroup:insert(enemySpawned[aCounter].healthImage)
					enemySpawned[aCounter].collision = onCollision
					enemySpawned[aCounter]:addEventListener( "collision", enemySpawned[aCounter] )
				end
			end
			
			enemySpawned[aCounter].enterFrame = CallmoveAi
			Runtime:addEventListener("enterFrame",enemySpawned[aCounter])
			--print(aCounter)
			aCounter = aCounter + 1
			totalOfEnemy = totalOfEnemy + 1
			--curentTotalOfEnemy = totalOfEnemy
		end


		function setNextWave()
			waveIsOn = false
		end

		function checkForNextWave()
			--print(curentTotalOfEnemy)
			if 	waveIsOn == false and curentTotalOfEnemy == 0	then
				
				numberOfEnemyPerWave = 10 + (numberOfWaves*numOfSmallAi)
				numberOfTank = numberOfTank + (math.floor(numberOfWaves/2))
					tmr6 = timer.performWithDelay( 0, countDown, 1)
					tmr7 = timer.performWithDelay( 1000, countDown, 1)
					tmr8 = timer.performWithDelay( 2000, countDown, 1)
					tmr9 = timer.performWithDelay( 3000, countDown, 1)
					tmr10 = timer.performWithDelay( 4000, countDown, 1)
					tmr3 = timer.performWithDelay( timerToSpawn, spawnAi, numberOfEnemyPerWave)
					waveIsOn = true 
					nextWave = true
					numberOfWaves = numberOfWaves + 1
					if numberOfWaves > 1 then 
						tmr5 = timer.performWithDelay( timerToSpawn2, spawnAiTank, numberOfTank )
					end
					tmr4 = timer.performWithDelay( timerToSetNextWave, setNextWave, 1)
				print(numberOfWaves)
			 end
		end

		function countDown()

			if wCounter == 0 then
				wCounter = " "
				countingDown.text =  wCounter
				 wCounter = 4
			elseif 	wCounter > 0		then
				countingDown.text = wCounter
				wCounter = wCounter - 1
			end	
		end




--===============================================================================================================================================##
--===============================================================================================================================================##






--spawning the turrets the menu dropdwon and also moving the turrets with the touch and also the buying of the research
--===============================================================================================================================================##

		--moving normal turret
		function touch(self,event)
			
			--if 	self.moving == true		then

				if event.phase == "began" then
					 range.isVisible = true
					  local movingTurret =audio.play(pickTurret)
						--print("touch")
						self.markX = self.x
						self.markY = self.y
						self.moving = true
					elseif event.phase == "moved" then	
						if 	self.moving == true		then
							 x = (event.x - event.xStart) + self.markX
							 y =(event.y - event.yStart) + self.markY
							
							self.x,self.y = x , y 
							range.x = x +32
							range.y = y +32
						end
					end
					if event.phase == "ended" then
						
						--print("ended")
						if	self.moving == true then
							if 	x < 0	then
								x = 0
							end
							if 	y < 0	then
								y = 0
							end
							if 	map[math.floor(y / 64)+ 1][math.floor(x / 64)+1] < 0.5 and money >= self.price then
								self.x,self.y = math.floor(x / 64)*64 ,math.floor(y / 64)*64
								local movingTurret =audio.play(pickTurret)
								money = money - self.price
								range.x = 0 +32
								range.y = 64 +32
								 range.isVisible = false
								self.enterFrame = CallcheckAi
								Runtime:addEventListener("enterFrame",self)
								self:removeEventListener("touch",self)
								tCounter = tCounter + 1 
								--print(self.id)
							--	if 	self.id	== 30	then
								--	turretsSpawned[tCounter]= display.newImage(NormalTower.image)
								--end
								
							turretsSpawned[tCounter]= display.newImage(self.image)
								turretsSpawned[ tCounter ].image = self.image
								turretsSpawned[tCounter].anchorX= 0
								turretsSpawned[tCounter].anchorY= 0
								turretsSpawned[tCounter].x = self.placeInMenuX
								turretsSpawned[tCounter].y = self.placeInMenuY
								turretsSpawned[ tCounter ].coolDown = self.coolDown
								turretsSpawned[ tCounter ].timer = self.timer
								turretsSpawned[ tCounter ].range = self.range
								turretsSpawned[ tCounter ].price = self.price 
								turretsSpawned[ tCounter ].ammo = self.ammo
								turretsSpawned[ tCounter ].ammoImage = self.ammoImage
								turretsSpawned[ tCounter ].damage  = self.damage
								--turretsSpawned[ tCounter ].id = 
								turretsSpawned[ tCounter ].moving = false
								turretsSpawned[ tCounter ].removeTime =self.removeTime
								turretsSpawned[ tCounter ].placeInMenuX =self.placeInMenuX
								turretsSpawned[ tCounter ].placeInMenuY = self.placeInMenuY
								sceneGroup:insert(turretsSpawned[ tCounter ])
								turretsSpawned[ tCounter ].touch = touch
								turretsSpawned[ tCounter ]:addEventListener("touch",turretsSpawned[ tCounter ])
								
							else
								turretsSpawned[tCounter].x =  turretsSpawned[ tCounter ].placeInMenuX
								turretsSpawned[tCounter].y = 	turretsSpawned[ tCounter ].placeInMenuY
								local movingTurret =audio.play(pickTurret)
								range.x = 0 +32
								range.y = 64 +32
								range.isVisible = false
							end
							self.moving = false
							
						end
					end

			--end 
		end	





		--moving sniper turret
		function sniperTouch(self,event)
			

				if event.phase == "began" then
					range2.isVisible = true
					local movingTurret =audio.play(pickTurret)
					--self.moving = true
					--print("touch")
					self.markX = self.x
					self.markY = self.y
					self.moving = true

				elseif event.phase == "moved" then
					if 	self.moving == true	then
						 x1 = (event.x - event.xStart) + self.markX
						 y1 =(event.y - event.yStart) + self.markY
						--print(x)
						-- print(x)
						-- print(math.floor(x / 64))
						-- print(math.floor(y / 64))
						self.x,self.y = x1 , y1 
						range2.x = x1 +32
						range2.y = y1 +32
					end
				end
				if event.phase == "ended" then
					--print("ended")
					if	self.moving == true then
						if 	x1 < 0	then
								x1 = 0
							end
							if 	y1 < 0	then
								y1 = 0
							end
						if 	map[math.floor(y1 / 64)+ 1][math.floor(x1 / 64)+1] < 0.5 and money >= self.price then
							self.x,self.y = math.floor(x1 / 64)*64 ,math.floor(y1 / 64)*64
							money = money - self.price
							local movingTurret =audio.play(pickTurret)
							range2.x = 0 +32
							range2.y = 128+32
							range2.isVisible = false
							self.enterFrame = CallcheckAi
							Runtime:addEventListener("enterFrame",self)
							self:removeEventListener("touch",self)
							sCounter = sCounter + 1 
							
							sniperSpawned[ sCounter   ]= display.newImage(self.image)
							sniperSpawned[ sCounter   ].image = self.image
							sniperSpawned[ sCounter   ].anchorX=0
							sniperSpawned[ sCounter   ].anchorY=0 
							sniperSpawned[ sCounter   ].x = self.placeInMenuX
							sniperSpawned[ sCounter   ].y = self.placeInMenuY
							sniperSpawned[ sCounter   ].coolDown = self.coolDown
							sniperSpawned[ sCounter   ].timer = self.timer
							sniperSpawned[ sCounter   ].range = self.range
							sniperSpawned[ sCounter   ].price = self.price 
							sniperSpawned[ sCounter   ].ammo = self.ammo
							sniperSpawned[ sCounter   ].ammoImage = self.ammoImage
							sniperSpawned[ sCounter   ].damage  = self.damage
							sniperSpawned[ sCounter   ].removeTime = self.removeTime
							sniperSpawned[ sCounter   ].moving = false
							sniperSpawned[ sCounter   ].placeInMenuX = self.placeInMenuX
							sniperSpawned[ sCounter   ].placeInMenuY = self.placeInMenuY
							sceneGroup:insert(sniperSpawned[ sCounter   ])
							sniperSpawned[ sCounter   ].touch = sniperTouch
							sniperSpawned[ sCounter   ]:addEventListener("touch",sniperSpawned[ sCounter   ])
							--turretsSpawned[tCounter]:addEventListener("touch",touch)
						else
							sniperSpawned[ sCounter   ].x =  sniperSpawned[ sCounter   ].placeInMenuX
							sniperSpawned[ sCounter   ].y = 	sniperSpawned[ sCounter   ].placeInMenuY
							local movingTurret =audio.play(pickTurret)
							range2.x = 0 +32
							range2.y =128+32
							range2.isVisible = false
						end
						self.moving = false 
						--turretsSpawned[ tCounter ].enterFrame = CallcheckAi
						--Runtime:addEventListener("enterFrame",turretsSpawned[ tCounter ])
						--print(tCounter)
					--turret:addEventListener("touch",turret)
					--self:removeEventListener("touch",turret)	
					
					end
				end

				--end 
		end




		---moving mine
		function mineTouch(self,event)
			
			--if	self.moving == true then
				if event.phase == "began" then
					local movingTurret =audio.play(pickTurret)
					--self.moving = true
					--print("touch")
					mineSpawned[mCounter ].markX = mineSpawned[mCounter ].x
					mineSpawned[mCounter ].markY = mineSpawned[mCounter ].y
					self.moving = true
				elseif event.phase == "moved" then	
					if	self.moving == true then
						 x2 = (event.x - event.xStart) + mineSpawned[mCounter ].markX
						 y2 =(event.y - event.yStart) + mineSpawned[mCounter ].markY
						--print(x)
						-- print(x)
						-- print(math.floor(x / 64))
						-- print(math.floor(y / 64))
						mineSpawned[mCounter ].x,mineSpawned[mCounter ].y = x2 , y2
					end
				end
				if event.phase == "ended" then
					--print("ended")
					if	self.moving == true then
						if 	x2 < 0	then
								x2 = 0
							end
							if 	y2 < 0	then
								y2 = 0
							end
						if 	map[math.floor(y2 / 64)+ 1][math.floor(x2 / 64)+1] > 0.5 and money >= mineSpawned[mCounter ].price then
							mineSpawned[mCounter ].x,mineSpawned[mCounter ].y = math.floor(x2 / 64)*64 ,math.floor(y2 / 64)*64
							money = money - mineSpawned[mCounter ].price
							local movingTurret =audio.play(pickTurret)
							--mineSpawned[mCounter ].enterFrame = CallcheckAi
							--Runtime:addEventListener("enterFrame",sniperSpawned[ sCounter   ])
							physics.addBody(mineSpawned[mCounter ],"dynamic",{density = 1,bounce = 0,friction = .9,radius = 30 })
							mineSpawned[mCounter ]:removeEventListener("touch",mineSpawned[mCounter ])
							mCounter = mCounter + 1 
							
							mineSpawned[mCounter ]= display.newImage(MineTower.image)
							mineSpawned[mCounter ].anchorX=0
							mineSpawned[mCounter ].anchorY=0
							mineSpawned[mCounter ].x = self.placeInMenuX
							mineSpawned[mCounter ].y = self.placeInMenuY
							mineSpawned[mCounter ].price = self.price 
							mineSpawned[mCounter ].damage  = self.damage
							mineSpawned[mCounter ].id = self.id
							mineSpawned[mCounter ].moving = false
							mineSpawned[mCounter ].placeInMenuX = self.placeInMenuX
							mineSpawned[mCounter ].placeInMenuY = self.placeInMenuY
							sceneGroup:insert(mineSpawned[mCounter ])
							mineSpawned[mCounter ].touch = mineTouch
							mineSpawned[mCounter ]:addEventListener("touch",mineSpawned[mCounter ])
						else
							mineSpawned[mCounter ].x = mineSpawned[mCounter ].placeInMenuX
							mineSpawned[mCounter ].y = mineSpawned[mCounter ].placeInMenuY
							local movingTurret =audio.play(pickTurret)
						end
						self.moving = false
						--turretsSpawned[ tCounter ].enterFrame = CallcheckAi
						--Runtime:addEventListener("enterFrame",turretsSpawned[ tCounter ])
						--print(tCounter)
					--turret:addEventListener("touch",turret)
					--self:removeEventListener("touch",turret)	
					
					end
				end


		end	




		function buyResearch(self,event )
			if money >= 100			then
				local researchM = audio.play(researchSound)
				money = money -100
				researchAmount = researchAmount - 10

			end
		end

		function closeInfo(self,event)
			display.remove(self)
		end

		function infoTouch(self,event )

			if event.phase == "began" then
			--	local infoSound = audio.play(infoT)
					if self.id == 0			then

						infoD = display.newImage("infoN.png")
						infoD.anchorX = 0
						infoD.anchorY = 0
						infoD.x = self.x + 20
						infoD.y = self.y
						infoD.tap = closeInfo
						infoD:addEventListener("tap",infoD)
					elseif	self.id == 1			then
						infoD = display.newImage("infoS.png")
						infoD.anchorX = 0
						infoD.anchorY = 0
						infoD.x = self.x + 20
						infoD.y = self.y
						infoD.tap = closeInfo
						infoD:addEventListener("tap",infoD)
					elseif	self.id == 2			then
						infoD = display.newImage("infoM.png")
						infoD.anchorX = 0
						infoD.anchorY = 0
						infoD.x = self.x + 20
						infoD.y = self.y
						infoD.tap = closeInfo
						infoD:addEventListener("tap",infoD)
					elseif	self.id == 4			then
						infoD = display.newImage("infoR.png")
						infoD.anchorX = 0
						infoD.anchorY = 0
						infoD.x = self.x + 20
						infoD.y = self.y
						infoD.tap = closeInfo
						infoD:addEventListener("tap",infoD)
					end
			end

			if event.phase == "ended" or event.phase == "cancelled"then
					display.remove(infoD)
			end --info about the features of the game
		end
			


		--menu display
		function menuTouch(self,event)
			if	draging == false	 then 

				if event.phase == "began" then
					local dropMenu = audio.play(openMenu)
					--draging = false
						--print("touch")
					if	self.status == 1	then
						 --menuButtom:removeEventListener("touch",menuTouch)
							  menu = display.newImage("dropdown.png")
							  menu.anchorX = 0
							  menu.anchorY = 0
							  menu.x = 0*64
							  menu.y = 1*64
							  sceneGroup:insert(menu)

						 researchBott = display.newImage("ResearchFlask.png")
							  researchBott.anchorX = 0
							  researchBott.anchorY = 0
							  researchBott.x = 0*64
							  researchBott.y = 4*64
							   sceneGroup:insert(researchBott)
							  researchBott.tap = buyResearch
							  researchBott:addEventListener("tap",researchBott)

						quitB = display.newImage("quit.png")
								quitB.anchorX = 0
								quitB.anchorY = 0
								quitB.x = 0*64
							  	quitB.y = 4.64*64
							  	 sceneGroup:insert(quitB)
							  	quitB.tap = quitGame
							 	quitB:addEventListener("tap",quitB)

						infoR = display.newImage("info.png")
							infoR.anchorX=0
							infoR.anchorY= 0
							infoR.x = researchBott.x +74
							infoR.y = researchBott.y
							infoR.id = 4
							 sceneGroup:insert(infoR)
							infoR.touch = infoTouch
							infoR:addEventListener("touch",infoR)

							range = display.newImage("NormalRange.png")
							range.anchorX= 0.5
							range.anchorY= 0.5
							range.x = 0 +32
							range.y = 64+32
							sceneGroup:insert(range)
							range.isVisible = false
						turretsSpawned[ tCounter ]= display.newImage(NormalTower.image)
							turretsSpawned[ tCounter ].image = NormalTower.image
							turretsSpawned[ tCounter ].anchorX=0
							turretsSpawned[ tCounter ].anchorY=0
							turretsSpawned[ tCounter ].x =  NormalTower.placeInMenuX
							turretsSpawned[ tCounter ].y = 	NormalTower.placeInMenuY
							turretsSpawned[ tCounter ].coolDown = NormalTower.coolDown
							turretsSpawned[ tCounter ].timer = NormalTower.timer
							turretsSpawned[ tCounter ].range = NormalTower.range
							turretsSpawned[ tCounter ].price = NormalTower.price
							turretsSpawned[ tCounter ].ammo = NormalTower.ammo
							turretsSpawned[ tCounter ].ammoImage = NormalTower.ammoImage
							turretsSpawned[ tCounter ].damage =  NormalTower.damage
							turretsSpawned[ tCounter ].removeTime = NormalTower.removeTime
							turretsSpawned[ tCounter ].id = NormalTower.id
							turretsSpawned[ tCounter ].moving = NormalTower.moving
							turretsSpawned[ tCounter ].placeInMenuX = NormalTower.placeInMenuX
							turretsSpawned[ tCounter ].placeInMenuY = NormalTower.placeInMenuY
							 sceneGroup:insert(turretsSpawned[ tCounter ])
							turretsSpawned[ tCounter ].touch = touch
							turretsSpawned[ tCounter ]:addEventListener("touch",turretsSpawned[ tCounter ])
							--turretsSpawned[tCounter]:addEventListener("touch",touch)

							infoN = display.newImage("info.png")
							infoN.anchorX=0
							infoN.anchorY= 0
							infoN.x =  NormalTower.placeInMenuX +74
							infoN.y =NormalTower.placeInMenuY
							infoN.id = 0
							 sceneGroup:insert(infoN)
							infoN.touch = infoTouch
							infoN:addEventListener("touch",infoN)

							range2 = display.newImage("SniperRange.png")
							range2.anchorX= 0.5
							range2.anchorY= 0.5
							range2.x = 0 +32
							range2.y = 128+32
							sceneGroup:insert(range2)
							range2.isVisible = false

							sniperSpawned[ sCounter   ]= display.newImage(SniperTower.image)
							sniperSpawned[ sCounter ].image = SniperTower.image
							sniperSpawned[ sCounter   ].anchorX=0
							sniperSpawned[ sCounter   ].anchorY=0
							sniperSpawned[ sCounter   ].x =  SniperTower.placeInMenuX
							sniperSpawned[ sCounter   ].y = 	SniperTower.placeInMenuY
							sniperSpawned[ sCounter   ].coolDown = SniperTower.coolDown
							sniperSpawned[ sCounter   ].timer = SniperTower.timer
							sniperSpawned[ sCounter   ].range = SniperTower.range
							sniperSpawned[ sCounter   ].price = SniperTower.price
							sniperSpawned[ sCounter   ].ammo = SniperTower.ammo
							sniperSpawned[ sCounter   ].ammoImage = sniper.ammoImage
							sniperSpawned[ sCounter   ].damage =  SniperTower.damage
							sniperSpawned[ sCounter ].moving = SniperTower.moving
							sniperSpawned[ sCounter   ].removeTime = SniperTower.removeTime
							sniperSpawned[ sCounter   ].placeInMenuX = SniperTower.placeInMenuX
							sniperSpawned[ sCounter   ].placeInMenuY = SniperTower.placeInMenuY
							 sceneGroup:insert(sniperSpawned[ sCounter   ])
							sniperSpawned[ sCounter   ].touch = sniperTouch
							sniperSpawned[ sCounter   ]:addEventListener("touch",sniperSpawned[ sCounter ])

							infoS = display.newImage("info.png")
							infoS.anchorX=0
							infoS.anchorY= 0
							infoS.x =  SniperTower.placeInMenuX +74
							infoS.y =SniperTower.placeInMenuY
							infoS.id = 1
							 sceneGroup:insert(infoS)
							infoS.touch = infoTouch
							infoS:addEventListener("touch",infoS)


							mineSpawned[mCounter ] = display.newImage(MineTower.image)
							mineSpawned[mCounter ].image = MineTower.image
							mineSpawned[mCounter ].anchorX = 0
							mineSpawned[mCounter ].anchorY = 0
							mineSpawned[mCounter ].x = MineTower.placeInMenuX
							mineSpawned[mCounter ].y = MineTower.placeInMenuY
							mineSpawned[mCounter ].price = MineTower.price
							mineSpawned[mCounter ].damage = MineTower.damage
							mineSpawned[mCounter ].placeInMenuX = MineTower.placeInMenuX
							mineSpawned[mCounter ].placeInMenuY = MineTower.placeInMenuY
							mineSpawned[mCounter ].id = MineTower.id
							mineSpawned[mCounter ].moving = MineTower.moving
							 sceneGroup:insert(mineSpawned[mCounter ] )
							mineSpawned[mCounter ].touch = mineTouch
							mineSpawned[mCounter ]:addEventListener("touch",mineSpawned[mCounter ])

							infoM = display.newImage("info.png")
							infoM.anchorX=0
							infoM.anchorY= 0
							infoM.x =  MineTower.placeInMenuX +74
							infoM.y =MineTower.placeInMenuY
							infoM.id = 2
							 sceneGroup:insert(infoM)
							infoM.touch = infoTouch
							infoM:addEventListener("touch",infoM)

						self.status = 2
					elseif	self.status == 2	then
						local dropMenu = audio.play(openMenu)
							display.remove( menu )
							display.remove(turretsSpawned[ tCounter ])
							--display.remove(turretsSpawned[ tCounter-1])
							display.remove(sniperSpawned[ sCounter   ])
							display.remove(mineSpawned[mCounter  ])
							display.remove(researchBott)
							display.remove(quitB)
							display.remove(infoM)
							display.remove(infoN)
							display.remove(infoS)
							display.remove(infoR)
							self.status = 1
					end

						
				end
			

			end 
			
			
		end




--==================================================================================================================================================##
--==================================================================================================================================================##


			





--moving of the enemies and scanning of the enemies for the turrets also shooting the enemies and colisons and removing the bullets if it doesnt collide
--==================================================================================================================================================##
				
			-- calling the function to move the AI  
			function CallmoveAi(self,event)
				  self.timer = self.timer + 1
				  if(self.timer/ self.coolDown == 1) then
					moveAi(self)
					self.timer = 0
				  end  						
			end



			--moving the AI
			function moveAi(self)
				--local XInPix,YInPix= self:localToContent( - 32, -32)
				local xToMove=math.floor(self.x/64)
				local yToMove=math.floor(self.y/64)
				local oldX = math.floor(self.x/64) +1
				local oldY = math.floor(self.y/64) + 1

				--print(oldX ..","..oldY .. ":"..self.id)
				--print(self.lastX ..","..self.lastY.. ":"..self.id)
				if 	map[oldY- 1][oldX] ~= 0 and (oldX ~= self.lastX or oldY-	1 ~= self.lastY) then
					self.rotation  = -90
					transition.to(self,{time = self.speed, x = (xToMove*64) + 32 , y= ((yToMove-1)*64)+ 32})
					--transition.to(self.healthImage,{time = self.speed, x = (xToMove-1) *64 +64 , y= yToMove*64 -64 })
					self.lastX =oldX
					self.lastY =oldY
					--self.healthImage.x=oldX-32
					--self.healthImage.y=oldY -32
					firstTime = false

				elseif 	map[oldY + 1][oldX] ~= 0 and (oldX ~= self.lastX or oldY+ 1 ~= self.lastY )then
					self.rotation  = 90
					transition.to(self,{time = self.speed, x = xToMove*64 + 32, y= (yToMove+1)*64 +32})
					--transition.to(self.healthImage,{time = self.speed, x = (xToMove-1) *64 +64 , y= yToMove*64 +64 })
					self.lastX =oldX
					self.lastY =oldY
					--self.healthImage.x=oldX-32
					--self.healthImage.y=oldY -32
					firstTime = false
				elseif 	map[oldY][oldX + 1] ~= 0 and (oldX +1 ~= self.lastX  or oldY ~= self.lastY) then
					self.rotation  = 360
					transition.to(self,{time = self.speed, x = (xToMove+1) *64  + 32, y= yToMove*64  + 32})
					--transition.to(self.healthImage,{time = self.speed, x = (xToMove-1) *64 +128 , y= yToMove*64  })
					self.lastX =oldX
					self.lastY =oldY
					--self.healthImage.x=oldX-32
					--self.healthImage.y=oldY -32
					firstTime = false
				elseif firstTime == false	then
					if	map[oldY][oldX - 1] ~= 0 and (oldX -1 ~= self.lastX  or oldY ~= self.lastY)	then
						self.rotation  = 180
						transition.to(self,{time = self.speed, x = (xToMove-1) *64  + 32, y= yToMove*64  + 32})
						--transition.to(self.healthImage,{time = self.speed, x = (xToMove-1) *64 , y= yToMove*64  })
						self.lastX =oldX
						self.lastY =oldY
						--self.healthImage.x=oldX-32
						--self.healthImage.y=oldY -32
					
					end   
				end    		
			end




			-- the scanning of the AI so the tower can shoot
			function CallcheckAi(self,event)
				local hasAenemy = false
				local enemyToAttack = 0
				local c1 = 1 
				--print("called")
				 -- print (totalOfEnemy)
					TxAxis,TyAxis = self:localToContent( - 32, -32)
					TxAxis = TxAxis/64
					TyAxis = TyAxis/64
					
				 if( self.timer/self.coolDown == 1) then
					
					 if next(enemySpawned) ~= nil	then
						
						 -- print("goes in if")
						if  hasAenemy == false	then
							while c1 <= totalOfEnemy	and hasAenemy == false do
									if 	enemySpawned[c1] ~= nil	then
										
										AixAxis,AiyAxis = enemySpawned[c1]:localToContent( - 32, -32)
										AixAxis = AixAxis/64
										AiyAxis = AiyAxis/64
										--print("goes in loop")
										if	(TxAxis - AixAxis <= self.range and TxAxis - AixAxis >= self.range * -1) and (TyAxis - AiyAxis <= self.range and TyAxis - AiyAxis >= self.range* -1 ) then
											--print("goes in if 2")
											if   hasAenemy == false	then
												enemyToAttack = c1
												hasAenemy = true
											end
											shootAi(enemySpawned[enemySpawned[enemyToAttack].id],self)
											self.timer = 0
										else
											hasAenemy = false
										end
									
									end
									c1 = c1 + 1
							end
						elseif	hasAenemy == true and (TxAxis - enemySpawned[enemySpawned[enemyToAttack].id].x -32 <= self.range and TxAxis - enemySpawned[enemySpawned[enemyToAttack].id].x -32 >= self.range * -1) and (TyAxis - enemySpawned[enemySpawned[enemyToAttack].id].y -32 <= self.range and TyAxis - enemySpawned[enemySpawned[enemyToAttack].id].y -32 >= self.range* -1 )	then
							shootAi(enemySpawned[enemySpawned[enemyToAttack].id],self)
						else
							hasAenemy = false
						end
						
						 -- checkAi(self,enemySpawned[currentEnemyScanned])
						 
					 end
					  
				 end
				 if	self.timer < self.coolDown	 then
					self.timer =  self.timer + 1
				 end
				 
			end



			--shooting the AI
			function shootAi(self,self2)
				--print(self2.damage)
					if self ~= nil	then

						--local xAxis,yAxis = self:localToContent( -64, -64 )
						local xAxis = self.x - 32
						local yAxis = self.y - 32
						local turertX,turretY = self2:localToContent( -32, -32 )
						 self2.ammo = display.newImage(self2.ammoImage)
							self2.ammo.anchorX=0
							self2.ammo.anchorY=0
							self2.ammo.x =   turertX
							self2.ammo.y =	turretY
							self2.ammo.damage =  self2.damage
							self2.ammo.id = 123
							self2.ammo.timer = 0
							self2.ammo.bulletSpeed = bulletSpeed1
							self2.ammo.removeTimer = self2.removeTime
							physics.addBody(self2.ammo,"dynamic",{density = 0,bounce = 0.1,friction = .2 ,radius = 8})
							self2.ammo.enterFrame = removeBullet
							Runtime:addEventListener("enterFrame",self2.ammo)
							if self ~= nil	then
								local shootMusicChannel = audio.play(shootMusic)
								transition.to(self2.ammo,{time = self2.ammo.bulletSpeed, x = xAxis , y= yAxis  })
							end
					end
					
			end

			--removes the bullet if the enemy died before it go hit
			function removeBullet(self,event) 
				self.timer = self.timer + 1
				--print(self.timer)
				if 	self.timer / self.removeTimer == 1	then
					display.remove(self)
					Runtime:removeEventListener("enterFrame",self)
				end
			end

			-- this handles the collision for AI and bullets and also AI and the base
			function onCollision(self,event)
				--print("colide")
				if event.phase == "began" then
					if event.other.id == 123	then
						display.remove( event.other )
						Runtime:removeEventListener("enterFrame",event.other)
						self.health = self.health - event.other.damage
						--AiHealthDisplay(self)
						if 	enemySpawned[self.id].health <= 0	then 
							display.remove( self )
							--display.remove( self.healthImage )
							money = money + self.resource
							local moremoney =audio.play(gainMoney)
							Runtime:removeEventListener("enterFrame",enemySpawned[self.id])
							enemySpawned[self.id]:removeEventListener("collision",enemySpawned[self.id])
							enemySpawned[self.id] = nil
						curentTotalOfEnemy = curentTotalOfEnemy - 1
						end
						
					elseif 	event.other.id == 12	then
						display.remove( self )
						display.remove( self.healthImage )
						Runtime:removeEventListener("enterFrame",enemySpawned[self.id])
						enemySpawned[self.id]:removeEventListener("collision",enemySpawned[self.id])
						enemySpawned[self.id] = nil
						pHealth = pHealth - self.damage
						curentTotalOfEnemy = curentTotalOfEnemy - 1
						local baseGotHit = audio.play(baseCollision)

					elseif 	event.other.id == 20	then
						display.remove( event.other )
						--Runtime:removeEventListener("enterFrame",event.other)
						self.health = self.health - event.other.damage
						--AiHealthDisplay(self)
						if 	enemySpawned[self.id].health <= 0	then 
							display.remove( self )
							--display.remove( self.healthImage )
							money = money + self.resource
							local moremoney =audio.play(gainMoney)
							Runtime:removeEventListener("enterFrame",enemySpawned[self.id])
							enemySpawned[self.id]:removeEventListener("collision",enemySpawned[self.id])
							enemySpawned[self.id] = nil
						curentTotalOfEnemy = curentTotalOfEnemy - 1
						end
					end
					--print(event.other.damage)
					
				end
				
			end

--===================================================================================================================================##
--===================================================================================================================================##




--small and random and simple function with different uses self explanatory
--===================================================================================================================================##

			function AiHealthDisplay(self)
				x5= self.healthImage.x
				y5 = self.healthImage.y
				if 	self.health > 0	then
					if 	self.type == 1 then
						--display.remove(self.healthImage)
						self.healthImage.isVisible = false

						if math.floor(self.health/30) < 1 then 
							self.healthImage = display.newImage(AiHealth[1])
						else
							self.healthImage = display.newImage(AiHealth[math.floor(self.health/10)])
						end
						self.healthImage.anchorX = 0
						self.healthImage.anchorY = 0.5
						self.healthImage.x =  x5
						self.healthImage.y = y5
					--	transition.to(self.healthImage,{time = 100, x = self.x -32, y= self.y -32 })

					elseif		self.type == 2 then
						--display.remove(self.healthImage)
						self.healthImage.isVisible = false
						if math.floor(self.health/30) < 1 then 
							self.healthImage = display.newImage(AiHealth[1])
						else
							self.healthImage = display.newImage(AiHealth[math.floor(self.health/30)])
						end
						
						self.healthImage.anchorX = 0
						self.healthImage.anchorY = 0.5
						self.healthImage.x = x5
						self.healthImage.y = y5
						--transition.to(self.healthImage,{time =  100, x = self.x -32, y= self.y -32 })
					end
				end
			end



			--diplays the cells
			function displayMOney(event)
				moneyYouHad = 0
				if  moneyYouHad <= money	then
					myMoney.text = money
					
					--local myMoney = display.newText( money , 4*64, .5*64, native.systemFontBold, 25 )
					--myMoney:setFillColor( 1, 0.843, 0 )
					--moneyYouHad = money
				end
				
			end


			function diplayWaveNum(event)
				--lastNumberOfwave = 0
				if  lastNumberOfwave ~= numberOfWaves	then
					waveNum2.text = numberOfWaves 
					--local myMoney = display.newText( money , 4*64, .5*64, native.systemFontBold, 25 )
					--myMoney:setFillColor( 1, 0.843, 0 )
					lastNumberOfwave = numberOfWaves
				end
				
			end

			--listens for the key press A
			function onKey( event )
				--print("key pressed")
				 if ( event.keyName == "a" ) then
			        
			        speedUp()

			     elseif ( event.keyName == "d" )			then

			     	slowDown()
			     end
			end
			--speeds up the game
			function speedUp( event )
				
				if 	curentTotalOfEnemy == 0 and fastMode == false then
					fastMode = true
					print("too fast")
					--timeToCallMoveAi = timeToCallMoveAi/2
					--timerToSpawn = timerToSpawn/4
					--timerToSpawn2 = timerToSpawn2/4
					--timerToSetNextWave = timerToSetNextWave/4
					enemies.speed = enemies.speed/2
					enemies.cooldown = enemies.cooldown/2
					enemyTank.speed = 680
					enemyTank.cooldown = 20
					NormalTower.timer = NormalTower.timer/2
					NormalTower.coolDown =NormalTower.coolDown/2
					SniperTower.timer =SniperTower.timer/2
					SniperTower.coolDown =SniperTower.coolDown/2
					bulletSpeed1 = 190

					for i=1,#turretsSpawned do
						
						turretsSpawned[i].coolDown = turretsSpawned[i].coolDown/2
						turretsSpawned[i].timer =turretsSpawned[i].timer/2
						--turretsSpawned[i].removeTime =turretsSpawned[i].removeTime*2
					end

					for i=1,#sniperSpawned do
						
						sniperSpawned[ i  ].coolDown = sniperSpawned[ i  ].coolDown/2
						sniperSpawned[ i  ].timer =sniperSpawned[ i  ].timer/2
						--sniperSpawned[ i  ].removeTime =turretsSpawned[i].removeTime*2
					end
				end
				--for i=1,#enemySpawned do
					--if enemySpawned[i] ~= nil then
					--	enemySpawned[i].speed = enemySpawned[i].speed/2
				--		enemySpawned[i].coolDown = enemySpawned[i].coolDown/2
				--	end
				--end

				--for i=1,#turretsSpawned do
					
				--	turretsSpawned[i].coolDown = turretsSpawned[i].coolDown/2
				--	turretsSpawned[i].timer =turretsSpawned[i].timer/2
				--	turretsSpawned[i].removeTime =turretsSpawned[i].removeTime/2
				--end
				--checkForNextWave()

			end
			-- slows down the game
			function slowDown( event )
				
				if 	curentTotalOfEnemy == 0 and fastMode == true then
						fastMode = false
						print("slow down")
						--timerToSpawn = timerToSpawn*4
						--timerToSpawn2 = timerToSpawn2*4
						--timerToSetNextWave = timerToSetNextWave*4
						enemies.speed = enemies.speed*2
						enemies.cooldown = enemies.cooldown*2
						enemyTank.speed = 1400
						enemyTank.cooldown = 45
						NormalTower.timer = NormalTower.timer*2
						NormalTower.coolDown =NormalTower.coolDown*2
						SniperTower.timer =SniperTower.timer*2
						SniperTower.coolDown =SniperTower.coolDown*2
						bulletSpeed1 = 200

						for i=1,#turretsSpawned do
							
							turretsSpawned[i].coolDown = turretsSpawned[i].coolDown*2
							turretsSpawned[i].timer =turretsSpawned[i].timer*2
							--turretsSpawned[i].removeTime =turretsSpawned[i].removeTime*2
						end

						for i=1,#sniperSpawned do
							
							sniperSpawned[ i  ].coolDown = sniperSpawned[ i  ].coolDown*2
							sniperSpawned[ i  ].timer =sniperSpawned[ i  ].timer*2
							--sniperSpawned[ i  ].removeTime =turretsSpawned[i].removeTime*2
						end
				end
				--timeToCallMoveAi = timeToCallMoveAi*2
				--timerToSpawn = timerToSpawn*2
				--timerToSetNextWave = timerToSetNextWave*2
				--for i=1,#enemySpawned do
				--	if enemySpawned[i] ~= nil then
				--		enemySpawned[i].speed = enemySpawned[i].speed*2
				--	end
				--end

				
				--checkForNextWave()
			end

			-- makes the waves harder as it goes on 
			function waveBalance(event )
					-- body

					if 	nextWave == true	then
						if 		numberOfWaves == 2	then
							enemyTank.health = enemyTank.health + 25
							enemies.health = enemies.health + 20
							nextWave = false
						elseif 	numberOfWaves == 3	then
							enemyTank.health = enemyTank.health + 35
							enemies.health = enemies.health + 40
							nextWave = false
						elseif numberOfWaves == 4		then
							numOfSmallAi = 1
							enemyTank.health = enemyTank.health + 25
							enemies.health = enemies.health + 25
							nextWave = false
						elseif 	numberOfWaves == 6	then
							
							enemyTank.health = enemyTank.health + 60
							enemies.health = enemies.health + 50
							nextWave = false

						elseif 	numberOfWaves == 9	then
							enemyTank.health = enemyTank.health + 60
							enemies.health = enemies.health + 40
							nextWave = false
						end
					end
				end

			function quitGame(event )
				 composer.gotoScene("startScreen" ,{effect = "fade", time = 500})
				-- body
			end

			function winAndLooseGame(event)
				if pHealth < 0 or researchAmount <= 0	then
					 composer.gotoScene("startScreen" ,{effect = "fade", time = 500})
				end
			end


--============================================================================================================================================##
--============================================================================================================================================##



		menuButtom.touch = menuTouch
		menuButtom:addEventListener("touch", menuButtom)

		Runtime:addEventListener("enterFrame",winAndLooseGame)
    	Runtime:addEventListener("enterFrame",displayMOney)
		Runtime:addEventListener("enterFrame",checkForNextWave)
		Runtime:addEventListener("key",onKey)
		Runtime:addEventListener("enterFrame",PlayerHealth)
		Runtime:addEventListener("enterFrame",waveBalance)
		Runtime:addEventListener("enterFrame",diplayWaveNum)
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

	 	timer.cancel( tmr6  )
		timer.cancel( tmr7  )
		timer.cancel( tmr8  )
		timer.cancel( tmr9  )
		timer.cancel( tmr10  )
		timer.cancel( tmr3  )
		if numberOfWaves > 1 then
			timer.cancel( tmr5  )
		end
	 	timer.cancel( tmr4  )

    	
    	menuButtom:removeEventListener("touch", menuButtom)

    	Runtime:removeEventListener("enterFrame",winAndLooseGame)
    	Runtime:removeEventListener("enterFrame",displayMOney)
		Runtime:removeEventListener("enterFrame",checkForNextWave)
		Runtime:removeEventListener("key",onKey)
		Runtime:removeEventListener("enterFrame",PlayerHealth)
		Runtime:removeEventListener("enterFrame",waveBalance)
		Runtime:removeEventListener("enterFrame",diplayWaveNum)
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
		--composer.removeScene("game")
    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene















--system.activate( "multitouch" )


--makes the level




--money.enterFrame = displayMOney
