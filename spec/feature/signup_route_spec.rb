# frozen_string_literal: true

feature 'Checking the homepage' do
  scenario 'holds the welcome' do
    visit('/')
    expect(page).to have_content 'Welcome to MakersBnB'
  end

  scenario 'There are fields for signing up' do
    visit('/')

    expect(page).to have_content 'Sign Up'
    expect(page).to have_field 'username'
    expect(page).to have_field 'password'
    expect(page).to have_field 'name'
    expect(page).to have_field 'email'
    expect(page).to have_button 'Sign up'
  end

  scenario 'Signing up redirects to listing page with personalised welcome message' do
    visit('/')
    fill_in 'username',	with: 'Bob'
    fill_in 'password',	with: 'Bob1'
    fill_in 'name',	with: 'Bobby'
    fill_in 'email',	with: 'robertnotbobby@example.com'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome, Bobby'
  end
end
