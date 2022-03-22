
def sign_up_bobby
visit('/')
    fill_in 'username',	with: 'Bob'
    fill_in 'password',	with: 'Bob1'
    fill_in 'name',	with: 'Bobby'
    fill_in 'email',	with: 'robertnotbobby@example.com'
    click_button 'Sign up'
end

def sign_up_babdul
visit('/')
    fill_in 'username',	with: 'Bab'
    fill_in 'password',	with: 'Bab1'
    fill_in 'name',	with: 'Babdul'
    fill_in 'email',	with: 'babbydully@example.com'
    click_button 'Sign up'
end

def create_space_damp_cave #has to be logged in already and at home page to work
    click_button 'List a Space'
    fill_in 'space_name', with: 'A Damp Cave'
    fill_in 'description', with: 'Proper nice damp cave in the middle of nowhere'
    fill_in 'price', with: 4000
    fill_in 'availability_from', with: '01/04/2022'
    fill_in 'availability_to', with: '02/04/2022'
    click_button 'List my Space'
end

def create_space_taj #has to be logged in already and at home page to work
    click_button 'List a Space'
    fill_in 'space_name', with: 'Taj Mahal'
    fill_in 'description', with: 'the chairs are imported from Holland'
    fill_in 'price', with: 1000
    fill_in 'availability_from', with: '04/04/2022'
    fill_in 'availability_to', with: '08/04/2022'
    click_button 'List my Space'
end