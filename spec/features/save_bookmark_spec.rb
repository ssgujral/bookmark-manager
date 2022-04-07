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

  scenario 'The bookmark must be a valid URL' do

    visit('/bookmarks')
    #fill_in('title', with: "unreal title")
    fill_in('page_address', with: 'not a real bookmark')
    click_button('Add bookmark')
  

    save_and_open_page
    expect(page).not_to have_content "not a real bookmark"
  
    expect(page).to have_content "You must submit a valid URL."
  
  end


end