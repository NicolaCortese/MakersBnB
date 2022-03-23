feature 'Testing the /my-spaces' do
  scenario 'viewing my properties' do
    sign_up_bobby
    create_space_damp_cave
    click_button 'View my spaces'
    expect(current_path).to eq '/my-spaces'
    expect(page).to have_content "Here is a list of Bobby's spaces:"
    expect(page).to have_content "A Damp Cave"
  end

  scenario 'viewing my properties and not others' do
    sign_up_bobby
    create_space_damp_cave
    click_button 'Log out'
    sign_up_babdul
    create_space_taj
    click_button 'View my spaces'
    expect(current_path).to eq '/my-spaces'
    expect(page).to have_content "Here is a list of Babdul's spaces:"
    expect(page).to_not have_content "A Damp Cave"
    expect(page).to have_content "Taj Mahal"
  end
  
  scenario 'user can edit their space' do
    sign_up_bobby
    create_space_damp_cave
    space_1 = Space.all.first.id
    click_button 'View my spaces'
    click_button 'Edit'
    
    expect(current_path).to eq "/edit-space/#{space_1}"
    expect(page).to have_field('space_name', with: 'A Damp Cave')
    expect(page).to have_field('description', with: 'Proper nice damp cave in the middle of nowhere')
    expect(page).to have_field('price', with: 4000)
    expect(page).to have_field('availability_from', with: '01/04/2022')
    expect(page).to have_field('availability_to', with: '02/04/2022')
    
    fill_in 'space_name', with: 'A Soggy Cave'
    click_button 'Save'
    expect(current_path).to eq '/my-spaces'
    expect(page).to have_content 'Space has been successfully edited'
    expect(page).to have_content 'A Soggy Cave'
    expect(page).to_not have_content 'A Damp Cave'
    
  end
  
  scenario 'user can delete their space' do
    sign_up_bobby
    create_space_damp_cave
    space_1 = Space.all.first.id
    click_button 'View my spaces'
    click_button 'Delete'
    #prompted with a message "are you sure?"
    
    expect(current_path).to eq "/my-spaces"
    expect(page).to have_content 'Space has been successfully deleted'
    expect(page).to_not have_content 'A Damp Cave'
    
  end
end