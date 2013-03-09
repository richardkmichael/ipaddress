require 'rubygems'
require 'rake'
require 'rake/clean'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ipaddress"
    gem.summary = %Q{IPv4/IPv6 addresses manipulation library}
    gem.email = "ceresa@gmail.com"
    gem.homepage = "http://github.com/bluemonk/ipaddress"
    gem.authors = ["Marco Ceresa"]
    gem.description   = <<-EOD
      IPAddress is a Ruby library designed to make manipulation 
      of IPv4 and IPv6 addresses both powerful and simple. It mantains
      a layer of compatibility with Ruby's own IPAddr, while 
      addressing many of its issues.
    EOD
  end
rescue LoadError
  message = 'Jeweler tasks "build", "version", "gemspec" are not available, "gem install jeweler".'

  desc message
  task :"[jeweler]" do
    abort message
  end
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  message = 'RCov tasks are not available, "gem install spicycode-rcov".'

  desc message
  task :rcov do
    abort message
  end
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  version = File.read('VERSION') rescue ''
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ipaddress #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => :test

desc "Open an IRB session preloaded with this library."
task :console do
  sh "irb -rubygems -I lib -r ipaddress.rb"
end

desc "Display FIXME, TODO and TBD tags in the code."
task :todo do
  todos = []
  Dir['**/*.rb'].each do |filename|
    count = 0
    open(filename) do |file|
      while line = file.gets
        count += 1
        if line =~ /(FIXME|TODO|TBD)/
          todos << "#{filename}:#{count}:#{line}"
        end
      end
    end
  end

  puts todos.any? ? todos : 'None found.'
end
