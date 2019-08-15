# frozen_string_literal: true

require 'pg'
require 'bookmark'

feature 'Viewing bookmarks' do
  scenario 'visiting the homepage' do
    visit('/')
    expect(page).to have_content 'Bookmark Manager'
  end

  scenario 'view bookmarks list' do
    Bookmark.create('http://www.google.com', 'Google')
    Bookmark.create('http://www.lwlies.com', 'Little White Lies')
    Bookmark.create('http://www.ocado.com', 'Ocado')

    visit '/bookmarks'

    expect(page).to have_link 'Google', href: 'http://www.google.com'
    expect(page).to have_link 'Little White Lies', href: 'http://www.lwlies.com'
    expect(page).to have_link 'Ocado', href: 'http://www.ocado.com'
  end
end
