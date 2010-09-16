require 'test_helper'

class NewzsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newzs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newz" do
    assert_difference('Newz.count') do
      post :create, :newz => { }
    end

    assert_redirected_to newz_path(assigns(:newz))
  end

  test "should show newz" do
    get :show, :id => newzs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => newzs(:one).to_param
    assert_response :success
  end

  test "should update newz" do
    put :update, :id => newzs(:one).to_param, :newz => { }
    assert_redirected_to newz_path(assigns(:newz))
  end

  test "should destroy newz" do
    assert_difference('Newz.count', -1) do
      delete :destroy, :id => newzs(:one).to_param
    end

    assert_redirected_to newzs_path
  end
end
