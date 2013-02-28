require 'test_helper'

class DocumentationsControllerTest < ActionController::TestCase
  setup do
    @documentation = documentations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documentations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create documentation" do
    assert_difference('Documentation.count') do
      post :create, documentation: @documentation.attributes
    end

    assert_redirected_to documentation_path(assigns(:documentation))
  end

  test "should show documentation" do
    get :show, id: @documentation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @documentation.to_param
    assert_response :success
  end

  test "should update documentation" do
    put :update, id: @documentation.to_param, documentation: @documentation.attributes
    assert_redirected_to documentation_path(assigns(:documentation))
  end

  test "should destroy documentation" do
    assert_difference('Documentation.count', -1) do
      delete :destroy, id: @documentation.to_param
    end

    assert_redirected_to documentations_path
  end
end
