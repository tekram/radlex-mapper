require 'test_helper'

class ConjunctionsControllerTest < ActionController::TestCase
  setup do
    @conjunction = conjunctions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conjunctions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conjunction" do
    assert_difference('Conjunction.count') do
      post :create, :conjunction => @conjunction.attributes
    end

    assert_redirected_to conjunction_path(assigns(:conjunction))
  end

  test "should show conjunction" do
    get :show, :id => @conjunction
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @conjunction
    assert_response :success
  end

  test "should update conjunction" do
    put :update, :id => @conjunction, :conjunction => @conjunction.attributes
    assert_redirected_to conjunction_path(assigns(:conjunction))
  end

  test "should destroy conjunction" do
    assert_difference('Conjunction.count', -1) do
      delete :destroy, :id => @conjunction
    end

    assert_redirected_to conjunctions_path
  end
end
