require "rubygems";
require "spec"

def code_root
  File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))
end

def codebases_path
  File.join(code_root, "codebases")
end

def tmp_path
  File.join(code_root, "tmp")
end

def blast_and_create_tmp!
  FileUtils.rm_rf(tmp_path)
  FileUtils.mkdir_p(tmp_path)
end

def extract_codebase!(codebase)
  `tar xfvz #{File.join(codebases_path, "#{codebase}.tgz")} -C #{tmp_path}`
  copy_generators!(codebase)
end

def copy_generators!(codebase)
  `cp -R #{code_root}/lib #{tmp_path}/#{codebase}/vendor/plugins/my_generators`
end