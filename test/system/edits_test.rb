require "application_system_test_case"

class EditsTest < ApplicationSystemTestCase
  setup do
    @edit = edits(:one)
  end

  test "visiting the index" do
    visit edits_url
    assert_selector "h1", text: "Edits"
  end

  test "creating a Edit" do
    visit edits_url
    click_on "New Edit"

    click_on "Create Edit"

    assert_text "Edit was successfully created"
    click_on "Back"
  end

  test "updating a Edit" do
    visit edits_url
    click_on "Edit", match: :first

    click_on "Update Edit"

    assert_text "Edit was successfully updated"
    click_on "Back"
  end

  test "destroying a Edit" do
    visit edits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Edit was successfully destroyed"
  end
end
