require 'test_helper'

class SafeZonesControllerTest < ActionController::TestCase
  setup do
    @safe_zone = safe_zones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:safe_zones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create safe_zone" do
    assert_difference('SafeZone.count') do
      post :create, safe_zone: { latitude: @safe_zone.latitude, longitude: @safe_zone.longitude, pet_id: @safe_zone.pet_id, radium: @safe_zone.radium }
    end

    assert_redirected_to safe_zone_path(assigns(:safe_zone))
  end

  test "should show safe_zone" do
    get :show, id: @safe_zone
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @safe_zone
    assert_response :success
  end

  test "should update safe_zone" do
    patch :update, id: @safe_zone, safe_zone: { latitude: @safe_zone.latitude, longitude: @safe_zone.longitude, pet_id: @safe_zone.pet_id, radium: @safe_zone.radium }
    assert_redirected_to safe_zone_path(assigns(:safe_zone))
  end

  test "should destroy safe_zone" do
    assert_difference('SafeZone.count', -1) do
      delete :destroy, id: @safe_zone
    end

    assert_redirected_to safe_zones_path
  end
end
