feature 'update bookmark' do
  scenario 'user changes the title' do
    open_page_add_bookmark

    first('.bookmark').click_button 'Edit'

    expect(page).to have_content "Current title: Test Title"
    expect(page).to have_content "Current url: https://www.cloudflare.com/"

    fill_in('title', with: 'Updated Title')

    click_on 'Change Title'

    expect(page).to have_content "Current title: Updated Title"
    expect(page).not_to have_content "Test Title"
    expect(page).to have_content "Current url: https://www.cloudflare.com/"
    
    click_on 'Back to bookmarks'
    
    expect(page).not_to have_content "Test Title"
    expect(page).to have_content "Updated Title\nhttps://www.cloudflare.com/"
    expect(page).to have_link('https://www.cloudflare.com/', href: 'https://www.cloudflare.com/')
  end
end