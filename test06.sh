#!/bin/dash

# test06

# First half of my test scripts for girt-rm

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-rm script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test when girt-rm is used before girt-init, should procuce error
2041 girt-rm

2041 girt-init

# Test girt-rm when no command line arguments are given
2041 girt-rm

# Test girt-rm when no more command line arguemnts are given after options
2041 girt-rm --force --cached
2041 girt-rm --force
2041 girt-rm --cached

# Test girt-rm when other command line arguments start with -[a-zA-Z._] or --. ,
# should produce error usage error. This should take precedence over invalid 
# filename errors
2041 girt-rm --force --cached --hello
2041 girt-rm --force --4
2041 girt-rm --cached --.
2041 girt-rm a b c d -e
2041 girt-rm 1 2 3 -A

# Command line arguments such as - or -0 or -- by themselves should not produce
# usage error messages
2041 girt-rm a b c d e - -0 --

# Test girt-rm giving invalid filenames as command line arguments
2041 girt-rm --force --cached .hello
2041 girt-rm --force _hello

# Test girt-rm giving filenames which are valid but do not exist within the index
2041 girt-rm --cached a b c d e

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-rm script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test when girt-rm is used before girt-init, should procuce error
girt-rm

girt-init

# Test girt-rm when no command line arguments are given
girt-rm

# Test girt-rm when no more command line arguemnts are given after options
girt-rm --force --cached
girt-rm --force
girt-rm --cached

# Test girt-rm when other command line arguments start with -[a-zA-Z._] or --. ,
# should produce error usage error. This should take precedence over invalid 
# filename errors
girt-rm --force --cached --hello
girt-rm --force --4
girt-rm --cached --.
girt-rm a b c d -e
girt-rm 1 2 3 -A

# Command line arguments such as - or -0 or -- by themselves should not produce
# usage error messages
girt-rm a b c d e - -0 --

# Test girt-rm giving invalid filenames as command line arguments
girt-rm --force --cached .hello
girt-rm --force _hello

# Test girt-rm giving filenames which are valid but do not exist within the index
girt-rm --cached a b c d e

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test06 successfully. Congratulations!"
fi

rm 1.txt 2.txt
