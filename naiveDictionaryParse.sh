#!/bin/sh
# read in text file which is  line delimited dictionary. output json dictionary string of format
# ["word1","word2",...,"wordEnd"]

### 
# Regex Investigation and Planning
###
# read from stdin, output to stdout (then I can pipe in and redirect to files)
# playing around with regexr.com but it won't be as relevant because grep pattern applies to multiple line
#   .{6} will match any line that contains more than 6 characters in multiline regex mode
#   could do a pass where I say ignore .{7} lines (take grep inverse) and then run .{6}
#   but I can also do ^ which is beginning of line and $ for end (if I have multiline flag it works on whole file, but irrelevant for grep)
# ok grep ^.{6} didn't work BUT grep has -x which makes sure it matches whole line, so same as ^......$

###
# Attempt 1
###
# printing current time in seconds because Im curious how long this will take (the dictionary is 4MB or so)
# lol it took 1 second
# date +%s
# limit stdin to only 6 character words per line
# replace newlines with ","
# cat $1 | grep -x ...... | sed 's/\n/","/' # g not needed because this is doing line by line
# date +%s
# quotes and array brackets can be added at beginning and end manually by user because I'm lazy

###
# Attempt 2, fun with new lines
###
# eh sed isn't working because it goes line by line too and I'm too lazy. lets try some other things!
# echo -n $(cat $1 |grep -x ......)
# from echo man page "Most notably, the builtin echo in sh(1) does not accept the -n option" hmm
# /bin/echo -n $(cat $1 | grep -x ......)
# this didn't work either...
# extra dot is because the file uses windows line endings and so has \r (but grep removes them)
# cat $1 | grep -x ....... | sed l
# ^ interesting this prints out some \r's, could use that for adding the quotes at least
# cat $1 | grep -x ....... | sed 's/\r/","/'
# ^ ok this at least gets the appending thing working, and then I can use sublime but it spins foreverrrr

###
# Attempt 3, success!
###
# touch temp # for vimp script (not needed strictly, just use /bin/stdin)
# extra dot is because the file uses windows line endings and so has \r (but grep removes them)
cat $1 | grep -x ....... > output.txt
# commit history of this file is filled with the souls of dead sed commands because they don't take kindly to new line processing
# %s => find and replace all
echo ':%s/\\n/","\n:wq' | vi output.txt -s /bin/stdin # use vim to find and replace all new lines with "," then save and quit
# rm temp

# array brackets can still be added by end user because this is the extent of my optimizing!!!

