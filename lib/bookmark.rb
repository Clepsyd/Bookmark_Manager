# frozen_string_literal: true

require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    connection = select_db
    result = connection.exec('SELECT * FROM bookmarks;')
    bookmarks = []
    result.each do |bookmark|
      bookmarks << Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])
    end
    bookmarks
  end

  def self.create(url, title)
    connection = select_db
    result = connection.exec(
      "INSERT INTO bookmarks (title, url)
      VALUES('#{title}', '#{url}')
      RETURNING id, url, title"
    )
    # Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
    result
  end

  def self.delete(id)
    connection = select_db
    connection.exec("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id, title, url)
    connection = select_db
    connection.exec(
      "UPDATE bookmarks
      SET title = '#{title}', url = '#{url}'
      WHERE id = #{id}"
    )
  end

  def self.find(id)
    connection = select_db
    result = connection.exec("SELECT * FROM bookmarks WHERE id = #{id}").first
    return Bookmark.new(result['id'], result['title'], result['url'])
  end

  private

  def self.select_db
    env_is_test? ? connect('bookmark_manager_test') : connect('bookmark_manager')
  end

  def self.connect(db)
    PG.connect(dbname: db)
  end

  def self.env_is_test? 
    ENV['ENVIRONMENT'] == 'test'
  end
end
