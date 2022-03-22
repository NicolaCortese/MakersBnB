
def sign_up
visit('/')
    fill_in 'username',	with: 'Bob'
    fill_in 'password',	with: 'Bob1'
    fill_in 'name',	with: 'Bobby'
    fill_in 'email',	with: 'robertnotbobby@example.com'
    click_button 'Sign up'
end

def create_space #has to be logged in already and at home page to work
    click_button 'List a Space'
    fill_in 'Name', with: 'A Damp Cave'
    fill_in 'Discription', with: 'Proper nice damp cave in the middle of nowhere'
    fill_in 'Price per night', with: 4000
    fill_in 'Available from', with: 01/04/2022
    fill_in 'Available to', with: 02/04/2022
    click_button 'List my space'
end