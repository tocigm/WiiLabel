require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get items_index_url
    assert_response :success
    # assert_equal "",  @response.body
  end

  # test "should create a new Claim" do
  #   post claims_create_url, params: { claim: {claimant_id: 1, claim_expert_id: 1}}
  #   assert_response :success
  # end
end
