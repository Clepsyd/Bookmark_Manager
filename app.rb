# frozen_string_literal: true

require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  set :method_override, true

  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :"bookmarks/index"
  end

  get '/bookmarks/new' do
    erb :"bookmarks/new"
  end

  post '/bookmarks' do
    Bookmark.create(params[:url], params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
