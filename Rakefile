require 'rake'
require 'spec/rake/spectask'
require 'cucumber/rake/task'

task :default => :spec
task :default => :features

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--options', 'spec/spec.opts']
end

desc "Run all features"
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty"
end

namespace :codebase do
  
  archived_codebases_path = File.expand_path(File.join(File.dirname(__FILE__), "codebases"))
  extracted_codebases_path = File.expand_path(File.join(File.dirname(__FILE__), "extracted_codebases"))
  
  desc "Takes all codebases and extracts them in #{extracted_codebases_path}"
  task :extract => :purge do
    FileUtils.mkdir_p extracted_codebases_path
    Dir["#{archived_codebases_path}/*.tgz"].each do |archive|
      puts "Extracting #{File.basename(archive)}"

      `tar xvfz #{archive} -C #{extracted_codebases_path}`
    end
  end
  
  desc "Takes all extracted codebases and re-archives them" 
  task :archive do
    FileUtils.mkdir_p archived_codebases_path
    Dir["#{extracted_codebases_path}/*"].each do |extracted_codebase|
      new_archive = "#{File.basename(extracted_codebase)}.tgz"
      puts "Archiving #{new_archive}"

      `tar cfvz #{archived_codebases_path}/#{new_archive} -C #{File.dirname(extracted_codebase)} #{File.basename(extracted_codebase)}`
    end
  end
  
  desc "Deletes extracted codebases"
  task :purge do
    FileUtils.rm_rf extracted_codebases_path
  end
end