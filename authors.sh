#!/bin/sh -e

if [ $# -ne 1 ]
then
  echo "You must supply exactly one argument in the form of an svn repository"
  exit 1
fi

SVNURL=$1

# Get a log of the projects' authors
echo "--> Getting authors log from $SVNURL"
svn log --quiet $SVNURL | grep -E "r[0-9]+ \| .+ \|" | awk '{print $3}' | sort | uniq >> authors.txt

echo "--> Convert svn authors file to git format"
echo "    username = First Last <username@domain.com>"
$EDITOR authors.txt

exit 0
