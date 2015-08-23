json.array!(@display_assets) do |display_asset|
  json.extract! display_asset, :id
  json.url display_asset_url(display_asset, format: :json)
end
