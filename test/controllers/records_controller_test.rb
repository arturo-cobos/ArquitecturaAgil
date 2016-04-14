require 'test_helper'

class RecordsControllerTest < ActionController::TestCase
  setup do
    @record = records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create record" do
    assert_difference('Record.count') do
      post :create, record: { breathing_freq: @record.breathing_freq, collar_id: @record.collar_id, diastolic: @record.diastolic, heart_freq: @record.heart_freq, latitude: @record.latitude, longitude: @record.longitude, systolic: @record.systolic }
    end

    assert_redirected_to record_path(assigns(:record))
  end

  test "should show record" do
    get :show, id: @record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @record
    assert_response :success
  end

  test "should update record" do
    patch :update, id: @record, record: { breathing_freq: @record.breathing_freq, collar_id: @record.collar_id, diastolic: @record.diastolic, heart_freq: @record.heart_freq, latitude: @record.latitude, longitude: @record.longitude, systolic: @record.systolic }
    assert_redirected_to record_path(assigns(:record))
  end

  test "should destroy record" do
    assert_difference('Record.count', -1) do
      delete :destroy, id: @record
    end

    assert_redirected_to records_path
  end
end
