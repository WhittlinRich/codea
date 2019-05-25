-- SpellingTest
-- ###########################################################
function setup()
        
    speech.rate = 0.35
    speech.pitch = 1.00
    
    typedInput = ""
    currentWordCount = 1
    wordList = {}
    totalWords = 0
    loadWords()
    
    showKeyboard()
    
    speakWord()

end


-- ###########################################################
function loadWords()
    
    totalWords = 0
    wordsText = readText("Documents:SpellingWords")
    --print(wordsText)
    
    for word in string.gmatch(wordsText, "%a+") do
        --print(word)
        table.insert(wordList, word)
        totalWords = totalWords + 1
    end
    
end    
-- ###########################################################
function speakWord()
    
    instruction = "Spell the word: " .. wordList[currentWordCount] .. ". "
    instruction = instruction .. "The word is " .. wordList[currentWordCount] .. ". "
    
    speech.say(instruction)
    
end

-- ###########################################################
function processInput()
   
    if typedInput == wordList[currentWordCount] then
        typedInput = ""
        currentWordCount = currentWordCount + 1 
        speech.say("Correct!")
        if(currentWordCount <= totalWords) then
            speakWord()
        else
            speech.say("You're done! Great job!")
        end
    else
        speech.say("No. Try Again.")
        speakWord()
    end
    
end

-- ###########################################################
function keyboard(key)
    
    if key == RETURN then
        processInput()
    elseif key == BACKSPACE then
        typedInput = string.sub(typedInput, 1, -2)
    else
        typedInput = typedInput .. key
    end

end

-- ###########################################################
-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)
    fill(255, 13, 0, 255)

    -- Do your drawing here
    if typedInput then
        font("Vegur")
        fontSize(60)
        textWrapWidth(WIDTH - 20)
        text(typedInput, WIDTH/2, HEIGHT*0.75)
    end
        
end

-- ###########################################################
