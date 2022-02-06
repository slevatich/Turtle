#!/bin/sh
# read in text file which is  line delimited dictionary. output json dictionary string of format
# ["word1","word2",...,"wordEnd"]

# read from stdin, output to stdout (then I can pipe in and redirect to files)
# playing around with regexr.com but it won't be as relevant because grep pattern applies to multiple line
#   .{6} will match any line that contains more than 6 characters in multiline regex mode
#   could do a pass where I say ignore .{7} lines (take grep inverse) and then run .{6}
#   but I can also do ^ which is beginning of line and $ for end (if I have multiline flag it works on whole file, but irrelevant for grep)
# ok grep ^.{6} didn't work BUT grep has -x which makes sure it matches whole line, so same as ^......$

# printing current time in seconds because Im curious how long this will take (the dictionary is 4MB or so)
# lol it took 1 second
# date +%s
# limit stdin to only 6 character words per line
# replace newlines with ","
# cat $1 | grep -x ....... | sed 's/\n/","/' # g not needed because this is doing line by line
# date +%s
# quotes and array brackets can be added at beginning and end manually by user because I'm lazy

# eh sed isn't working because it goes line by line too and I'm too lazy. lets try some other things!
# echo -n $(cat $1 |grep -x ......)
# from echo man page "Most notably, the builtin echo in sh(1) does not accept the -n option" hmm

# this didn't work either
# /bin/echo -n $(cat $1 | grep -x ......)

# giving up and using sublime lol
# hmm still need an appended character because I can't remember the full line select shortcut
# could do vim version of sed, that might be faster and could find newlines
# in general knowing how to handle newlines in unix would be nice... printf doesn't do newlines like echo, maybe I could leverage that

# cat $1 | grep -x ....... | sed l
# ^ interesting this prints out some \r's, could use that for adding the quotes at least
cat $1 | grep -x ....... | sed 's/\r/","/'
# ^ ok this at least gets the appending thing working, and then I can use sublime but it spins foreverrrr. vim is much quicker but even that lags

