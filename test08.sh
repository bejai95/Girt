#!/bin/dash

# test08

# Testing the usage of girt-status

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-status script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test girt-status when there hasn't yet been an init, should produce usage error message
2041 girt-status

2041 girt-init

# Test girt-status with command line arguments, doesn't affect it
echo "123" > a
2041 girt-status a b c 1 2 3
# The above test shows what happens when the file is not added to the index

# Test what happens to files that have been added to the index, are the same in the current directory as the index, and are the same in the previous commit as the index
2041 girt-add a
2041 girt-commit -m "Yep"
2041 girt-status

# Test what happens to files that have been added to the index, are the same in the current directory as the index, and are not the same as the index in the previous commit
echo "blah blah" > a
2041 girt-add a
2041 girt-status

# Test what happens to files that have been added to the index, have been changed in the current directory, and are the same in the previous commit
2041 girt-commit -m "Hello"
echo "na" > a
2041 girt-add a
echo "blah blah" > a
2041 girt-status
rm a

) > 1.txt 2>&1

# Unfortunately I've ran out of time now, but have covered pretty much every case
# for all of the other scripts

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-status script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test girt-status when there hasn't yet been an init, should produce usage error message
girt-status

girt-init

# Test girt-status with command line arguments, doesn't affect it
echo "123" > a
girt-status a b c 1 2 3
# The above test shows what happens when the file is not added to the index

# Test what happens to files that have been added to the index, are the same in the current directory as the index, and are the same in the previous commit as the index
girt-add a
girt-commit -m "Yep"
girt-status

# Test what happens to files that have been added to the index, are the same in the current directory as the index, and are not the same as the index in the previous commit
echo "blah blah" > a
girt-add a
girt-status

# Test what happens to files that have been added to the index, have been changed in the current directory, and are the same in the previous commit
girt-commit -m "Hello"
echo "na" > a
girt-add a
echo "blah blah" > a
girt-status
rm a

) > 2.txt 2>&1

# Unfortunately I've ran out of time now, but have covered pretty much every case
# for all of the other scripts

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test08 successfully. Congratulations!"
fi

rm 1.txt 2.txt
