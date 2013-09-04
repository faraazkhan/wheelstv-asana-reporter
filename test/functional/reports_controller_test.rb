require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get get_data" do
    get :get_data
    assert_response :success
  end

  test "should get create_report" do
    get :create_report
    assert_response :success
  end

end
