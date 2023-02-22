while True:
    word = input("Enter word: ")
    word = word.lower()
    wordCount = len(word)
    firstLetter = word[0]
    lastPart = word[1:]
    if(firstLetter == 'a'):
        print(firstLetter+lastPart+'way')
    elif(firstLetter == 'e'):
        print(firstLetter+lastPart+'way')
    elif(firstLetter == 'i'):
        print(firstLetter+lastPart+'way')
    elif(firstLetter == 'o'):
        print(firstLetter+lastPart+'way')
    elif(firstLetter == 'u'):
        print(firstLetter+lastPart+'way')
    else:
        print(lastPart+firstLetter+'ay')
input()
