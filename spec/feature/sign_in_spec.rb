feature 'Sign in and out' do
  scenario 'user can sign in ' do
    sign_up
  end
  scenario 'user can sign out' do
  sign_up
  click_button 'Log Out'
  expect(page).to have_content "Successfully logged out"
  end
end

