#!/bin/dash

# test04

# Testing the usage of girt-log

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-log script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Try doing a girt-log before doing a girt-init, should produce error message
2041 girt-log

2041 girt-init

# Try doing a girt-log with command line arguments, should produce usage error
2041 girt-log f
2041 girt-log a b c

# Make lots of commits and then use test girt-log with correct syntax
touch a b c d e
2041 girt-add a
2041 girt-commit -m "This assignmnment is gonna be the death of me"
2041 girt-log
2041 girt-add b
2041 girt-commit -m "it's such a grinddddddd"
2041 girt-add c
2041 girt-commit -m "la la la la"
2041 girt-add d
2041 girt-commit -m "I haven't slept in days"
2041 girt-add e
2041 girt-commit -m "another assignment due Wednesday"
2041 girt-log
2041 girt-rm a b c d e

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-log script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Try doing a girt-log before doing a girt-init, should produce error message
girt-log

girt-init

# Try doing a girt-log with command line arguments, should produce usage error
girt-log f
girt-log a b c

# Make lots of commits and then use test girt-log with correct syntax
touch a b c d e
girt-add a
girt-commit -m "This assignmnment is gonna be the death of me"
girt-log
girt-add b
girt-commit -m "it's such a grinddddddd"
girt-add c
girt-commit -m "la la la la"
girt-add d
girt-commit -m "I haven't slept in days"
girt-add e
girt-commit -m "another assignment due Wednesday"
girt-log
girt-rm a b c d e

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test04 successfully. Congratulations!"
fi

rm 1.txt 2.txt
