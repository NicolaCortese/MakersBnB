# frozen_string_literal: true

feature 'Requests' do
  scenario 'Viewing requests' do
    sign_up_bobby
    click_button 'Requests'

    expect(current_path).to eq '/requests'
    expect(page).to have_content 'Requests Made'
    expect(page).to have_content 'Requests Received'
  end

  scenario 'Viewing all requests made' do
    sign_up_bobby
    create_space_damp_cave
    click_button 'Log out'
    sign_up_babdul
    click_button 'View Listing' # there is only one so we don't have to specify which button
    click_button 'Request to book'
    click_button 'Requests'

    expect(page).to have_content 'A Damp Cave'
    expect(page).to have_content '01/04/2022'
    expect(page.text.index("A Damp Cave")).to be > page.text.index("Requests Made")
    expect(page.text.index("A Damp Cave")).to be < page.text.index("Requests Received")
  end

  scenario 'Viewing all requests received' do
    sign_up_bobby
    create_space_damp_cave
    click_button 'Log out'
    sign_up_babdul
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
    expect(page).to have_content 'Bab requested to book'
  end

  scenario 'Viewing the status of my request as pending' do
    sign_up_bobby
    create_space_damp_cave
    click_button 'Log out'
    sign_up_babdul
    click_button 'View Listing' 
    click_button 'Request to book'
    click_button 'Requests'

    expect(page).to have_content 'A Damp Cave'
    expect(page).to have_content 'Status Pending'
  end

  scenario "Able to accept requests to book my property" do
    sign_up_bobby
    create_space_damp_cave
    click_button 'Log out'
    sign_up_babdul
    click_button 'View Listing' 
    click_button 'Request to book'
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bob'
    fill_in 'password', with: 'Bob1'
    click_button 'Log in'
    click_button 'Requests'
    
    expect(page).to have_button 'Accept'
    
    click_button 'Accept'
    visit('/') #this has to be changed when navigation tools are implemented
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bab'
    fill_in 'password', with: 'Bab1'
    click_button 'Log in'
    click_button 'Requests'
    expect(page).to have_content 'Status Approved'

  end

  scenario "Able to accept requests to book my property" do
    sign_up_bobby
    create_space_damp_cave
    click_button 'Log out'
    sign_up_babdul
    click_button 'View Listing' 
    click_button 'Request to book'
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bob'
    fill_in 'password', with: 'Bob1'
    click_button 'Log in'
    click_button 'Requests'
    
    expect(page).to have_button 'Decline'
    
    click_button 'Decline'
    visit('/') #this has to be changed when navigation tools are implemented
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bab'
    fill_in 'password', with: 'Bab1'
    click_button 'Log in'
    click_button 'Requests'
    expect(page).to have_content 'Status Denied'

  end

  scenario "Able to accept only one request for a specific date" do
    sign_up_bobby
    create_space_damp_cave
    click_button 'Log out'
    sign_up_babdul
    click_button 'View Listing' 
    click_button 'Request to book'
    click_button 'View Listing' 
    click_button 'Request to book'
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bob'
    fill_in 'password', with: 'Bob1'
    click_button 'Log in'
    click_button 'Requests'
    
    first('.request').click_button 'Accept'
    expect(page).to_not have_button 'Accept'
    expect(page).to_not have_button 'Decline'

  end

  scenario "Can only see the available dates in the dropdown" do
    sign_up_bobby
    create_space_damp_cave
    click_button 'Log out'
    sign_up_babdul
    click_button 'View Listing' 
    select '2022-04-01', from: 'booked_from'
    click_button 'Request to book'
    click_button 'View Listing' 
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bob'
    fill_in 'password', with: 'Bob1'
    click_button 'Log in'
    click_button 'Requests'
    click_button 'Accept'
    visit '/'
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bab'
    fill_in 'password', with: 'Bab1'
    click_button 'Log in'
    click_button 'View Listing'

    expect(page).to have_select('booked_from', :options => ['2022-04-02'])
  end

  scenario "Multiple date bookings" do
    sign_up_bobby
    create_space_taj
    click_button 'Log out'
    sign_up_babdul
    click_button 'View Listing' 
    select '2022-04-05', from: 'booked_from'
    select '2022-04-08', from: 'booked_to'
    click_button 'Request to book'
    click_button 'View Listing' 
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bob'
    fill_in 'password', with: 'Bob1'
    click_button 'Log in'
    click_button 'Requests'
    click_button 'Accept'
    visit '/'
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bab'
    fill_in 'password', with: 'Bab1'
    click_button 'Log in'
    click_button 'View Listing'

    expect(page).to have_select('booked_from', :options => ['2022-04-04'])
  end

  scenario "Multiple date bookings" do
    sign_up_bobby
    create_space_taj
    click_button 'Log out'
    sign_up_babdul
    click_button 'View Listing' 
    select '2022-04-05', from: 'booked_from'
    select '2022-04-07', from: 'booked_to'
    click_button 'Request to book'
    click_button 'View Listing' 
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bob'
    fill_in 'password', with: 'Bob1'
    click_button 'Log in'
    click_button 'Requests'
    click_button 'Accept'
    visit '/'
    click_button 'Log out'
    click_button 'Login'
    fill_in 'username', with: 'Bab'
    fill_in 'password', with: 'Bab1'
    click_button 'Log in'
    click_button 'View Listing'
    select '2022-04-04', from: 'booked_from'
    select '2022-04-08', from: 'booked_to'
    click_button 'Request to book'

    expect(page).to have_content('This space is not available on those dates')
  end

end
