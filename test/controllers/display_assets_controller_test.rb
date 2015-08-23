require 'test_helper'

class DisplayAssetsControllerTest < ActionController::TestCase
  setup do
    @display_asset = display_assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:display_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create display_asset" do
    assert_difference('DisplayAsset.count') do
      post :create, display_asset: {  }
    end

    assert_redirected_to display_asset_path(assigns(:display_asset))
  end

  test "should show display_asset" do
    get :show, id: @display_asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @display_asset
    assert_response :success
  end

  test "should update display_asset" do
    patch :update, id: @display_asset, display_asset: {  }
    assert_redirected_to display_asset_path(assigns(:display_asset))
  end

  test "should destroy display_asset" do
    assert_difference('DisplayAsset.count', -1) do
      delete :destroy, id: @display_asset
    end

    assert_redirected_to display_assets_path
  end
end
