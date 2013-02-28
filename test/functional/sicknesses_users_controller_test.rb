require 'test_helper'

class SicknessesUsersControllerTest < ActionController::TestCase
  setup do
    @sicknesses_user = sicknesses_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sicknesses_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sicknesses_user" do
    assert_difference('SicknessesUser.count') do
      post :create, :sicknesses_user => @sicknesses_user.attributes
    end

    assert_redirected_to sicknesses_user_path(assigns(:sicknesses_user))
  end

  test "should show sicknesses_user" do
    get :show, :id => @sicknesses_user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sicknesses_user.to_param
    assert_response :success
  end

  test "should update sicknesses_user" do
    put :update, :id => @sicknesses_user.to_param, :sicknesses_user => @sicknesses_user.attributes
    assert_redirected_to sicknesses_user_path(assigns(:sicknesses_user))
  end

  test "should destroy sicknesses_user" do
    assert_difference('SicknessesUser.count', -1) do
      delete :destroy, :id => @sicknesses_user.to_param
    end

    assert_redirected_to sicknesses_users_path
  end
end
