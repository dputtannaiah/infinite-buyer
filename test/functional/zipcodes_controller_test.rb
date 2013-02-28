require 'test_helper'

class ZipcodesControllerTest < ActionController::TestCase
  setup do
    @zipcode = zipcodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:zipcodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zipcode" do
    assert_difference('Zipcode.count') do
      post :create, :zipcode => @zipcode.attributes
    end

    assert_redirected_to zipcode_path(assigns(:zipcode))
  end

  test "should show zipcode" do
    get :show, :id => @zipcode.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @zipcode.to_param
    assert_response :success
  end

  test "should update zipcode" do
    put :update, :id => @zipcode.to_param, :zipcode => @zipcode.attributes
    assert_redirected_to zipcode_path(assigns(:zipcode))
  end

  test "should destroy zipcode" do
    assert_difference('Zipcode.count', -1) do
      delete :destroy, :id => @zipcode.to_param
    end

    assert_redirected_to zipcodes_path
  end
end
