
tests_dir = File.expand_path(File.join(File.dirname(__FILE__), 'tests'))

task :default do
  sh "rake -T"
end

namespace :test do 

  desc "run all tests"
  task :all do
    Dir.glob("#{tests_dir}/*_test.rb").each { |file| sh "ruby #{file}" }
  end

end
