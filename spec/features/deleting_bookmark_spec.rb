feature 'Deleting a bookmark' do
  scenario 'user deletes a bookmark' do
    add_2_bookmarks
    visit '/bookmarks'
    find_button('Delete', id: "Google").click
    expect(page).not_to have_link 'Google', href: "www.google.com"
    expect(page).to have_link 'Facebook', href: 'www.facebook.com'
  end
end