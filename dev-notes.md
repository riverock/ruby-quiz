At first glance, before I opened the words file, my thought is that I can split each word into a substring of 4 characters each. I'm not clear yet what I would do with substrings that are less than four characters long. I imagine I'll just ignore them.

In that array, I can just remove any duplicates and write it to a file.

For the other file, I can find a match for each entry in the first array and build an array of matches, and write that to a file.


Turns out that didn't quite work as expected. I knew that performance would be an issue. But thought that it might work for this.Scanning the file for matches was entirely too slow, so I opted to just push the word to an array at the same time as the substring.

I did end up with a bit of a mismatch with the number of questions and answers, with answers being longer due to multiple matches.  So I went back to the requirements and noticed it said _should contain the corresponding words_, so it _could_ mean multiple words per match. This is typically something I would clarify to see if additional work was needed. I decided to submit what I had.

## Testing

For testing, I decided something simple. Create a small file to run. I grabbed 50 words as something small and fast that demonstrates that it works as intended. One additional step that I considered, but discarded as not important for this would be to have the test directory store the answers and questions results. But instead, opted for having ruby truncate the file on each run. And then check to contents of the file after the test runs.

`test test/test_generator.rb`


## Run

Bundle it

`bundle`

Launch iex

`irb -r './generator.rb'`

Create a new instance of Generator with a filepath to the file

`gen = Generator.new(file_path)`

Execute the transformation

`gen.generate_files``

