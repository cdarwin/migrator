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

## Usage

First, the destination repos must already exist. At some point in the future, 
I may update the tool to create the destination repos. I use a Jenkins job to 
automate the migration. My Jenkins job is configured to watch this repo for 
changes and run the `migrator.rb` script. Generally, the changes that Jenkins 
notices are changes to the `repos.yml` file. 

In practice, teams managing a project in subversion will update the `repos.yml` 
file when they are ready to migrate. They push those changes back to this 
migration project, which kicks off a Jenkins job to do the actual migration.
