#!/bin/dash

# test00

# Testing the usage of girt-init

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-rm script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test when giving command line arguments, should produce error
2041 girt-init hello

# Test that when girt-init is given no command line arguments, it does create an 
# empty Girt repository
2041 girt-init

# Test when .girt repository already exists, should produce error
2041 girt-init
2041 girt-init

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-rm script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test when giving command line arguments, should produce error
girt-init hello

# Test that when girt-init is given no command line arguments, it does create an 
# empty Girt repository
girt-init

# Test when .girt repository already exists, should produce error
girt-init
girt-init

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test00 successfully. Congratulations!"
fi

rm 1.txt 2.txt
