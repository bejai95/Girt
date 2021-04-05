#!/bin/dash

# test03

# Testing the usage of girt-commit with the -a option

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-commit script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

2041 girt-init

# Test on first commit when there are no files in the index, should output "nothing to commit"
2041 girt-commit -a -m "hello"

# Test on first commit when there are files in the index
echo "12345" > a
echo "12345" > b
2041 girt-add a b
2041 girt-commit -a -m "yeah na"

# Test adding after first commit
echo "12345" > c
2041 girt-add c
2041 girt-commit -a -m "yesssss"

# Test when the files in the index get changed
echo "Adding different stuff" >> b
2041 girt-commit -a -m "na yeah"
2041 girt-show 0:b
2041 girt-show 2:b

# Make sure c doesn't exist on first commit
2041 girt-show 0:c

# Test when there are no files changed, should output "nothing to commit"
2041 girt-commit -a -m "yeah yeah"

# Test after removing files from the current directory
rm a b
2041 girt-commit -a -m noooooooooo
2041 girt-show 3:a
2041 girt-rm c
2041 girt-commit -a -m "Go Hawthorn"

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-commit script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

girt-init

# Test on first commit when there are no files in the index, should output "nothing to commit"
girt-commit -a -m "hello"

# Test on first commit when there are files in the index
echo "12345" > a
echo "12345" > b
girt-add a b
girt-commit -a -m "yeah na"

# Test adding after first commit
echo "12345" > c
girt-add c
girt-commit -a -m "yesssss"

# Test when the files in the index get changed
echo "Adding different stuff" >> b
girt-commit -a -m "na yeah"
girt-show 0:b
girt-show 2:b

# Make sure c doesn't exist on first commit
girt-show 0:c

# Test when there are no files changed, should output "nothing to commit"
girt-commit -a -m "yeah yeah"

# Test after removing files from the current directory
rm a b
girt-commit -a -m noooooooooo
girt-show 3:a
girt-rm c
girt-commit -a -m "Go Hawthorn"

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test03 successfully. Congratulations!"
fi

rm 1.txt 2.txt
