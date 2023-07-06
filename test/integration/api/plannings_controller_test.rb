require 'test_helper'

class PlanningsControllerTest < ActionDispatch::IntegrationTest
    test "when auth token is valid" do
        user = users(:one)
        api_token = user.api_tokens.create!
        get api_v1_plannings_path, headers: { 'Authorization' => "Bearer #{api_token.token}" }
        assert_response :success
    end
    
    test "when auth token is inactive" do
        user = users(:one)
        api_token = user.api_tokens.create!
        api_token.update!(active: false)
        get api_v1_plannings_path, headers: { 'Authorization' => "Bearer #{api_token.token}" }
        assert_response :unauthorized
        assert_includes response.body, "Bad credentials"
    end
end