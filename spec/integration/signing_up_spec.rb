require 'spec_helper'

feature 'Signing up' do
  scenario 'Successful sign up' do
    visit '/'
    click_link 'Sign up'
  end
end