require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'
require 'pg'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload './lib/bookmark'
    also_reload './lib/database'
  end

  enable :sessions, :method_override

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

  post '/bookmarks/add' do
    Bookmark.add(params[:page_address], params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect 'bookmarks'
  end
  
  patch '/bookmarks/:id' do
    Bookmark.update_title(id: params['id'], title: params['title'])
    redirect "/bookmarks/#{params['id']}/edit"
  end

  run! if app_file == $0
end