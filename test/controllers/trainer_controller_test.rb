require 'test_helper'

class TrainerControllerTest < ActionDispatch::IntegrationTest
  test "should get review" do
    get trainer_review_url
    assert_response :success
  end

end
