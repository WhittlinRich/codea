-- ClockTime2
-- ####################################################
-- Use this function to perform your initial setup
function setup()
    
    displayText = "Tell the time!"
    typedTime = ""
    isCorrect = false
    selectedTime = "12:00"
    
    totalQuestions = 3
    questionCounter = 1
    
    hourHandRotation = 0
    minuteHandRotation = 0
    resetClock()

    inputText = ""
    isTouching = false
    
    buttons = {}
    createButtons()
    
end

-- #####################################################
function resetClock()
    
    selectedHour = math.random(1, 12)
    selectedMinute = math.random(0, 59)
    
    selectedTime = os.time({year=2019, month=1, day=1, hour=selectedHour, min=selectedMinute})
    --print(os.date("%I:%M", selectedTime))
    
    --print(selectedHour .. ":" .. selectedMinute)
    hourHandRotation = selectedHour * 30 + (selectedMinute/60 * 30)
    minuteHandRotation = selectedMinute * 6
    
end

-- #####################################################
-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)


    -- Do your drawing here

    fill(255,0,0)
    stroke(255)
    strokeWidth(5)
    
       -- Translate to center
    pushMatrix()
    translate(WIDTH*0.5,HEIGHT*0.5)

    -- clockface
    pushStyle()
    fill(255, 255, 255, 255)
    stroke(144, 144, 144, 255)
    strokeWidth(5)
    ellipse(0, 0, 500, 500)
    popStyle()

    -- numbers    
    pushStyle()
    fill(127, 127, 127, 255)
    font("Vegur")
    fontSize(40)
    noStroke()
    for i = 1, 12 do
        numberText = tostring(i)
        x = 0
        y = 210
        rotate(-30)
        text(numberText, x, y)
        rect(x-3, y + 20, 6, 20)
    end
    popStyle()

    -- small ticks    
    pushStyle()
    fill(127, 127, 127, 255)
    noStroke()
    for i = 1, 60 do
        x = 0
        y = 210
        rotate(-6)
        rect(x-2, y + 26, 4, 10)
    end
    popStyle()
    
    
    -- hands
    pushStyle()
    fill(34, 34, 34, 255)
    noStroke()
    x = 0
    y = 0
    rotate(-minuteHandRotation)
    rect(x-3, y, 6, 230)
    rotate(minuteHandRotation)
    rotate(-hourHandRotation)
    rect(x-5, y, 10, 160)
    popStyle()
    
    pushStyle()
    noStroke()
    fill(34, 34, 34, 255)
    ellipse(0,0,20,20)
    popStyle()
    
    popMatrix()
    
    fill(255,0,0)

    
    -- typing display
    if typedTime then
        font("Vegur")
        fontSize(40)
        textWrapWidth(WIDTH - 20)
        text(typedTime, WIDTH/2, HEIGHT*0.85)
    end
        
    -- message display
    font("Vegur")
    fontSize(40)
    textWrapWidth(WIDTH - 20)
    text(displayText, WIDTH/2, HEIGHT*0.90)
    

    displayButtons()
    
    -- message display
    font("Vegur")
    fontSize(40)
    textWrapWidth(WIDTH - 20)
    text(inputText, WIDTH/2, HEIGHT*0.82)    
    
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
                --print(button.label)
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
        
    selectedTimeString = os.date("%I:%M", selectedTime)
    correctedInput = inputText
    
    if string.len(inputText) < 5 then
        correctedInput = "0" .. inputText
    end        
    
    if correctedInput == selectedTimeString then
        displayText = "Correct!"
        isCorrect = true
        inputText = ""
        questionCounter = questionCounter + 1 
        if questionCounter <= totalQuestions then
            resetClock()
        else
            displayText = "You're Done! Great Job!"
        end
    else
        displayText = "Nope."
        isCorrect = false
    end
    
end

-- ##############################################

