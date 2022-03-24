feature "Delete account" do
  scenario "deleting your account means you cannot log in" do
    sign_up_bobby
    click_button 'Settings'
    click_button 'Delete Account'
    click_button 'Login'
    fill_in 'username', with: 'Bob'
    fill_in 'password', with: 'Bob1'
    click_button 'Log in'

    expect(page).to have_content "No such username"
  end
end