-- MathProblems
-- ###########################################################
function setup()
            
    typedInput = ""
    currentProblemCount = 1
    totalProblems = 10
    
    problemPart1 = 0
    problemPart2 = 0
    problemSign = "+"
    problemString = ""
    problemAnswer = 0

    createProblem()
    
    displayText = "Solve Math Problems!"
    
    showKeyboard()
    
end

-- ###########################################################
-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(225, 225, 225, 255)
    fill(47, 96, 128, 255)

    -- Do your drawing here
    font("Vegur")
    fontSize(60)
    textWrapWidth(WIDTH - 20)
    
    text(displayText, WIDTH/2 - 40, HEIGHT*0.65)
    
    fill(0, 0, 0, 255)
    textAlign(RIGHT)
    
    problemX = WIDTH/2 * 0.90
    problemY = HEIGHT * 0.85
    
    problemString2 = problemString
    if typedInput then
        problemString2 = problemString.."\n"..typedInput
    end
        
    
    if problemString ~= "" then
        text(problemString2, problemX, problemY)
        rect(problemX - 50, problemY - 40, 110, 4)
    end
            
end

-- ###########################################################
function createProblem()
    
    problemPart1 = math.random(1, 9)
    problemPart2 = math.random(1, 9)
    problemString = problemPart1.."\n"..problemSign.."  "..problemPart2
    
    if problemSign == "+" then
        problemAnswer = problemPart1 + problemPart2 
    elseif problemSign == "-" then
        problemAnswer = problemPart1 - problemPart2 
    elseif problemSign == "x" then
        problemAnswer = problemPart1 * problemPart 
    elseif problemSign == "÷" then
        problemAnswer = problemPart1 / problemPart2     
    end
    
end    

-- ###########################################################
function processInput()
   
    if tonumber(typedInput) == problemAnswer then
        typedInput = ""
        currentProblemCount = currentProblemCount + 1 
        displayText = "Correct!"
        if(currentProblemCount <= totalProblems) then
            createProblem()
        else
            displayText = "You're done! Great job!"
            problemString = ""
        end
    else
        displayText = "Nope."
    end
    
end

-- ###########################################################
function keyboard(key)
    
    if problemString ~= "" then
        displayText = ""
    end
    
    if key == RETURN then
        processInput()
    elseif key == BACKSPACE then
        typedInput = string.sub(typedInput, 1, -2)
    else
        typedInput = typedInput .. key
    end

end

-- ###########################################################
