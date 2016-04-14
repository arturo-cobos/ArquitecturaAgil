require 'test_helper'

class PetStatusesControllerTest < ActionController::TestCase
  setup do
    @pet_status = pet_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pet_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pet_status" do
    assert_difference('PetStatus.count') do
      post :create, pet_status: { description: @pet_status.description, name: @pet_status.name }
    end

    assert_redirected_to pet_status_path(assigns(:pet_status))
  end

  test "should show pet_status" do
    get :show, id: @pet_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pet_status
    assert_response :success
  end

  test "should update pet_status" do
    patch :update, id: @pet_status, pet_status: { description: @pet_status.description, name: @pet_status.name }
    assert_redirected_to pet_status_path(assigns(:pet_status))
  end

  test "should destroy pet_status" do
    assert_difference('PetStatus.count', -1) do
      delete :destroy, id: @pet_status
    end

    assert_redirected_to pet_statuses_path
  end
end
