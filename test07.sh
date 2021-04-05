#!/bin/dash

# test07

# Second half of my test scripts for girt-rm

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference girt-rm script with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

2041 girt-init

# Test the error message you get for --cached when index matches neither
echo "testing" > a.txt
2041 girt-add a.txt
echo "second line" >> a.txt
2041 girt-rm --cached a.txt

# Test the error message you get for --cached when index matches just current directory (should be no error message)
2041 girt-add a.txt
2041 girt-rm --cached a.txt

# Test the error message you get for --cached when index matches just most recent commit (should be no error message)
2041 girt-add a.txt
2041 girt-commit -m "hello"
echo "third line" >> a.txt
2041 girt-rm --cached a.txt

# Test the error message you get for no -- cached when index matches neither
2041 girt-add a.txt
echo "fourth line" >> a.txt
2041 girt-rm a.txt

# Test the error message you get for no -- cached when index matches just current directory
2041 girt-add a.txt
2041 girt-rm a.txt

# Test the error message you get for no -- cached when index matches just most recent commit
2041 girt-commit -m "hello"
echo "fifth line" >> a.txt
2041 girt-rm a.txt

# Test the error message you get for no -- cached when index matches both current directory and most recent commit (should be no error message)
2041 girt-add a.txt
2041 girt-commit -m "goodbye"
2041 girt-rm a.txt

# Test that girt-rm works for neither --force or --cached
echo "testingtesting" > a.txt
2041 girt-add a.txt
2041 girt-commit -m "yo yo"
2041 girt-rm a.txt
2041 girt-show :a.txt
if [ -e a.txt ]; then
    echo "This test was not successful"
else 
    echo "This test was successful"
fi

# Test that girt-rm works for --force but not --cached
echo "testingtesting" > a.txt
2041 girt-add a.txt
echo "another line" >> a.txt
2041 girt-rm --force a.txt
2041 girt-show :a.txt
if [ -e a.txt ]; then
    echo "This test was not successful"
else 
    echo "This test was successful"
fi

# Test that girt-rm works for --cached but not --force
echo "testingtesting" > a.txt
2041 girt-add a.txt
2041 girt-rm --cached a.txt
2041 girt-show :a.txt
if [ -e a.txt ]; then
    echo "This test was successful"
else 
    echo "This test was not successful"
fi

# Test that girt-rm works for --force and --cached
echo "testingtesting" > a.txt
2041 girt-add a.txt
echo "another line" >> a.txt
2041 girt-rm --force --cached a.txt
2041 girt-show :a.txt
if [ -e a.txt ]; then
    echo "This test was successful"
else 
    echo "This test was not successful"
fi

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my girt-rm script with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

girt-init

# Test the error message you get for --cached when index matches neither
echo "testing" > a.txt
girt-add a.txt
echo "second line" >> a.txt
girt-rm --cached a.txt

# Test the error message you get for --cached when index matches just current directory (should be no error message)
girt-add a.txt
girt-rm --cached a.txt

# Test the error message you get for --cached when index matches just most recent commit (should be no error message)
girt-add a.txt
girt-commit -m "hello"
echo "third line" >> a.txt
girt-rm --cached a.txt

# Test the error message you get for no -- cached when index matches neither
girt-add a.txt
echo "fourth line" >> a.txt
girt-rm a.txt

# Test the error message you get for no -- cached when index matches just current directory
girt-add a.txt
girt-rm a.txt

# Test the error message you get for no -- cached when index matches just most recent commit
girt-commit -m "hello"
echo "fifth line" >> a.txt
girt-rm a.txt

# Test the error message you get for no -- cached when index matches both current directory and most recent commit (should be no error message)
girt-add a.txt
girt-commit -m "goodbye"
girt-rm a.txt

# Test that girt-rm works for neither --force or --cached
echo "testingtesting" > a.txt
girt-add a.txt
girt-commit -m "yo yo"
girt-rm a.txt
girt-show :a.txt
if [ -e a.txt ]; then
    echo "This test was not successful"
else 
    echo "This test was successful"
fi

# Test that girt-rm works for --force but not --cached
echo "testingtesting" > a.txt
girt-add a.txt
echo "another line" >> a.txt
girt-rm --force a.txt
girt-show :a.txt
if [ -e a.txt ]; then
    echo "This test was not successful"
else 
    echo "This test was successful"
fi

# Test that girt-rm works for --cached but not --force
echo "testingtesting" > a.txt
girt-add a.txt
girt-rm --cached a.txt
girt-show :a.txt
if [ -e a.txt ]; then
    echo "This test was successful"
else 
    echo "This test was not successful"
fi

# Test that girt-rm works for --force and --cached
echo "testingtesting" > a.txt
girt-add a.txt
echo "another line" >> a.txt
girt-rm --force --cached a.txt
girt-show :a.txt
if [ -e a.txt ]; then
    echo "This test was successful"
else 
    echo "This test was not successful"
fi

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test07 successfully. Congratulations!"
fi

rm 1.txt 2.txt
