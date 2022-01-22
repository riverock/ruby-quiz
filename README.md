# Instructions

To run the quiz, be sure you are in the path of the app:
1. Extract your words list if zipped, as the file needs to be named 'words' (no extension).
2. Place your word list file in the root of the app ( ruby-quiz/words )
3. In your terminal, run the command:
    ```
   ruby -I . -r "engine" -e "Engine.run"
    ```
4. Depending on how many words you have it could take a while. 

###Original Instructions:
There's no correct way to
solve this, and take as much time as you need...we're just trying to
get a look at your coding style and thought process.

Make sure to include the unit tests you write for this in your submission.

## Code

###Original Instructions:
Given a list of words ([words.tar.gz](https://github.com/riverock/ruby-quiz/blob/master/words.tar.gz)), generate two output
files, 'questions' and 'answers'.  'questions' should contain every
sequence of four letters that appears in exactly one word of the
dictionary, one sequence per line.  'answers' should contain the
corresponding words that contain the sequences, in the same order,
again one per line.


An example:


Say this is your dictionary:
* arrows
* carrots
* give
* me


'questions' would contain:
* carr
* give
* rots
* rows
* rrot
* rrow


and 'answers' would have:
* carrots
* give
* carrots
* arrows
* carrots
* arrows


'arro' wouldn't show up in 'questions', because it appears in two words

## Submission

1. Fork this repo
2. Create a feature branch for your solution (eg [github username]/solution)
3. Complete work
4. Open a pull request to submit.
