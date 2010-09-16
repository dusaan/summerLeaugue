require 'test_helper'

class SportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport" do
    assert_difference('Sport.count') do
      post :create, :sport => { }
    end

    assert_redirected_to sport_path(assigns(:sport))
  end

  test "should show sport" do
    get :show, :id => sports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sports(:one).to_param
    assert_response :success
  end

  test "should update sport" do
    put :update, :id => sports(:one).to_param, :sport => { }
    assert_redirected_to sport_path(assigns(:sport))
  end

  test "should destroy sport" do
    assert_difference('Sport.count', -1) do
      delete :destroy, :id => sports(:one).to_param
    end

    assert_redirected_to sports_path
  end
end
