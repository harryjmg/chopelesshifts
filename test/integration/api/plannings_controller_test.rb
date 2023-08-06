require 'test_helper'

class PlanningsControllerTest < ActionDispatch::IntegrationTest
    test 'GET /api/v1/plannings' do
        user = users(:one)
        api_token = user.api_tokens.create!
        get '/api/v1/plannings', headers: { 'Authorization' => "Bearer #{api_token.token}" }
        
        assert_response :success
    end

    test 'GET /api/v1/plannings?type=weekly' do
        user = users(:one)
        api_token = user.api_tokens.create!
        get '/api/v1/plannings?type=weekly', headers: { 'Authorization' => "Bearer #{api_token.token}" }

        assert_response :success
        assert_equal 1, response.parsed_body.count
    end

    test 'GET /api/v1/plannings?type=donotexist' do
        user = users(:one)
        api_token = user.api_tokens.create!
        get '/api/v1/plannings?type=donotexist', headers: { 'Authorization' => "Bearer #{api_token.token}" }

        assert_response :unprocessable_entity
    end

    test 'GET /api/v1/plannings?donotexist=weekly' do
        user = users(:one)
        api_token = user.api_tokens.create!
        get '/api/v1/plannings?donotexist=weekly', headers: { 'Authorization' => "Bearer #{api_token.token}" }

        assert_response :unprocessable_entity
    end
    
    test "when auth token is inactive" do
        user = users(:one)
        api_token = user.api_tokens.create!
        api_token.update!(active: false)
        get api_v1_plannings_path, headers: { 'Authorization' => "Bearer #{api_token.token}" }
        
        assert_response :unauthorized
        assert_includes response.body, "Bad credentials"
    end

    test "GET /api/v1/plannings/shifts" do
        user = users(:one)
        api_token = user.api_tokens.create!
        planning = plannings(:one)
        get "/api/v1/plannings/#{planning.id}/shifts", headers: { 'Authorization' => "Bearer #{api_token.token}" }
        
        assert_response :success
    end

    test "GET /api/v1/plannings/:planning_id/reservations" do
        user = users(:one)
        api_token = user.api_tokens.create!
        planning = plannings(:one)
        get "/api/v1/plannings/#{planning.id}/reservations", headers: { 'Authorization' => "Bearer #{api_token.token}" }
        
        assert_response :success
    end
end