task :default => [:spec]
desc 'run Rspec specs'
task :spec do
  sh 'rspec spec'
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end
