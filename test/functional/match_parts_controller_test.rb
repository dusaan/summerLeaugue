require 'test_helper'

class MatchPartsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:match_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create match_part" do
    assert_difference('MatchPart.count') do
      post :create, :match_part => { }
    end

    assert_redirected_to match_part_path(assigns(:match_part))
  end

  test "should show match_part" do
    get :show, :id => match_parts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => match_parts(:one).to_param
    assert_response :success
  end

  test "should update match_part" do
    put :update, :id => match_parts(:one).to_param, :match_part => { }
    assert_redirected_to match_part_path(assigns(:match_part))
  end

  test "should destroy match_part" do
    assert_difference('MatchPart.count', -1) do
      delete :destroy, :id => match_parts(:one).to_param
    end

    assert_redirected_to match_parts_path
  end
end
