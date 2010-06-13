
require 'uri'
require 'cgi'

not_in_script_and_not_hidden = "//*[not(descendant-or-self::script) and not(contains(@style,'display: none;') and ancestor::*[not(contains(@style,'display: none;'))])]"
not_in_script_and_hidden = "//*[not(descendant-or-self::script)][contains(@style,'display: none;') or ancestor::*[contains(@style,'display: none;')]]"

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )am on "(.+)"$/ do |page_name|
  #announce_world
  visit page_name
end

When /^(?:|I )go to "(.+)"$/ do |page_name|
  visit page_name
end




When /^(?:|I )click on "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    locate('//*[@id="' +  button + '"]').click
  end
end

When /^(?:|I )follow "([^\"]*)"(?: within "([^\"]*)")?$/ do |link, selector|
  with_scope(selector) do
    locate('//a["' + link + '"]').click
  end
end




When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )fill in "([^\"]*)" for "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

# Use this to fill in an entire form with data from a table. Example:
#
# When I fill in the following:
# | Account Number | 5002 |
# | Expiry date | 2009-11-01 |
# | Note | Nice guy |
# | Wants Email? | |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following(?: within "([^\"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |name, value|
      When %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

When /^(?:|I )check "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When /^(?:|I )uncheck "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    uncheck(field)
  end
end

When /^(?:|I )choose "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

When /^(?:|I )attach the file "([^\"]*)" to "([^\"]*)"(?: within "([^\"]*)")?$/ do |path, field, selector|
  with_scope(selector) do
    attach_file(field, path)
  end
end





Then /^(?:|I )should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

Then /the "([^\"]*)" will be disabled/ do |button_id|
  page.should have_xpath("//*[@id='#{button_id}'][contains(@class, 'button-disabled')]")
end

Then /(?:|I )should see a link "([^\"]*)"(?: to "([^\"]*)")?$/ do |text, url|
  if url.nil?
    page.should have_xpath("#{not_in_script_and_not_hidden}[contains(normalize-space(a),#{Capybara::XPath.escape(text)})]")
  else
    page.should have_xpath("#{not_in_script_and_not_hidden}[contains(normalize-space(a[@href='#{url}']),#{Capybara::XPath.escape(text)})]")
  end
end

Then /(?:|I )should see an image "(.*)"(?: within "([^\"]*)")?$/ do |url, selector|
  with_scope(selector) do
    page.should have_xpath("//img[@src='#{url}']")
  end
end

Then /(?:|I )should see a button "(.*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    page.should have_xpath("#{not_in_script_and_not_hidden}[contains(@class, 'button')][contains(normalize-space(.),#{Capybara::XPath.escape(text)})]")
  end
end

Then /(?:|I )should not see a button "(.*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    page.should have_no_xpath("#{not_in_script_and_hidden}[contains(@class, 'button')][contains(normalize-space(.),#{Capybara::XPath.escape(text)})]")
  end
end

Then /^(?:|I )should see$/ do |text|
  page.should have_xpath("#{not_in_script_and_not_hidden}[contains(normalize-space(.),#{Capybara::XPath.escape(text)})]")
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    page.should have_xpath("#{not_in_script_and_not_hidden}[contains(normalize-space(.),#{Capybara::XPath.escape(text)})]")
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    page.should have_xpath('#{not_in_script_and_not_hidden}', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    page.should have_no_xpath("#{not_in_script_and_hidden}[contains(normalize-space(.),#{Capybara::XPath.escape(text)})]")
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    page.should have_no_xpath('#{not_in_script_and_hidden}', :text => regexp)
  end
end


Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    field_value.should =~ /#{value}/
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should not contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    field_value.should_not =~ /#{value}/
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    field_checked.should == 'checked'
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should not be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    field_checked.should_not == 'checked'
  end
end
 
Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}
  
  actual_params.should == expected_params
end

Then /^show me the page$/ do
  save_and_open_page
end