
Given /^(?:|I )am signed in and my first name is "([^\"]*)" and last name is "([^\"]*)"(?: and I can "([^\"]*)")?$/ do |first_name, last_name, beta_user|

  person = AuthenticationModels::Person.new.create_invite first_name, last_name, "#{first_name}.#{last_name}@17jobs.com"
  person.beta_user = beta_user
  person.save
  
  visit "/authentication/login/#{person.id}"
end

Given /^(?:|I )have signed in before using my LinkedIn account$/ do

  person = AuthenticationModels::Person.new.get_by_email 'Mark.Nijhof@17jobs.com'
  
  openid_provider = AuthenticationModels::OpenidProvider.new
  openid_provider.provider_name = 'LinkedIn'
  openid_provider.oauth_token_secret = 'b9a25a64-c71e-426c-adbc-b5e2be4854e3'
  openid_provider.oauth_token = '21c076da-a12f-45c8-a28a-2e2e274e3497'
  person.OpenidProviders << openid_provider
  openid_provider.save
  person.save
end

Given /^(?:|I )have imported my LinkedIn profile before with the following attributes:$/ do |table|

  person = AuthenticationModels::Person.new.get_by_email 'Mark.Nijhof@17jobs.com'
  
  table.hashes.each do |attributes|
    profile = LinkedInModels::Profile.create! attributes
    profile.person_id = person.id
    profile.save
  end
end

Given /^(?:|My )imported LinkedIn profile has the following positions:$/ do |table|

  person = AuthenticationModels::Person.new.get_by_email 'Mark.Nijhof@17jobs.com'
  profile = LinkedInModels::Profile.new.get_by_person_id person.id

  table.hashes.each do |attributes|
    profile.positions << LinkedInModels::Position.new do |position|
      position.title = attributes[:title]
      position.summary = attributes[:summary]
      position.start_year = attributes[:start_year]
      position.start_month = attributes[:start_month]
      position.end_year = attributes[:end_year]
      position.end_month = attributes[:end_month]
      position.is_current = attributes[:is_current]
  
      position.company = LinkedInModels::Company.new do |company|
        company.company_type = attributes[:company_type]
        company.name = attributes[:name]
        company.industry = attributes[:industry]
      end
    end
  end
  profile.save
end


