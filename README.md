migrator
========

A set of scripts to help facilitate migrating subversion repositories to GitHub

## Authors

Convert subversion authors to git format.

Run the included `authors.sh` script with a single argument in the form of a 
subversion URL to the root of a repo you would like to migrate.

    $ ./authors.sh https://svn.apache.org/repos/asf/excalibur

The end of this script will open the `authors.txt` file with your `$EDITOR`. 
You need to update the listed users to the form described on the 
[svn2git page](https://github.com/nirvdrum/svn2git#authors)

## Configure Repos

Edit the `repos.yml` file to include the repositories you want to migrate. 
Each repo should have at least three key/value pairs. Mandatory fields are 
`name`, `snv_url`, and `git_url`. Optional field, `s2gopts`, is necessary when 
the subversion repo has no trunk, tags, or branches.
