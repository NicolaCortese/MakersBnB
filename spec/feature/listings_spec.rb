feature 'view listings' do
  
  scenario 'user can see all listings on home page' do
    sign_up_bobby
    create_space_damp_cave
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