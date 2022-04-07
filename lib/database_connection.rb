require 'pg'



module Database

  def self.find_by_id(id)
    Database.connect.exec_params("SELECT * FROM bookmarks WHERE id = $1", [id])
  end

  def self.select_all
    Database.connect.exec_params"SELECT * FROM bookmarks;"
  end

  def self.add(url, title)
    Database.connect.exec_params("INSERT INTO bookmarks (url, title) VALUES ($1, $2) RETURNING id, url, title;", [url, title])
  end

  def self.delete(id)
    Database.connect.exec_params("DELETE FROM bookmarks WHERE id = $1 RETURNING id, url, title;", [id])
  end

  def self.update_title(id, title)
    Database.connect.exec_params("UPDATE bookmarks SET title = $1 WHERE id = $2 RETURNING id, url, title;", [title, id])
  end
  
   def self.connect
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end  


  end
end



class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end

end