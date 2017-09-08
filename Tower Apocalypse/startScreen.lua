local composer = require( "composer" )

local scene = composer.newScene()
composer.isDebug = true
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here
local backGround
local startB
local clickSound
-- -------------------------------------------------------------------------------
local function callGame(event )
    local sound = audio.play(clickSound)
    composer.gotoScene("game")
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    clickSound = audio.loadStream( "startScreen.wav" )

        backGround = display.newImage("background.png")
                backGround.anchorX = 0
                backGround.anchorY = 0
                backGround.x = 0
                backGround.y = 0
        sceneGroup:insert(backGround)

        startB = display.newImage("playButton.png")
                 startB.anchorX = 0
                startB.anchorY = 0
                startB.x = 7.5*64
                startB.y = 7*64
        sceneGroup:insert(startB)

            startB.tap = callGame
            startB:addEventListener("tap",startB)
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
        composer.removeScene("game")
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then

       --composer.removeScene("startScreen",true)
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

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