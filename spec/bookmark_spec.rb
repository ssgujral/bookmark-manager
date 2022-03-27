require 'bookmark'
require 'database_helpers'

describe Bookmark do
  
  let(:url) { 'http://www.youtube.com/' }
  let(:title) { 'Test Title' }
  
  describe '.get_all' do
    it 'returns all bookmarks' do
      bookmark = Bookmark.add("http://www.makersacademy.com/", 'Makers Academy')
      Bookmark.add("http://www.destroyallsoftware.com/", 'Destroy all software')
      Bookmark.add("http://www.google.com/", 'google')
      
      bookmarks = Bookmark.get_all
      
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy' 
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com/'
    end
  end

  describe '.add' do
    it 'adds a bookmark to the database' do
      # we setup the .add method to return value from the database
      # we get: {"id"=>"some_id", "url"=>"http://www.youtube.com/", "'Test Title'"} 
      bookmark = Bookmark.add(url, title)
      persisted_data = persisted_data(bookmark.id)
      # expect(Bookmark.get_all).to include({title: title, url: url})
      # to check if the return value from inserting into the database is the same as insterted value
      # expect(bookmark.id).to eq persisted_data('id')
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Test Title'
      expect(bookmark.url).to eq 'http://www.youtube.com/'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      # we check if the bookmark was correctly added to the database
      
      bookmark = Bookmark.add(url, title)
      persisted_data = persisted_data(bookmark.id)

      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq title
      expect(bookmark.url).to eq url

      # we check if the bookmark is deleted

      deleted_bookmark = Bookmark.delete(bookmark.id)
      persisted_data_for_delete = persisted_data(deleted_bookmark[0]['id'])

      expect(persisted_data_for_delete).to eq nil
      expect(Bookmark.get_all).not_to include bookmark
      expect(Bookmark.get_all.length).to eq 0 

      expect(deleted_bookmark[0]['id']).to eq bookmark.id
      expect(bookmark.title).to eq title
      expect(bookmark.url).to eq url
    end
  end

  describe '.update_title' do
    it 'updates the title' do
      # check if the bookmark is correctly added
      bookmark = Bookmark.add(url, title)
      persisted_data = persisted_data(bookmark.id)
  
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq title
      expect(bookmark.url).to eq url
  
      # check if title is updated
      updated_bookmark = Bookmark.update_title(id: bookmark.id, title: 'Newest Title')
      persisted_data_from_update = persisted_data(bookmark.id)
  
      expect(bookmark.id).to eq persisted_data_from_update['id']
      expect(updated_bookmark.id).to eq persisted_data_from_update['id']
      expect(updated_bookmark.title).to eq 'Newest Title'
      expect(updated_bookmark.url).to eq url
    end
  end

  describe '.find_by_id' do
    it 'finds a book' do
      bookmark = Bookmark.add(url, title)
      persisted_data = persisted_data(bookmark.id)

      expect(Bookmark.find_by_id(bookmark.id)).to be_a Bookmark
      expect(Bookmark.find_by_id(bookmark.id)).to have_attributes(id: bookmark.id, url: url, title: title)
    end
  end
end