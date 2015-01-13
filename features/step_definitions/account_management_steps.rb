# user = FactoryGirl.create(:user)
# login_as(user, :scope => :user)

require 'factory_girl'

Given(/^I am a new user to the site$/) do
  visit '/'
end

When(/^I create an account$/) do
  click_link 'Sign Up'
  expect(current_path).to eq(new_user_registration_path)
  within('form') do
    fill_in 'Email', with: 'gunmetal69@msn.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
  end
end

Then(/^I should be successfully signed up$/) do
  expect(page).to have_content("Welcome! You have signed up successfully.")
end

Given(/^I have an exisiting login$/) do
  @user = FactoryGirl.create(:user)
end

When(/^I login$/) do
  visit '/'
  click_link 'Sign In'
  within('form') do
    fill_in 'Email', with:   @user.email
    fill_in 'Password', with:   @user.password
    click_button 'Log In'
  end
end

Then(/^I should be successfully signed in$/) do
  expect(page).to have_content("Signed in successfully.")
end

Given(/^a logged in user$/) do
  @user = FactoryGirl.create(:user)
  visit '/'
  click_link 'Sign In'
  within('form') do
    fill_in 'Email', with:   @user.email
    fill_in 'Password', with:   @user.password
    click_button 'Log In'
  end
  expect(page).to have_content("Signed in successfully.")
end

When(/^I logout$/) do
  click_link 'Sign out'
end

Then(/^the system should log me out of the system$/) do
  expect(page).to have_content("Signed out successfully.")
end

Then(/^I should not be able to use the features available only to logged in users$/) do
  # Need to have other paths to test the redirect
  visit '/'
  expect(current_path).to eq(root_path)
end

Given(/^the login id is "(.*?)" and password is "(.*?)"$/) do |arg1, arg2|
  @user1 = User.create!(email: arg1, password: arg2)
  # @user = FactoryGirl.create(:user)
end

When(/^I enter "(.*?)" and "(.*?)"$/) do |arg1, arg2|
  visit '/'
  click_link 'Sign In'
  within('form') do
    fill_in 'Email', with:   arg1
    fill_in 'Password', with:   arg2
    click_button 'Log In'
  end
end

Then(/^the message should be "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end
