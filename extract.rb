# Use this file to extract the file
# Usage
# ruby extract.rb <file_name | words.tar.gz>

if ARGV.length == 0
  file_name = 'words.tar.gz'

else
  file_name = ARGV[0]
end

`tar -xvf #{file_name}`
