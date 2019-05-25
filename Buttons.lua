-- Buttons
-- ####################################################
function setup()
    
    inputText = ""
    isTouching = false
    
    buttons = {}
    createButtons()

end

-- #####################################################
-- This function gets called once every frame
function draw()

    background(40, 40, 50)
    fill(255,0,0)
    stroke(255)
    strokeWidth(5)
        
    displayButtons()
    
    -- message display
    font("Vegur")
    fontSize(40)
    textWrapWidth(WIDTH - 20)
    text(inputText, WIDTH/2, HEIGHT*0.90)    
    
    if isTouching == true then
        pushStyle()
        noStroke()
        fill(185, 103, 17, 125)
        ellipse(CurrentTouch.pos.x, CurrentTouch.pos.y, 80,80)
        popStyle()
    end
    
end

-- #####################################################
function createButtons()
    -- button = {x=0, y=0, w=0, h=0, label=""}
    
    w = 70
    h = 70
    startPos = 10  
    
    for i = 1, 13 do
        newX = (startPos + w + 2) * i
        newY = HEIGHT/2 * 0.3
        label = i
        if label == 10 then
            label = 0
        elseif label == 11 then
            label = ":"
        elseif label == 12 then
            label = "Delete"
            w = 130
            newX = WIDTH/2 - 20 - w
            newY = newY - h - 20
        elseif label == 13 then
            label = "Enter"
            w = 130
            newX = WIDTH/2 - 10
            newY = newY - h - 20
        end
        button = {x=newX, y=newY, w=w, h=h, label=label}
        table.insert(buttons, button)
    end
        
    -- for key,value in pairs(buttons) do
    --     print(key .. "=" .. value.x)
    -- end
    
end

-- ##############################################
function displayButtons()

    pushStyle()
    strokeWidth(5)
    stroke(67, 67, 67, 255)
    fill(228, 228, 228, 255)
   
    for key,button in pairs(buttons) do
        rect(button.x, button.y, button.w, button.h)
        pushStyle()
        fill(0, 0, 0, 255)
        text(button.label, button.x + button.w/2, button.y + button.h/2)
        popStyle()
    end
    
    popStyle()
    
end    

-- ##############################################
function touched(touch)
    if touch.state == BEGAN then
        --print(touch.pos.x .. ", " .. touch.pos.y)     
        
        isTouching = true
        
        for key,button in pairs(buttons) do
            --print(key .. "=" .. button.x)
            if touch.pos.x >= button.x and touch.pos.x <= button.x + button.w 
            and touch.pos.y >= button.y and touch.pos.y <= button.y + button.h then  
                print(button.label)
                processButton(button.label)
            end
    
        end
    else
        isTouching = false
    end
    
end

-- ##############################################
function processButton(label)
    
    if label == "Delete" then
        inputText = string.sub(inputText, 1, -2)
    elseif label == "Enter" then
        processInput()
    else
        inputText = inputText .. label
    end
    
end

-- ##############################################
function processInput()
    
    --inputText
    
end

-- ##############################################

