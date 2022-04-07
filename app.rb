require 'sinatra/base'
require 'sinatra/flash'
#require 'sinatra/reloader'
require './lib/bookmark'
require './database_connection_setup'
require 'pg'
require 'uri'



class BookmarkManager < Sinatra::Base
  #configure :development do
    

    enable :sessions, :method_override

    #register Sinatra::Reloader
    register Sinatra::Flash
    #also_reload './lib/bookmark'
    #also_reload './lib/database'
  #end

  
  

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.get_all
    erb :'bookmarks/index'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find_by_id(params['id'])
    erb :'bookmarks/edit'
  end

 

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect 'bookmarks'
  end
  
  patch '/bookmarks/:id' do
    Bookmark.update_title(id: params['id'], title: params['title'])
    redirect "/bookmarks/#{params['id']}/edit"
  end

  post '/bookmarks' do
    if params['page_address'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.add(params[:page_address], params[:title])

#page_address: params['page_address'], title: params[:title]

      p "Bookmark added"
    else
      p "Bookmark rejected, invalid URL"
      flash[:notice] = "You must submit a valid URL."
    end

    redirect('/bookmarks')
  end

  post '/bookmarks/add' do
    p "Bookmark added"


    if params['page_address'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmark.add(params[:page_address], params[:title])
      p "Bookmark added"
    else
      p "Bookmark rejected, invalid URL"
      flash[:notice] = "You must submit a valid URL."

    #Bookmark.add(params[:page_address], params[:title])
    #redirect '/bookmarks'
    end
    
    redirect('/bookmarks')
  end

  run! if app_file == $0
end