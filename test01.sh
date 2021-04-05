#!/bin/dash

# test01

# Testing the usage of girt-add

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-add script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test girt-add before girt-init, should produce error
2041 girt-add

2041 girt-init

# Test girt-add when given no command-line arguments, should produce error
2041 girt-add

# Test girt-add when given command line arguments that start with -[a-zA-Z._]
# or --. , should produce error usage error. This should take precedence over
# invalid filename errors
2041 girt-add --hello
2041 girt-add a b c d e --hello
2041 girt-add a b c d e --4
2041 girt-add a b c d e --.
2041 girt-add a b c d e -e

# Command line arguments such as - or -0 or -- by themselves should not produce
# usage error messages
2041 girt-add a b c d e - -0 --
2041 girt-add diary.txt - -0 --

# Filenames that start with . or _ are invalid
2041 girt-add .hello
2041 girt-add _hello

# Test when given files that don't exist, should produce error
2041 girt-add a b c d e

# Test when given a file that does exist, but is not an ordinary file
mkdir test_dir
2041 girt-add test_dir
rm -r test_dir

# Test girt-add when it is adding new files to the index
echo 1 > a
echo 2 > b
echo 3 > c
2041 girt-add a b c
2041 girt-show :a
2041 girt-show :b
2041 girt-show :c

# Test girt-add when it is adding changed files to the index
echo "testtesttesttest" >> a
2041 girt-add a b c
2041 girt-show :a

# Test girt-add when it is removing files from the index
rm a b c
2041 girt-add b c
2041 girt-show :b
2041 girt-show :c

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-add script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test girt-add before girt-init, should produce error
girt-add

girt-init

# Test girt-add when given no command-line arguments, should produce error
girt-add

# Test girt-add when given command line arguments that start with -[a-zA-Z._]
# or --. , should produce error usage error. This should take precedence over
# invalid filename errors
girt-add --hello
girt-add a b c d e --hello
girt-add a b c d e --4
girt-add a b c d e --.
girt-add a b c d e -e

# Command line arguments such as - or -0 or -- by themselves should not produce
# usage error messages
girt-add a b c d e - -0 --
girt-add diary.txt - -0 --

# Filenames that start with . or _ are invalid
girt-add .hello
girt-add _hello

# Test when given files that don't exist, should produce error
girt-add a b c d e

# Test when given a file that does exist, but is not an ordinary file
mkdir test_dir
girt-add test_dir
rm -r test_dir

# Test girt-add when it is adding new files to the index
echo 1 > a
echo 2 > b
echo 3 > c
girt-add a b c
girt-show :a
girt-show :b
girt-show :c

# Test girt-add when it is adding changed files to the index
echo "testtesttesttest" >> a
girt-add a b c
girt-show :a

# Test girt-add when it is removing files from the index
rm a b c
girt-add b c
girt-show :b
girt-show :c

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test01 successfully. Congratulations!"
fi

rm 1.txt 2.txt
