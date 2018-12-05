require 'test_helper'

class SubcriptorsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subcriptors_new_url
    assert_response :success
  end

  test "should get create" do
    get subcriptors_create_url
    assert_response :success
  end

end
