feature 'viewing bookmarks' do
  scenario 'visiting the index page' do
    visit '/'
    expect(page).to have_content 'bookmark manager'
  end
end

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    # Test data
    Bookmark.add('http://www.makersacademy.com/', 'Makers Academy')
    Bookmark.add('http://www.destroyallsoftware.com/', 'Destroy All Software')
    Bookmark.add('http://www.google.com/', 'Google')

    visit('/bookmarks')

    expect(page).to have_content 'Makers Academy'
    expect(page).to have_link("http://www.makersacademy.com/", href: "http://www.makersacademy.com/")
    expect(page).to have_content 'Destroy All Software'
    expect(page).to have_link("http://www.destroyallsoftware.com/", href: "http://www.destroyallsoftware.com/")
    expect(page).to have_content 'Google'
    expect(page).to have_link("http://www.google.com/", href: "http://www.google.com/")
  end
end