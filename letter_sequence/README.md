# LetterSequence

Coding quiz for Bluewater.

## Install

    git clone https://github.com/tamouse/bluewater-ruby-quiz.git
    cd bluewater-ruby-quiz/letter_sequence
    bundle install

## Usage

In same directory:

    bundle exec exe/letter_sequence WORDFILE

where `WORDFILE` is a file containing the list of input words.

## Results

The results are given in two files:

* `questions.out` - list of 4 character seuqences
* `answers.out` - matching words

`stdout` also shows some stats on completion:


    Completed 25143 words in 314.674317 milliseconds
    Number of questions: 106263
    Number of answers: 2044699

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


## Methodology

* Create a working dirctory using `bundle gem`
* Create a test class `SequencerTest` and the lib class `Sequencer`
* Rough out the design top-down: `find_sequences`, `de-duplicate`, `sequence_words`, `scan_word` with expected inputs and outputs
* Start tests from `test_scan_word` and write `scan_word`
* Continue up from `scan_word` to `find_sequences`, TDD
* Write a CLI script
* Test CLI script with a short list of words (First 400 from the `words` file)
* Run the full set of words
