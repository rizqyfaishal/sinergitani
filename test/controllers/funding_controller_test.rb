require 'test_helper'

class FundingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get funding_index_url
    assert_response :success
  end

  test "should get create" do
    get funding_create_url
    assert_response :success
  end

  test "should get store" do
    get funding_store_url
    assert_response :success
  end

  test "should get edit" do
    get funding_edit_url
    assert_response :success
  end

  test "should get update" do
    get funding_update_url
    assert_response :success
  end

  test "should get delete" do
    get funding_delete_url
    assert_response :success
  end

end
