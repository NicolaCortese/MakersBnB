feature 'Booking' do
  scenario 'lets us book a space' do
    sign_up_bobby
    create_space_damp_cave
    click_button 'View Listing' #there is only one so we don't have to specify which button  
    click_button 'Request to book'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Booking successfull'
  end
end