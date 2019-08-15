feature 'Updating bookmark' do
  scenario 'user updates a bookmark' do
    add_2_bookmarks
    visit '/bookmarks'
    find_button('Update', id: 'Google').click
    fill_in('url', with: 'http://testbookmark.com')
    fill_in('title', with: 'Test Bookmark')
    click_on 'Update'
    expect(page).to have_link "Test Bookmark", href: 'http://testbookmark.com'
    expect(page).not_to have_link "Google", href: 'www.google.com'
  end
end