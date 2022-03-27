require './lib/database'

class Bookmark
  include Database

  def self.find_by_id(id)
    bookmark_info = Database.find_by_id(id)
    Bookmark.new(bookmark_info[0]['id'], bookmark_info[0]['url'], bookmark_info[0]['title'])
  end

  def self.get_all
    bookmarks = Database.select_all
    bookmarks.map { |dt_hash| Bookmark.new(dt_hash['id'], dt_hash['url'], dt_hash['title'])}
  end
  
  def self.add(url, title)
    persisted_data = Database.add(url, title)
    
    Bookmark.new(persisted_data[0]['id'], persisted_data[0]['url'], persisted_data[0]['title'])
  end

  def self.delete(id)
    Database.delete(id)
  end

  def self.update_title(id:, title:)
    persisted_data = Database.update_title(id, title)
    Bookmark.new(persisted_data[0]['id'], persisted_data[0]['url'], persisted_data[0]['title'])
  end

  attr_reader :id, :title, :url

  def initialize id, url, title
    @id = id
    @url = url
    @title = title
  end
end