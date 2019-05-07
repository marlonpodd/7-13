local composer = require( "composer" )
 
local scene1 = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene1 event functions below will only be executed ONCE unless
-- the scene1 is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene1 event functions
-- -----------------------------------------------------------------------------------
 

-- create()
function scene1:create( event )
 
    local scene1Group = self.view
    -- Code here runs when the scene1 is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene1:show( event )
 
    local scene1Group = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene1 is still off screen (but is about to come on screen)
        background = display.newImageRect( "./assets/background.jpg", 320, 600)
        background.x = 160
        background.y = 240
        background.id = "background"


        local text = display.newText( "Scene 1" , 160, 130, native.systemFont, 25 )
        text:setFillColor( 0/255, 150/255, 0/255 )
        scene1Group:insert(text)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene1 is entirely on screen
        timer.performWithDelay(2000, function()
            background:removeSelf()
            composer.gotoScene( "scene2" )
        end
        )
    end
end
 
 
-- hide()
function scene1:hide( event )
 
    local scene1Group = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene1 is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene1 goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene1:destroy( event )
 
    local scene1Group = self.view
    -- Code here runs prior to the removal of scene1's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene1 event function listeners
-- -----------------------------------------------------------------------------------
scene1:addEventListener( "create", scene1 )
scene1:addEventListener( "show", scene1 )
scene1:addEventListener( "hide", scene1 )
scene1:addEventListener( "destroy", scene1 )
-- -----------------------------------------------------------------------------------
 
return scene1
