#!/bin/dash

# test02

# Testing the usage of girt-commit (but not the functionality of the -a flag)

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-commit script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test committing before doing a girt-init, should produce error
2041 girt-commit

2041 girt-init

# Try committing with 0, 1, or 4 command line arguments, should produce usage error
2041 girt-commit
2041 girt-commit a
2041 girt-commit a b c d
2041 girt-commit -a -m a g

# Try committing with 2 or 3 command line arguments but without correct options
# should produce usage error
2041 girt-commit a b
2041 girt-commit a b c
2041 girt-commit -a m "Hello"
2041 girt-commit a -m "Hello"
2041 girt-commit m "Hello"

# Try committing with correct options but not enough arguments, usage error
2041 girt-commit -a -m
2041 girt-commit -m
 
# Try committing before adding any files to the index, should say "nothing to commit"
2041 girt-commit -m "Hello how are you"

# Try doing 2 commits in a row, should say "nothing to commit"
2041 girt-add diary.txt
2041 girt-commit -m "Hello how are you"
2041 girt-commit -m "Hello how are you"

# Try comitting twice in a when it is no longer the first commit, should say "nothing to commit"
2041 girt-add girt-init
2041 girt-commit -m "My name is Bejai"
2041 girt-commit -m "My name is Bejai"

# Test that comitting works when new files are added to the index
touch a b
echo "random stuff" >> b
2041 girt-add a b
2041 girt-commit -m "1 2 3"
2041 girt-log

# Test that comitting works when files are changed between commits
echo "I am not enjoying this assignemnt" >> a
2041 girt-add a
2041 girt-commit -m "1 2 3"
echo "It takes far too long" >> a
2041 girt-add a
2041 girt-commit -m "1 2 3"
2041 girt-log
2041 girt-show 2:a
2041 girt-show 3:a
2041 girt-show 4:a

# Test that comitting works when files are removed between commits
rm a
2041 girt-add a
2041 girt-commit -m "1 2 3"
2041 girt-show 5:a
2041 girt-rm b
2041 girt-commit -m "1 2 3"
2041 girt-show 5:b
2041 girt-show 6:b

# Take one final look at girt-log to make the commit messsages are working correctly
2041 girt-log

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-commit script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test committing before doing a girt-init, should produce error
girt-commit

girt-init

# Try committing with 0, 1, or 4 command line arguments, should produce usage error
girt-commit
girt-commit a
girt-commit a b c d
girt-commit -a -m a g

# Try committing with 2 or 3 command line arguments but without correct options
# should produce usage error
girt-commit a b
girt-commit a b c
girt-commit -a m "Hello"
girt-commit a -m "Hello"
girt-commit m "Hello"

# Try committing with correct options but not enough arguments, usage error
girt-commit -a -m
girt-commit -m
 
# Try committing before adding any files to the index, should say "nothing to commit"
girt-commit -m "Hello how are you"

# Try doing 2 commits in a row, should say "nothing to commit"
girt-add diary.txt
girt-commit -m "Hello how are you"
girt-commit -m "Hello how are you"

# Try comitting twice in a when it is no longer the first commit, should say "nothing to commit"
girt-add girt-init
girt-commit -m "My name is Bejai"
girt-commit -m "My name is Bejai"

# Test that comitting works when new files are added to the index
touch a b
echo "random stuff" >> b
girt-add a b
girt-commit -m "1 2 3"
girt-log

# Test that comitting works when files are changed between commits
echo "I am not enjoying this assignemnt" >> a
girt-add a
girt-commit -m "1 2 3"
echo "It takes far too long" >> a
girt-add a
girt-commit -m "1 2 3"
girt-log
girt-show 2:a
girt-show 3:a
girt-show 4:a

# Test that comitting works when files are removed between commits
rm a
girt-add a
girt-commit -m "1 2 3"
girt-show 5:a
girt-rm b
girt-commit -m "1 2 3"
girt-show 5:b
girt-show 6:b

# Take one final look at girt-log to make the commit messsages are working correctly
girt-log

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test02 successfully. Congratulations!"
fi

rm 1.txt 2.txt
