
def sign_up
visit('/')
    fill_in 'username',	with: 'Bob'
    fill_in 'password',	with: 'Bob1'
    fill_in 'name',	with: 'Bobby'
    fill_in 'email',	with: 'robertnotbobby@example.com'
    click_button 'Sign up'
end