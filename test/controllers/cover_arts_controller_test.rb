require 'test_helper'

class CoverArtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cover_art = cover_arts(:one)
  end

  test "should get index" do
    get cover_arts_url
    assert_response :success
  end

  test "should get new" do
    get new_cover_art_url
    assert_response :success
  end

  test "should create cover_art" do
    assert_difference('CoverArt.count') do
      post cover_arts_url, params: { cover_art: {  } }
    end

    assert_redirected_to cover_art_url(CoverArt.last)
  end

  test "should show cover_art" do
    get cover_art_url(@cover_art)
    assert_response :success
  end

  test "should get edit" do
    get edit_cover_art_url(@cover_art)
    assert_response :success
  end

  test "should update cover_art" do
    patch cover_art_url(@cover_art), params: { cover_art: {  } }
    assert_redirected_to cover_art_url(@cover_art)
  end

  test "should destroy cover_art" do
    assert_difference('CoverArt.count', -1) do
      delete cover_art_url(@cover_art)
    end

    assert_redirected_to cover_arts_url
  end
end
