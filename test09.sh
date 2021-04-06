#!/bin/dash

# test09

# General test of all of my scripts together, I have pretty much covered every case
# up to here so now I am filling in my last case my combining all scripts together

export PATH=$PATH:.

################################################################################
# Tests for 2041 girt - these will write the expected output (for both stdout
# and stderr) of the reference scripts with the tests onto 1.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

2041 girt-init
2041 girt-commit -m "Attempted first commit"
echo "hello" > a
2041 girt-add a
2041 girt-commit -m "First commit" 
echo "A different line" > a
2041 girt-commit -a -m "Second commit" 
rm a
2041 girt-commit -a -m "third commit" 
touch a
2041 girt-add a
2041 girt-show 0:a
2041 girt-show 1:a
2041 girt-show 2:a
2041 girt-show :a
2041 girt-commit -m "fourth commit"
rm a
2041 girt-add a
2041 girt-commit -m "fifth commit"
touch e1 e2 e3 e4 e5
2041 girt-add e1 e2 e3 e4 e5
2041 girt-commit -m "sixth commit"
2041 girt-rm e1 e2 e3
echo "123" > e4
2041 girt-rm --force e4
2041 girt-rm --cached e5
rm e5
2041 girt-log

) > 1.txt 2>&1

################################################################################
# Tests for ./girt - these will write the output (for both stdout and stderr) of
# my scripts with the tests onto 2.txt
################################################################################

(

if [ -d .girt ]; then
    rm -r -f .girt
fi

girt-init
girt-commit -m "Attempted first commit"
echo "hello" > a
girt-add a
girt-commit -m "First commit" 
echo "A different line" > a
girt-commit -a -m "Second commit" 
rm a
girt-commit -a -m "third commit" 
touch a
girt-add a
girt-show 0:a
girt-show 1:a
girt-show 2:a
girt-show :a
girt-commit -m "fourth commit"
rm a
girt-add a
girt-commit -m "fifth commit"
touch e1 e2 e3 e4 e5
girt-add e1 e2 e3 e4 e5
girt-commit -m "sixth commit"
girt-rm e1 e2 e3
echo "123" > e4
girt-rm --force e4
girt-rm --cached e5
rm e5
girt-log

) > 2.txt 2>&1

################################################################################
                            # Comparing the 2 files
################################################################################

#In 2, get rid of the ./ in front of all of the calls to the scripts
echo "$(cat 2.txt | sed 's/.\///g')" > 2.txt

if diff 1.txt 2.txt; then
    echo "You have passed test09 successfully. Congratulations!"
fi

rm 1.txt 2.txt
