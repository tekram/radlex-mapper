require 'test_helper'

class ExtraneousControllerTest < ActionController::TestCase
  setup do
    @extraneou = extraneous(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:extraneous)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create extraneou" do
    assert_difference('Extraneou.count') do
      post :create, :extraneou => @extraneou.attributes
    end

    assert_redirected_to extraneou_path(assigns(:extraneou))
  end

  test "should show extraneou" do
    get :show, :id => @extraneou
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @extraneou
    assert_response :success
  end

  test "should update extraneou" do
    put :update, :id => @extraneou, :extraneou => @extraneou.attributes
    assert_redirected_to extraneou_path(assigns(:extraneou))
  end

  test "should destroy extraneou" do
    assert_difference('Extraneou.count', -1) do
      delete :destroy, :id => @extraneou
    end

    assert_redirected_to extraneous_path
  end
end
