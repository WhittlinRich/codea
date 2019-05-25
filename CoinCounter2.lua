-- CoinCounter2
-- ##############################################
-- Use this function to perform your initial setup
function setup()
    -- print("Hello World!")
    
    totalQuestions = 5
    questionCounter = 1
    typedAmount = ""
    displayText = "Type in your answer."
    maxCoins = 8
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
    
    --table.insert(selectedCoins, coinsCollection[4])
    --table.insert(selectedCoins, coinsCollection[2])
    --totalCoins = 2

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
    strokeWidth(0)
    -- Do your drawing here
    
    startX = 100
    gridX = startX
    gridY = HEIGHT * 0.75
    gap = 20
    maxWidth = WIDTH - 100
    currentRow = 0
    
    for i = 1, totalCoins do
        coinWidth = selectedCoins[i][4]
        if gridX + coinWidth + gap > maxWidth then
            currentRow = currentRow + 1            
            gridX = startX
        end

        sprite(selectedCoins[i][2], gridX, gridY - (currentRow * 110), coinWidth)
        gridX = gridX + coinWidth + gap
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
