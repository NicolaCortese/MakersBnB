
feature 'Checking the homepage' do
  scenario 'holds the welcome' do
    visit('/')
    expect(page).to have_content "Welcome to MakersBnB"
  end
end