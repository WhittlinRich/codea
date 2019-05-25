-- ClockTime3
-- ####################################################
-- Use this function to perform your initial setup
function setup()
    -- print("Hello World!")
    
    displayText = "Tell the time!"
    typedTime = ""
    isCorrect = false
    selectedTime = "12:00"
    
    totalQuestions = 4
    questionCounter = 1
    
    hourHandRotation = 0
    minuteHandRotation = 0
    resetClock()
    
    showKeyboard()

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
    translate(WIDTH*0.5,HEIGHT*0.80)

    -- clockface
    pushStyle()
    fill(255, 255, 255, 255)
    stroke(144, 144, 144, 255)
    strokeWidth(3)
    ellipse(0, 0, 300, 300)
    popStyle()

    -- numbers    
    pushStyle()
    fill(127, 127, 127, 255)
    font("Vegur")
    fontSize(20)
    noStroke()
    for i = 1, 12 do
        numberText = tostring(i)
        angle = -2 * math.pi / 12.0 * (i - 3)
        distance = 120
        x = math.cos(angle) * distance
        y = math.sin(angle) * distance
        text(numberText, x, y)
    end
    popStyle()
    
    
    -- large ticks
    pushStyle()
    fill(127, 127, 127, 255)
    font("Vegur")
    fontSize(20)
    noStroke()

    for i = 1, 12 do
        x = 0
        y = 120
        rotate(-30)
        rect(x-2, y + 14, 4, 14)
    end
    popStyle()
    

    -- small ticks    
    pushStyle()
    fill(127, 127, 127, 255)
    noStroke()
    for i = 1, 60 do
        x = 0
        y = 142
        rotate(-6)
        rect(x-2, y, 3, 6)
    end
    popStyle()
    
    
    -- hands
    pushStyle()
    fill(34, 34, 34, 255)
    noStroke()
    x = 0
    y = 0
    rotate(-minuteHandRotation)
    rect(x-2, y, 4, 130)
    rotate(minuteHandRotation)
    rotate(-hourHandRotation)
    rect(x-3, y, 6, 90)
    popStyle()
    
    pushStyle()
    noStroke()
    fill(34, 34, 34, 255)
    ellipse(0,0,10,10)
    popStyle()
    
    popMatrix()
    
    fill(255,0,0)

    
    -- typing display
    if typedTime then
        font("Vegur")
        fontSize(40)
        textWrapWidth(WIDTH - 20)
        text(typedTime, WIDTH/2, HEIGHT*0.62)
    end
        
    -- message display
    font("Vegur")
    fontSize(40)
    textWrapWidth(WIDTH - 20)
    text(displayText, WIDTH/2, HEIGHT*0.58)
    
        
end

-- ##############################################
function checkInput()
    
    selectedTimeString = os.date("%I:%M", selectedTime)
    correctedTypedTime = typedTime
    
    if string.len(typedTime) < 5 then
        correctedTypedTime = "0" .. typedTime
    end
        
    
    if correctedTypedTime == selectedTimeString then
        displayText = "Correct!"
        isCorrect = true
        typedTime = ""
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
function keyboard(key)
        
    displayText = ""
    
    if key == RETURN then
        checkInput()
    elseif key == BACKSPACE then
        typedTime = string.sub(typedTime, 1, -2)
    else
        typedTime = typedTime .. key
    end

end

-- ##############################################
