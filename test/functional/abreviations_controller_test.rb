require 'test_helper'

class AbreviationsControllerTest < ActionController::TestCase
  setup do
    @abreviation = abreviations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abreviations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abreviation" do
    assert_difference('Abreviation.count') do
      post :create, :abreviation => @abreviation.attributes
    end

    assert_redirected_to abreviation_path(assigns(:abreviation))
  end

  test "should show abreviation" do
    get :show, :id => @abreviation
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @abreviation
    assert_response :success
  end

  test "should update abreviation" do
    put :update, :id => @abreviation, :abreviation => @abreviation.attributes
    assert_redirected_to abreviation_path(assigns(:abreviation))
  end

  test "should destroy abreviation" do
    assert_difference('Abreviation.count', -1) do
      delete :destroy, :id => @abreviation
    end

    assert_redirected_to abreviations_path
  end
end
