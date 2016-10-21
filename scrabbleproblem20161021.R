library(tidyverse)

# Download list of legal scrabble words
download.file("https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/dotnetperls-controls/enable1.txt","enable1.txt")
legalwords <- read_csv("enable1.txt",col_names = "word")

# Find the number of letters in each word

legalwords$letters <- nchar(legalwords$word)

# Grab all 2 letter words to start
# Put them in a table of useable words

puzzlewords <- legalwords %>% filter(letters == 2)

# Find words with one more letter that contain puzzlewords
maxletters <- max(puzzlewords$letters)
testlength <- 3

while(testlength-1==maxletters) {
    testwords <- puzzlewords$word[puzzlewords$letters==maxletters]
    addwords <- NULL
    
    for (i in testwords) {
    
        addwords <- c(addwords,
                      grep(i, legalwords$word[legalwords$letters == testlength]))
    }
  
    addwords <- unique(addwords)
    puzzlewords <- rbind(puzzlewords,
                         legalwords[legalwords$letters == testlength,][addwords,])
      
    testlength <- testlength + 1
    maxletters <- max(puzzlewords$letters)
}

print("Max letters:")
maxletters

puzzlewords$word[puzzlewords$letters==maxletters]
