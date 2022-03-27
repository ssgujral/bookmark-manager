feature 'delete bookmark' do
  scenario 'bookmark disappears from the list' do
    open_page_add_bookmark
    expect(page).to have_content "Test Title\nhttps://www.cloudflare.com/"
    
    expect(page).to have_link('https://www.cloudflare.com/', href: 'https://www.cloudflare.com/')
    
    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'

    expect(page).not_to have_content "Test Title\nhttps://www.cloudflare.com/"

    expect(page).not_to have_link('https://www.cloudflare.com/', href: 'https://www.cloudflare.com/')

  end
end