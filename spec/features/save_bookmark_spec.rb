feature 'saving bookmark' do
  scenario 'the name appears on the list' do
    open_page_add_bookmark
    expect(page).to have_content "Test Title\nhttps://www.cloudflare.com/"
    expect(page).to have_link('https://www.cloudflare.com/', href: 'https://www.cloudflare.com/')
  end

  scenario 'the title column appears within the table' do
    open_page_add_bookmark
    expect(page).to have_content 'Test Title'
  end
end