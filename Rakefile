require 'cane/rake_task'

desc "Run code sanity checks"
Cane::RakeTask.new(:sanity) do |cane|
  cane.canefile = '.cane'
end

desc "Build the gem"
task :build => :sanity do
  sh 'gem', 'build', *Dir['*.gemspec']
end
