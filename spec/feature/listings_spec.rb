# frozen_string_literal: true
feature 'create listing' do
  

  scenario 'User can create a listing' do
    sign_up_bobby
    click_button 'List a Space'
    fill_in 'space_name', with: 'A Damp Cave'
    fill_in 'description', with: 'Proper nice damp cave in the middle of nowhere'
    fill_in 'price', with: 4000
    fill_in 'availability_from', with: '01/04/2022'
    fill_in 'availability_to', with: '02/04/2022'
    click_button 'List my Space'
    expect(page).to have_content 'A Damp Cave'
    expect(page).to have_content '£4000'
  end


  scenario 'cannot create listing where end date is before start date' do
    sign_up_bobby
    click_button 'List a Space'
    fill_in 'space_name', with: 'A Damp Cave'
    fill_in 'description', with: 'Proper nice damp cave in the middle of nowhere'
    fill_in 'price', with: 4000
    fill_in 'availability_from', with: '03/04/2022'
    fill_in 'availability_to', with: '02/04/2022'
    click_button 'List my Space'
    expect(current_path).to eq '/new-space'
    expect(page).to have_content 'Your end date cannot be before your start date. Please try again.'
  end

  scenario 'cannot create listing when fields are not completed' do 
    sign_up_bobby
    click_button 'List a Space'
    fill_in 'availability_from', with: '03/04/2022'
    fill_in 'availability_to', with: '02/04/2022'
    click_button 'List my Space'
    expect(current_path).to eq '/new-space'
    expect(page).to have_content "Please complete all fields to list your space"
  end
end



feature 'view listings' do
  scenario 'user can see all listings on home page' do
    sign_up_bobby
    create_space_damp_cave
    expect(page).to have_content 'Bob'
    expect(page).to have_content 'A Damp Cave'
    expect(page).to have_content '£4000'
    expect(current_path).to eq '/'
  end

  scenario 'can view individual space listing page' do #image test to be added in future
    sign_up_bobby
    create_space_damp_cave 
    space_1 = Space.all.first.id
    click_button 'View Listing'
    expect(current_path).to eq "/listing/#{space_1}"
    expect(page).to have_content 'A Damp Cave'
    expect(page).to have_content 'Proper nice damp cave in the middle of nowhere'
    expect(page).to have_content '£4000'
    expect(page).to have_button 'Request to book'
  end
end

feature 'it has a button that takes you to listing page' do
  scenario 'clicking a button takes you to the right page' do
    sign_up_bobby
    expect(page).to have_button 'List a Space'
    click_button 'List a Space'
    expect(page).to have_content 'List a Space'
  end
end
