require 'test_helper'

class SicknessesControllerTest < ActionController::TestCase
  setup do
    @sickness = sicknesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sicknesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sickness" do
    assert_difference('Sickness.count') do
      post :create, :sickness => @sickness.attributes
    end

    assert_redirected_to sickness_path(assigns(:sickness))
  end

  test "should show sickness" do
    get :show, :id => @sickness.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sickness.to_param
    assert_response :success
  end

  test "should update sickness" do
    put :update, :id => @sickness.to_param, :sickness => @sickness.attributes
    assert_redirected_to sickness_path(assigns(:sickness))
  end

  test "should destroy sickness" do
    assert_difference('Sickness.count', -1) do
      delete :destroy, :id => @sickness.to_param
    end

    assert_redirected_to sicknesses_path
  end
end
