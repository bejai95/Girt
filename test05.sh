#!/bin/dash

# test05

# Testing the usage of girt-show

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-show script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test girt-show before girt-init, should produce error message
2041 girt-show

2041 girt-init

# Test when giving 0 or more than 1 command line argument, should produce usage error
2041 girt-show
2041 girt-show 1 2
2041 girt-show 1 2 3

# Test giving objects not of the form [commit]:filename, should produce error
2041 girt-show a
2041 girt-show 123
2041 girt-show 0.5

# Test giving the correct object format, but a commit number that doesn't exist
2041 girt-show a:hello
2041 girt-show 0:z

# Test giving commit that does exist or just : but an invalid filename, should produce error
echo "Stuff" > a
2041 girt-add a
2041 girt-commit -m "yo yo yo"
2041 girt-show 0:b
2041 girt-show :b

# Test showing empty files (should do nothing)
touch b
2041 girt-add b
2041 girt-commit -m "yo yo yo"
2041 girt-show 1:b
2041 girt-show :b

# Create several commits with different versions of the same file and show them all
echo "line 1" > a
2041 girt-commit -a -m "yo yo yo"
echo "line 2" > a
2041 girt-commit -a -m "yo yo yo"
echo "line 3" > a
2041 girt-commit -a -m "yo yo yo"
echo "line 4" > a
2041 girt-add a
2041 girt-show 2:a
2041 girt-show 3:a
2041 girt-show 4:a
2041 girt-show :a
rm a b

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-show script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

# Test girt-show before girt-init, should produce error message
girt-show

girt-init

# Test when giving 0 or more than 1 command line argument, should produce usage error
girt-show
girt-show 1 2
girt-show 1 2 3

# Test giving objects not of the form [commit]:filename, should produce error
girt-show a
girt-show 123
girt-show 0.5

# Test giving the correct object format, but a commit number that doesn't exist
girt-show a:hello
girt-show 0:z

# Test giving commit that does exist or just : but an invalid filename, should produce error
echo "Stuff" > a
girt-add a
girt-commit -m "yo yo yo"
girt-show 0:b
girt-show :b

# Test showing empty files (should do nothing)
touch b
girt-add b
girt-commit -m "yo yo yo"
girt-show 1:b
girt-show :b

# Create several commits with different versions of the same file and show them all
echo "line 1" > a
girt-commit -a -m "yo yo yo"
echo "line 2" > a
girt-commit -a -m "yo yo yo"
echo "line 3" > a
girt-commit -a -m "yo yo yo"
echo "line 4" > a
girt-add a
girt-show 2:a
girt-show 3:a
girt-show 4:a
girt-show :a
rm a b

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test05 successfully. Congratulations!"
fi

rm 1.txt 2.txt
