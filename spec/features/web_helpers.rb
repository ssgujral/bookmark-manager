def open_page_add_bookmark
  visit '/bookmarks'
  fill_in('page_address', with: 'https://www.cloudflare.com/')
  fill_in('title', with: 'Test Title')
  click_on "Add bookmark"
end