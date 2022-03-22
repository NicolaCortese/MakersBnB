feature 'owner can view their properties' do
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
end