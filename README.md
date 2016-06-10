# Instructions

There's no correct way to
solve this, and take as much time as you need...we're just trying to
get a look at your coding style and thought process.

Make sure to include the unit tests you write for this in your submission.

## Code

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


## Usage

1. Firstly, run extract.rb to extract the compressed words file.
2. Run app using `ruby driver.rb`
3. For specs run `ruby test_ruby_quiz.rb`
