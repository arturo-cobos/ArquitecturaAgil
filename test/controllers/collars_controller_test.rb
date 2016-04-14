require 'test_helper'

class CollarsControllerTest < ActionController::TestCase
  setup do
    @collar = collars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create collar" do
    assert_difference('Collar.count') do
      post :create, collar: { description: @collar.description, pet_id: @collar.pet_id, reference: @collar.reference }
    end

    assert_redirected_to collar_path(assigns(:collar))
  end

  test "should show collar" do
    get :show, id: @collar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @collar
    assert_response :success
  end

  test "should update collar" do
    patch :update, id: @collar, collar: { description: @collar.description, pet_id: @collar.pet_id, reference: @collar.reference }
    assert_redirected_to collar_path(assigns(:collar))
  end

  test "should destroy collar" do
    assert_difference('Collar.count', -1) do
      delete :destroy, id: @collar
    end

    assert_redirected_to collars_path
  end
end
