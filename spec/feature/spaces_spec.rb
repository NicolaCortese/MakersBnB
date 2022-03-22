feature 'it has a button that takes you to listing page' do
  scenario 'clickig a button takes you to the right page' do
    sign_up
    expect(page).to(have_button('List a Space'))
    click_button('List a Space')
    expect(page).to(have_contect('List a Space'))
  end
end

