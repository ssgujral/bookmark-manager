require 'pg'

feature 'Adding bookmarks' do
  scenario 'A user can add bookmarks' do
    visit ('/bookmarks/new')
    fill_in('url', with: 'http://example.org')
    click_button('Submit') 

    expect(page).to have_content "http://www.example.org"
    
  end
end