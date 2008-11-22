Given(/^I'm using a (.*) code base$/) do |key|
  key = key.downcase.gsub(" ", "")
  available_codebases = { "rails2.2" => File.join(codebases_path, "2.2") }
  available_codebases.keys.should include(key)
  
  blast_and_create_tmp!
  extract_codebase!(key)
  @current_codebase = File.join(tmp_path, key)
end

When /^I generate '(.*)'$/ do |command|
  output = `#{@current_codebase}/script/generate #{command}`
  # puts output
  output.should_not match(/No such file or directory/i)
  $?.exitstatus.should == 0
end

Then /^'(.*)' should be created$/ do |file_path|
  File.exist?(File.join(@current_codebase, file_path)).should be_true
end

Then /^all the tests should pass$/ do
  output = `cd #{@current_codebase} && rake spec`
  # puts output
  output.should_not match(/\s0 examples/i)
  output.should match(/0 failures/i)
  $?.exitstatus.should == 0
end

Then /^the routes should be updated$/ do
  routes = File.read(File.join(@current_codebase, "config", "routes.rb"))
  routes.should match(/^\s*map\.resources :/i)
end

Then /^the following files should be created:$/ do |file_table|
  file_table.hashes.each do |hash|
    Then "'#{hash['file']}' should be created"
  end
end