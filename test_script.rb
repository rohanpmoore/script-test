require('fileutils')
require('rspec')
require('pry')

def test_script()
  print "Enter directory name: "
  name = gets.chomp
  if name == ''
    print "Invalid directory name\n"
    return
  end
  print "Enter your file name (excluding the extension): "
  file_name = gets.chomp
  if file_name == ''
    print "Invalid file name\n"
    return
  end
  FileUtils.cd('..')
  FileUtils.mkdir(name)
  FileUtils.cd(name)
  FileUtils.mkdir("lib")
  FileUtils.mkdir("spec")
  FileUtils.touch("Gemfile")
  FileUtils.touch("lib/#{file_name}.rb")
  FileUtils.touch("spec/#{file_name}_spec.rb")
  FileUtils.touch("#{file_name}_script.rb")
  FileUtils.touch("README.md")
  gemfile_text = "source 'https://rubygems.org'\n\ngem 'rspec'\ngem 'pry'\ngem 'pivotal_git_scripts'\n"
  lib_text = "require 'pry'\n"
  spec_text = "require 'rspec'\nrequire '#{file_name}'"
  readme_text = "# _{Application Name}_\n\n#### _{Description, Date}_\n\n#### By _**{People}**_\n\n## Description\n\n_{Detailed description of app}_\n\n## Setup/Installation Requirements\n\n* _Instructions_\n* _go_\n* _here_\n\n## Known Bugs\n\n_{Bugs go here}_\n\n## Support and Contact Details\n\n_{Text here}_\n\n ### License\n\nLicensed under {License here}\nCopyright (c) {year} _**{Names/Initials}**_"
  print "We'll add gems rspec, pry, and pivotal_git_scripts to your Gemfile. Enter any additional gems you'd like to use separated by commas: "
  gems_string = gets.chomp
  if gems_string != ""
    gems = gems_string.split(', ')
    gems.each do |gem|
      gemfile_text += "gem '#{gem}'\n"
      lib_text += "require '#{gem}'\n"
    end
  end
  File.write('Gemfile',gemfile_text)
  File.write("lib/#{file_name}.rb", lib_text)
  File.write("spec/#{file_name}_spec.rb", spec_text)
end

test_script()
