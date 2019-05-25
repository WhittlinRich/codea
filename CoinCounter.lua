-- CoinCounter
-- ##############################################
-- Use this function to perform your initial setup
function setup()
    -- print("Hello World!")
    
    totalQuestions = 3
    questionCounter = 1
    typedAmount = ""
    displayText = "Type in your answer."
    maxCoins = 7
    totalCoins = 2
    totalAmount = 0
    isCorrect = false
    selectedCoins = {}
    showKeyboard()

    coinsCollection = {
        {"penny", "Documents:penny", 1, 80},
        {"nickel", "Documents:nickel", 5, 90},
        {"dime", "Documents:dime", 10, 70},
        {"quarter", "Documents:quarter", 25, 100}
    }
    
    resetCoins()
    
end

-- ##############################################
function resetCoins()
    
    typedAmount = ""
    totalAmount = 0
    selectedCoins = {}
    coinString = ""
  
    totalCoins = math.random(2, maxCoins)
    
    for i = 1, totalCoins do
        randomNumber = math.random(1, 4)
        table.insert(selectedCoins, coinsCollection[randomNumber])
        totalAmount = totalAmount + coinsCollection[randomNumber][3]
        --coinString = coinString .." ".. coinsCollection[randomNumber][1]
    end
    
    --print(coinString)
    --print(totalAmount)
    
end

-- ##############################################
-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)
    fill(72, 153, 197, 255)
    
    -- This sets the line thickness
    strokeWidth(5)

    -- Do your drawing here
    
    imageOffset = 110
    for i = 1, totalCoins do
        --print(selectedCoins[i][2])
        sprite(selectedCoins[i][2], WIDTH * 0.01 + imageOffset, HEIGHT * 0.70, selectedCoins[i][4])
        imageOffset = imageOffset + 110
    end
    
    
    if typedAmount then
        font("Vegur")
        fontSize(40)
        textWrapWidth(WIDTH - 20)
        text(typedAmount, WIDTH/2, HEIGHT*0.85)
    end
    
        
    font("Vegur")
    fontSize(40)
    textWrapWidth(WIDTH - 20)
    text(displayText, WIDTH/2, HEIGHT*0.90)
    
    
end

-- ##############################################
function checkInput()
    
    -- print(typedAmount.." = "..totalAmount)
    -- careful comparing floating point numbers to each other.
    -- if tonumber(typedAmount) == tonumber(tostring(totalAmount)) then
    
    numberAmount = tonumber(typedAmount)
    if numberAmount == (totalAmount * 0.01) or numberAmount == totalAmount then
        displayText = "Correct!"
        isCorrect = true
        typedAmount = ""
        questionCounter = questionCounter + 1 
        if questionCounter <= totalQuestions then
            resetCoins()
        else
            totalCoins = 0
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
        typedAmount = string.sub(typedAmount, 1, -2)
    else
        typedAmount = typedAmount .. key
    end

end

-- ##############################################
