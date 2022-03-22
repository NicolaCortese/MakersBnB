feature 'Booking' do
  scenario 'lets us book a listing' do
    sign_up
    @user = User.all.first
    Listing.create(
      name: "Bob's house", 
      description: "you really don't want to stay here",
      price: 2.50
      user_id: @user.id
      )
    click_button 'View Listing' #there is only one so we don't have to specify which button  
    click_button 'Book'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Booking Successful'
  end
end