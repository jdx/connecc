require 'test_helper'

class PrivateBetaControllerTest < ActionController::TestCase
  test "should register for private beta" do
    assert_difference('PrivateBeta.count') do
      post :splash, :private_beta => { :email => "test@test.com" }
    end
  end

  test "should get splash" do
    get :splash
    assert_response :success
  end

end
