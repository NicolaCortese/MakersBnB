# frozen_string_literal: true

def sign_up
  visit('/')
  fill_in 'username',	with: 'Bob'
  fill_in 'password',	with: 'Bob1'
  fill_in 'name',	with: 'Bobby'
  fill_in 'email',	with: 'robertnotbobby@example.com'
  click_button 'Sign up'
end

def alternate_sign_up
  visit('/')
  fill_in 'username',	with: 'Jim'
  fill_in 'password',	with: 'Jim1'
  fill_in 'name',	with: 'Jimmy'
  fill_in 'email',	with: 'jamesnotjim@example.com'
  click_button 'Sign up'
end

# has to be logged in already and at home page to work
def create_space
  click_button 'List a Space'
  fill_in 'space_name', with: 'A Damp Cave'
  fill_in 'description', with: 'Proper nice damp cave in the middle of nowhere'
  fill_in 'price', with: 4000
  fill_in 'availability_from', with: '01/04/2022'
  fill_in 'availability_to', with: '02/04/2022'
  click_button 'List my Space'
end
