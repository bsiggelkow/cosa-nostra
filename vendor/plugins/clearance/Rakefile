require 'rake'
require 'rake/testtask'
require 'date'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

def gem_files
  FileList["[A-Z]*", "{generators,lib}/**/*"]
end

test_files_pattern = 'test/rails_root/test/{unit,functional,other}/**/*_test.rb'
namespace :test do
  Rake::TestTask.new(:all => 'generator:tests') do |t|
    t.libs << 'lib'
    t.pattern = test_files_pattern
    t.verbose = false
  end

  desc "Run all specs in spec directory (excluding plugin specs)"
  Spec::Rake::SpecTask.new(:spec) do |t|
    t.spec_opts = ['--options', "\"test/rails_root/spec/spec.opts\""]
    t.spec_files = FileList['test/rails_root/spec/**/*_spec.rb']
  end
end

desc "Run the test suite"
task :default => ['test:all', 'test:spec']

load 'lib/clearance/version.rb'

gemspec_doc = <<-GEMSPEC_DOC
  s.date = "#{Date.today.strftime('%Y-%m-%d')}"
  s.name = "clearance"
  s.summary = "Fork of clearance, not-purely-restful, but with Facebook goodness"
  s.email = "info@hashrocket.com"
  s.version = "#{Clearance::Version::MAJOR}.#{Clearance::Version::MINOR}.#{Clearance::Version::PATCH}"
  s.homepage = "http://github.com/hashrocket/clearance"
  s.description = "Fork of clearance, not-purely-restful, but with Facebook goodness"
  s.authors = [
    "thoughtbot, inc.",
    "Dan Croak",
    "Josh Nichols",
    "Jason Morrison",
    "Mike Burns",
    "Mike Breen",
    "Hashrocket, Inc.",
    "Les Hill",
    "Jon Larkowski",
    "Wes Gibbs", 
    "Durran Jordan"
  ]
GEMSPEC_DOC

spec = Gem::Specification.new do |s|
  eval(gemspec_doc)
  s.files = gem_files
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

namespace :generator do
  desc "Run the generator on the tests"
  task :tests do
    system "mkdir -p test/rails_root/vendor/plugins/clearance"
    system "cp -R generators test/rails_root/vendor/plugins/clearance"
    system "cd test/rails_root; ./script/generate clearance"
  end
end

desc "Generate the Clearance gemspec"
task :gemspec do
  
  File.open("clearance.gemspec", "w") do |file|
    file.write "Gem::Specification.new do |s|\n"
    file.write(gemspec_doc)
    file.write  "  s.files = [\n"
    file.write gem_files.map {|f| %Q{    "#{f}"}}.join(",\n")
    file.write "  ]\n"
    file.write "end\n"
  end
end

