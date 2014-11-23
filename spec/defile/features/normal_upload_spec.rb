require "defile/test_app"

feature "Normal HTTP Post file uploads" do
  scenario "Successfully upload a file" do
    visit "/normal/posts/new"
    fill_in "Title", with: "A cool post"
    attach_file "Document", path("hello.txt")
    click_button "Create"

    expect(page).to have_selector("h1", text: "A cool post")
    click_link("Document")
    expect(page.source.chomp).to eq("hello")
  end

  scenario "Upload a file via form redisplay" do
    visit "/normal/posts/new"
    attach_file "Document", path("hello.txt")
    click_button "Create"
    fill_in "Title", with: "A cool post"
    click_button "Create"

    expect(page).to have_selector("h1", text: "A cool post")
    click_link("Document")
    expect(page.source.chomp).to eq("hello")
  end
end
