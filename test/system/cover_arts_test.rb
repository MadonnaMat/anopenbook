require "application_system_test_case"

class CoverArtsTest < ApplicationSystemTestCase
  setup do
    @cover_art = cover_arts(:one)
  end

  test "visiting the index" do
    visit cover_arts_url
    assert_selector "h1", text: "Cover Arts"
  end

  test "creating a Cover art" do
    visit cover_arts_url
    click_on "New Cover Art"

    click_on "Create Cover art"

    assert_text "Cover art was successfully created"
    click_on "Back"
  end

  test "updating a Cover art" do
    visit cover_arts_url
    click_on "Edit", match: :first

    click_on "Update Cover art"

    assert_text "Cover art was successfully updated"
    click_on "Back"
  end

  test "destroying a Cover art" do
    visit cover_arts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cover art was successfully destroyed"
  end
end
