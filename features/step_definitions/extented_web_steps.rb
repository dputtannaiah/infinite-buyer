#This file is an extension of default capybara steps. some of the capybara steps have been extended
#in this file so that one need not to write unrequired steps.
#Extends default
#USE: When I follow /<your-reg-exp>/
When /^I follow \/([^\/]*)\/$/ do |regexp_link|
  click_link(regexp_link)
end

#Override default webrat steps for link with regexp
#USE: When I follow /<your-reg-exp>/ within "<your traced DOM>"
When /^I follow \/([^\/]*)\/ within "([^\"]*)"$/ do |regexp_link, parent|
  click_link_within(parent, regexp_link)
end

When /^I submit form with id (.+)$/ do |form_id|
  page.evaluate_script("$('##{form_id}')[0].submit();")
end

When /^I submit form$/ do
  page.evaluate_script("document.forms[0].submit();")
end

#USE: Then response should be from /<your-reg-exp>/"
Then /^response should be from \/([^\/]*)\/$/ do |regexp|
  URI.parse(current_url).path.should =~ path_to(Regexp.new(regexp))
end

#=======================================================
Then /^It should not include tag "([^\"]*)"$/ do |tag|
  assert_have_no_selector(tag, :count => 0)
end

Then /^It should not include tag "([^\"]*)" within "([^\"]*)"$/ do |tag_match, parent|
  within parent do |scope|
    scope.should_not have_selector(tag_match, :count => 0)
  end
end

Then /^It should not include selector "([^\"]*)"$/ do |tag|
  step %{It should not include tag \"#{tag}\"}
end

Then /^It should not include selector "([^\"]*)" within "([^\"]*)"$/ do |tag_match, parent|
  step %{It should not include tag \"#{tag_match}\" within \"#{parent.to_s}\"}
end

Then /^It should include tag "([^\"]*)"$/ do |tag|
   page.has_selector?(tag)
end

Then /^It should include tag "([^\"]*)" within "([^\"]*)"$/ do |tag_match, parent|
  within parent do |scope|
    scope.should have_selector(tag_match, :count => 0)
  end
end

Then /^It should include selector "([^\"]*)"$/ do |tag|
  step %{It should include tag \"#{tag}\"}
end

Then /^It should include selector "([^\"]*)" within "([^\"]*)"$/ do |tag_match, parent|
  step %{It should include tag \"#{tag_match}\" within \"#{parent.to_s}\"}
end


And /^I follow \/([^\/]*)\/ containing span$/ do |text|
  page.find(:css, "a span", :text=> text).click
end

When /^I follow klass in span "([^\"]*)"$/ do |klass|
  page.find(:css, "a span.#{klass}").click
end

Then /^I see "([^"]*)" in span klass "([^\"]*)"$/ do |text, klass|
  page.find("a span.#{klass}", :text => text)
end

When /^I follow klass "([^\"]*)"$/ do |klass|
  page.find(:css, "a.#{klass}").click
end

When /^I follow div klass "([^\"]*)"$/ do |klass|
  page.find(:css, "div.#{klass}").click
end

When /^I press button "([^\"]*)"$/ do |klass|
  page.find(:css, "button.#{klass}").click
end

Then /^the "([^\"]*)" should be disabled$/ do |field|
  find_by_id("#{field}")['disabled'].should == "disabled"
end