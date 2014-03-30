require 'test_helper'

class CriminalsControllerTest < ActionController::TestCase
  setup do
    @criminal = criminals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:criminals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create criminal" do
    assert_difference('Criminal.count') do
      post :create, criminal: {  }
    end

    assert_redirected_to criminal_path(assigns(:criminal))
  end

  test "should show criminal" do
    get :show, id: @criminal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @criminal
    assert_response :success
  end

  test "should update criminal" do
    patch :update, id: @criminal, criminal: {  }
    assert_redirected_to criminal_path(assigns(:criminal))
  end

  test "should destroy criminal" do
    assert_difference('Criminal.count', -1) do
      delete :destroy, id: @criminal
    end

    assert_redirected_to criminals_path
  end
end
