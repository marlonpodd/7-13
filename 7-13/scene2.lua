local composer = require( "composer" )
 
local scene2 = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene2 event functions below will only be executed ONCE unless
-- the scene2 is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

 

-- -----------------------------------------------------------------------------------
-- Scene2 event functions
-- -----------------------------------------------------------------------------------

 
-- create()
function scene2:create( event )
 
    local scene2Group = self.view
    -- Code here runs when the scene2 is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene2:show( event )
 
    local scene2Group = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene2 is still off screen (but is about to come on screen)
        local background = display.newRect(0, 0, 1080, 1080)
        background:setFillColor( 0, 0, 255)
        scene2Group:insert(background)

        local text = display.newText( "Menu" , 160, 200, native.systemFont, 60 )
        text:setFillColor( 255/255, 0/255, 0/255 )
        scene2Group:insert(text)

        play = display.newText( "Press PLAY" , 160, 380, native.systemFont, 25 )
        play:setFillColor( 0/255, 255/255, 0/255 )
        scene2Group:insert(play)

        function play:touch ( event )
            if ( event.phase == "began" ) then
                
                local options = {
                    effect = "fade",
                    time = 500
                }
                composer.gotoScene( "scene3", options )
            end
        end
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene2 is entirely on screen

        play:addEventListener("touch", play )
 
 
    end
end
 
 
-- hide()
function scene2:hide( event )
 
    local scene2Group = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene2 is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene2 goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene2:destroy( event )
 
    local scene2Group = self.view
    -- Code here runs prior to the removal of scene2's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene2 event function listeners
-- -----------------------------------------------------------------------------------
scene2:addEventListener( "create", scene2 )
scene2:addEventListener( "show", scene2 )
scene2:addEventListener( "hide", scene2 )
scene2:addEventListener( "destroy", scene2 )
-- -----------------------------------------------------------------------------------
 
return scene2