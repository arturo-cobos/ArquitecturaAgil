require 'test_helper'

class VitalsignHistoriesControllerTest < ActionController::TestCase
  setup do
    @vitalsign_history = vitalsign_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vitalsign_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vitalsign_history" do
    assert_difference('VitalsignHistory.count') do
      post :create, vitalsign_history: { breathing_freq: @vitalsign_history.breathing_freq, diastolic: @vitalsign_history.diastolic, heart_freq: @vitalsign_history.heart_freq, pet_id: @vitalsign_history.pet_id, record_date: @vitalsign_history.record_date, systolic: @vitalsign_history.systolic }
    end

    assert_redirected_to vitalsign_history_path(assigns(:vitalsign_history))
  end

  test "should show vitalsign_history" do
    get :show, id: @vitalsign_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vitalsign_history
    assert_response :success
  end

  test "should update vitalsign_history" do
    patch :update, id: @vitalsign_history, vitalsign_history: { breathing_freq: @vitalsign_history.breathing_freq, diastolic: @vitalsign_history.diastolic, heart_freq: @vitalsign_history.heart_freq, pet_id: @vitalsign_history.pet_id, record_date: @vitalsign_history.record_date, systolic: @vitalsign_history.systolic }
    assert_redirected_to vitalsign_history_path(assigns(:vitalsign_history))
  end

  test "should destroy vitalsign_history" do
    assert_difference('VitalsignHistory.count', -1) do
      delete :destroy, id: @vitalsign_history
    end

    assert_redirected_to vitalsign_histories_path
  end
end
