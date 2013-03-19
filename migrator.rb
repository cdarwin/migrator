require 'yaml'
require 'fileutils'

class Migrator

  def initialize(repo, cwd)
    @base_dir = cwd
    @name = repo["name"]
    @svn_url = repo["svn_url"]
    @git_url = repo["git_url"]
    @s2gopts = repo["s2gopts"]
    Dir.chdir(@base_dir)
  end

  def mkdir
    puts "--> Creating #{@name} in #{Dir.getwd}"
    Dir.mkdir(@name)
    Dir.chdir(@name)
  end

  def svn_co
    puts "--> Checking out #{@svn_url} in #{Dir.getwd}"
    `svn2git #{@svn_url} #{@s2gopts} --verbose --authors #{@base_dir}/authors.txt`
  end

  def git_push
    puts "--> Adding remote #{@git_url}"
    `git remote add origin #{@git_url}`
    branches = `git branch | sed -e 's,\*,,'`
    branches.each_line do |branch|
      branch = branch.strip
      puts "--> Pushing branch: #{branch}"
      `git checkout #{branch}`
      `git pull origin #{branch}`
      `git push -u origin #{branch}`
    end
  end

  def clean_up
    Dir.chdir(@base_dir)
    puts "--> Removing #{@name} in #{Dir.getwd}"
    FileUtils.rm_rf @name
  end

  def migrate
    mkdir
    svn_co
    git_push
    clean_up
  end

end

repos = YAML.load_file('repos.yml')
cwd = Dir.getwd

repos["repository"].each do |repo|
  puts "\n## Begin migrating #{repo["name"]} project ##\n\n"
  m = Migrator.new(repo, cwd)
  m.migrate
  puts "\n## Finished migrating #{repo["name"]} project ##\n\n"
end
