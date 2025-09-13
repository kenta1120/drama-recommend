require "test_helper"

class DramasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dramas_index_url
    assert_response :success
  end

  test "should get show" do
    get dramas_show_url
    assert_response :success
  end

  test "should get new" do
    get dramas_new_url
    assert_response :success
  end

  test "should get create" do
    get dramas_create_url
    assert_response :success
  end

  test "should get edit" do
    get dramas_edit_url
    assert_response :success
  end

  test "should get update" do
    get dramas_update_url
    assert_response :success
  end

  test "should get destroy" do
    get dramas_destroy_url
    assert_response :success
  end
end
