# frozen_string_literal: true

feature 'Log in and out' do
  scenario 'user can access login page' do
    sign_up_bobby
    click_button 'Log out'
    click_button 'Login'
    expect(page).to have_field 'username'
    expect(page).to have_field 'password'
    expect(page).to have_button 'Log in'
  end

  scenario 'can fill in details and reach home' do
    sign_up_bobby
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username',	with: 'Bob'
    fill_in 'password',	with: 'Bob1'
    click_button 'Log in'
    expect(page).to have_content 'Welcome, Bobby'
    expect(current_path).to eq '/'
  end

  scenario 'user is informed they entered username wrong' do
    visit '/'
    click_button 'Login'
    fill_in 'username',	with: 'Bob'
    fill_in 'password',	with: 'Bob1'
    click_button 'Log in'
    expect(page).to have_content 'No such username'
  end

  scenario 'user is informed they entered password wrong' do
    sign_up_bobby
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username',	with: 'Bob'
    fill_in 'password',	with: 'Bob2'
    click_button 'Log in'
    expect(page).to have_content 'Your password is incorrect'
  end

  scenario 'user can log out' do
    sign_up_bobby
    click_button 'Log out'
    expect(page).to have_content 'Successfully logged out'
  end
end
