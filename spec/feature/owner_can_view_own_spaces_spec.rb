feature 'owner can view their properties' do
  scenario 'viewing my properties' do
    sign_up
    create_space
    click_button 'View my spaces'
    expect(current_path).to eq '/my-spaces'
    expect(page).to have_content "Here is a list of Bobby's spaces:"
    expect(page).to have_content "A Damp Cave"
  end
end