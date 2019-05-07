local composer = require( "composer" )
 
local scene3 = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene3 event functions below will only be executed ONCE unless
-- the scene3 is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene3 event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene3:create( event )
 
    local scene3Group = self.view
    -- Code here runs when the scene3 is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene3:show( event )
 
    local scene3Group = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene3 is still off screen (but is about to come on screen
       --background
        display.setDefault( "background", 100/255, 100/255, 200/255 )
        
        -- Gravity
        
        local physics = require( "physics" )
        
        physics.start()
        physics.setGravity( 0, 25 ) -- ( x, y )
        --physics.setDrawMode( "hybrid" )   -- Shows collision engine outlines only
        
        local playerBullets = {} -- Table that holds the players Bullets
        
        --local rightWall = display.newRect( 400, 0, display.contentHeight / 3 , display.contentHeight + 400 )
        
        
        --ground
        local theGround = display.newImage( "./assets/land.png" )
        theGround.x = - 190
        theGround.y = 480
        theGround.id = "the ground"
        physics.addBody( theGround, "static", { 
            friction = 0.5, 
            bounce = 0.3 
            } )
        
        
        --charater
        local waluigi = display.newImageRect( "./assets/tpose.png", 175, 175 )
        waluigi.x = display.contentCenterX
        waluigi.y = 200
        waluigi.id = "the character"
        physics.addBody( waluigi, "dynamic", { 
            density = 3.0, 
            friction = 0.5, 
            bounce = 0.3 
            } )
        waluigi.isFixedRotation = true
        
        -- Character move
        local dPad = display.newImageRect( "./assets/d-pad.png", 125, 125 )
        dPad.x = 80
        dPad.y = 440
        dPad.id = "d-pad"
        
        
        local upArrow = display.newImageRect( "./assets/upArrow.png", 30, 22 )
        upArrow.x = 80
        upArrow.y = 393
        upArrow.id = "up arrow"
        
        local downArrow = display.newImageRect( "./assets/downArrow.png", 30, 22 )
        downArrow.x = 80
        downArrow.y = 486
        downArrow.id = "down arrow"
        
        local leftArrow = display.newImageRect( "./assets/leftArrow.png", 22, 30 )
        leftArrow.x = 34
        leftArrow.y = 440
        leftArrow.id = "left arrow"
        
        local rightArrow = display.newImageRect( "./assets/rightArrow.png", 22, 30 )
        rightArrow.x = 126
        rightArrow.y = 440
        rightArrow.id = "right arrow"
        
        local jumpButton = display.newImageRect( "./assets/jumpButton.png", 30, 30 )
        jumpButton.x = 80
        jumpButton.y = 440
        jumpButton.id = "right arrow"
        
        local shootButton = display.newImageRect( "./assets/jumpButton.png", 60, 60 )
        shootButton.x = 275
        shootButton.y = 440
        shootButton.id = "shootButton"
        shootButton.alpha = 1
        
        local leftshootButton = display.newImageRect( "./assets/jumpButton.png", 60, 60 )
        leftshootButton.x = 190
        leftshootButton.y = 440
        leftshootButton.id = "leftshootButton"
        leftshootButton.alpha = 1
        
        --functions 
        function upArrow:touch( event )
            if ( event.phase == "ended" ) then
                -- move the character up
                transition.moveBy( waluigi, { 
                    x = 0, -- move 0 in the x direction 
                    y = -50, -- move up 50 pixels
                    time = 100 -- move in a 1/10 of a second
                    } )
            end
        
            return true
        end
        
        function downArrow:touch( event )
            if ( event.phase == "ended" ) then
                -- move the character up
                transition.moveBy( waluigi, { 
                    x = 0, -- move 0 in the x direction 
                    y = 50, -- move up 50 pixels
                    time = 100 -- move in a 1/10 of a second
                    } )
            end
        
            return true
        end
        
        function leftArrow:touch( event )
            if ( event.phase == "ended" ) then
                -- move the character up
                transition.moveBy( waluigi, { 
                    x = -50, -- move 0 in the x direction 
                    y = 0, -- move up 50 pixels
                    time = 100 -- move in a 1/10 of a second
                    } )
            end
        
            return true
        end
        
        function rightArrow:touch( event )
            if ( event.phase == "ended" ) then
                -- move the character up
                transition.moveBy( waluigi, { 
                    x = 50, -- move 0 in the x direction 
                    y = 0, -- move up 50 pixels
                    time = 100 -- move in a 1/10 of a second
                    } )
            end
        
            return true
        end
        
        function jumpButton:touch( event )
            if ( event.phase == "ended" ) then
                -- make the character jump
                waluigi:setLinearVelocity( 0, -750 )
            end
        
            return true
        end
        
        function shootButton:touch( event )
            if ( event.phase == "began" ) then
                -- make a bullet appear
                local aSingleBullet = display.newImageRect( "./assets/wah.png", 80, 30)
                aSingleBullet.x = waluigi.x + 30
                aSingleBullet.y = waluigi.y
                physics.addBody( aSingleBullet, 'dynamic' )
                -- Make the object a "bullet" type object
                aSingleBullet.isBullet = true
                aSingleBullet.gravityScale = 0
                aSingleBullet.id = "bullet"
                aSingleBullet:setLinearVelocity(  500 , 0 )
        
                table.insert(playerBullets,aSingleBullet)
                print("# of bullet: " .. tostring(#playerBullets))
            end
        
            return true
        end
        
        function leftshootButton:touch( event )
            if ( event.phase == "began" ) then
                -- make a bullet appear
                local aSingleBullet2 = display.newImageRect( "./assets/wah.png", 80, 30)
                aSingleBullet2.x = waluigi.x- 30
                aSingleBullet2.y = waluigi.y
                physics.addBody( aSingleBullet2, 'dynamic' )
                -- Make the object a "bullet" type object
                aSingleBullet2.isBullet = true
                aSingleBullet2.gravityScale = 0
                aSingleBullet2.id = "bullet"
                aSingleBullet2:setLinearVelocity(  -500, 0 )
        
                table.insert(playerBullets,aSingleBullet2)
                print("# of bullet: " .. tostring(#playerBullets))
            end
        
            return true
        end
        
        local function characterCollision( self, event )
         
            if ( event.phase == "began" ) then
                print( self.id .. ": collision began with " .. event.other.id )
                if event.other.id == "dynamite" then
                    print("yeet")
                end
         
            elseif ( event.phase == "ended" ) then
                print( self.id .. ": collision ended with " .. event.other.id )
            end
        end
        
        function checkPlayerBulletsOutOfBounds()
            -- check if any bullets have gone off the screen
            local bulletCounter
        
            if #playerBullets > 0 then
                for bulletCounter = #playerBullets, 1 ,-1 do
                    if playerBullets[bulletCounter].x > display.contentWidth + 1000 then
                        playerBullets[bulletCounter]:removeSelf()
                        playerBullets[bulletCounter] = nil
                        table.remove(playerBullets, bulletCounter)
                        print("remove bullet")
                    end
                end
            end
        end
        
        function checkCharacterPosition( event )
            -- check every frame to see if character has fallen
            if waluigi.y > display.contentHeight + 500 then
                waluigi.x = display.contentCenterX
                waluigi.y = display.contentCenterY
            end
        end
        
        upArrow:addEventListener( "touch", upArrow )
        downArrow:addEventListener( "touch", downArrow )
        leftArrow:addEventListener( "touch", leftArrow )
        rightArrow:addEventListener( "touch", rightArrow )
        jumpButton:addEventListener( "touch", jumpButton )
        shootButton:addEventListener( "touch", shootButton )
        leftshootButton:addEventListener( "touch", leftshootButton )
        
        Runtime:addEventListener( "enterFrame", checkCharacterPosition )
        Runtime:addEventListener( "enterFrame", checkPlayerBulletsOutOfBounds )
        
        waluigi.collision = characterCollision
        waluigi:addEventListener( "collision" )

 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene3 is entirely on screen
 
    end
end
 
 
-- hide()
function scene3:hide( event )
 
    local scene3Group = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene3 is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene3 goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene3:destroy( event )
 
    local scene3Group = self.view
    -- Code here runs prior to the removal of scene3's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene3 event function listeners
-- -----------------------------------------------------------------------------------
scene3:addEventListener( "create", scene3 )
scene3:addEventListener( "show", scene3 )
scene3:addEventListener( "hide", scene3 )
scene3:addEventListener( "destroy", scene3 )
-- -----------------------------------------------------------------------------------
 
return scene3