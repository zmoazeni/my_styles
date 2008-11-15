Given(/^I'm using a (.*) code base$/) do |key|
  key = key.downcase.gsub(" ", "")
  available_codebases = { "rails2.2" => File.join(codebases_path, "2.2") }
  available_codebases.keys.should include(key)
  
  blast_and_create_tmp!
  extract_codebase!(key)
  @current_codebase = File.join(tmp_path, key)
end

When /^I generate '(.*)'$/ do |command|
  `#{@current_codebase}/script/generate #{command}`
end

Then /^all the tests should pass$/ do
  output = `cd #{@current_codebase} && rake spec`
  output.should match(/0 failures/i)
  $?.exitstatus.should == 0
end