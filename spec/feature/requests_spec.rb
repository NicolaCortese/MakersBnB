# frozen_string_literal: true

feature 'Requests' do
  scenario 'Viewing requests' do
    sign_up
    click_button 'Requests'

    expect(current_path).to eq '/requests'
    expect(page).to have_content 'Requests Made'
    expect(page).to have_content 'Requests Received'
  end

  scenario 'Viewing all requests made' do
    sign_up
    create_space
    click_button 'Log out'
    alternate_sign_up
    click_button 'View Listing' # there is only one so we don't have to specify which button
    click_button 'Request to book'
    click_button 'Requests'

    expect(page).to have_content 'A Damp Cave'
    expect(page.text.index("A Damp Cave")).to be > page.text.index("Requests Made")
    expect(page.text.index("A Damp Cave")).to be < page.text.index("Requests Received")
  end

  scenario 'Viewing all requests received' do
    sign_up
    create_space
    click_button 'Log out'
    alternate_sign_up
    click_button 'View Listing' 
    click_button 'Request to book'
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bob'
    fill_in 'password', with: 'Bob1'
    click_button 'Log in'
    click_button 'Requests'

    expect(page).to have_content 'A Damp Cave'
    expect(page.text.index("A Damp Cave")).to be > page.text.index("Requests Received")
  end
end
