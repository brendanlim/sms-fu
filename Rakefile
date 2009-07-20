require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the sms_fu plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the sms_fu plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SmsFu'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "sms-fu"
    gemspec.summary = "SMS Fu allows ou to send a text-message for free in the form of an e-mail to a mobile recipient."
    gemspec.description = "SMS Fu allows ou to send a text-message for free in the form of an e-mail to a mobile recipient."
    gemspec.email = "brendangl@gmail.com"
    gemspec.homepage = "http://github.com/brendanlim/sms-fu"
    gemspec.authors = ["Brendan G. Lim"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
