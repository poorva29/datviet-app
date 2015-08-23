class DisplayAssetsController < ApplicationController
  before_action :set_display_asset, only: [:show, :edit, :update, :destroy]
  before_action :setup_session_with_kaltura

  # GET /display_assets
  # GET /display_assets.json
  def index
    @media_type_video = Kaltura::KalturaMediaType::VIDEO
    @media_type_audio = Kaltura::KalturaMediaType::AUDIO
    filter = Kaltura::KalturaMediaEntryFilter.new()
    #filter.source_type_equal = Kaltura::KalturaEntryStatus::READY
    #filter.media_type_equal = Kaltura::KalturaMediaType::VIDEO
    pager = Kaltura::KalturaFilterPager.new()
    pager.page_size = 50
    pager.page_index = 1

    @list = @client.media_service.list(filter, pager);
  end

  # GET /display_assets/1
  # GET /display_assets/1.json
  def show
  end

  # GET /display_assets/new
  def new
    @display_asset = DisplayAsset.new
  end

  # GET /display_assets/1/edit
  def edit
  end

  # POST /display_assets
  # POST /display_assets.json
  def create
    @display_asset = DisplayAsset.new(display_asset_params)

    respond_to do |format|
      if @display_asset.save
        format.html { redirect_to @display_asset, notice: 'Display asset was successfully created.' }
        format.json { render action: 'show', status: :created, location: @display_asset }
      else
        format.html { render action: 'new' }
        format.json { render json: @display_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /display_assets/1
  # PATCH/PUT /display_assets/1.json
  def update
    respond_to do |format|
      if @display_asset.update(display_asset_params)
        format.html { redirect_to @display_asset, notice: 'Display asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @display_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /display_assets/1
  # DELETE /display_assets/1.json
  def destroy
    @display_asset.destroy
    respond_to do |format|
      format.html { redirect_to display_assets_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_display_asset
    @display_asset = DisplayAsset.find(params[:id])
  end

  def setup_session_with_kaltura
    return if @client && @client.ks
    config_file = YAML.load_file('kaltura.yml')
    @partner_id = config_file['test']['partner_id']
    service_url = config_file['test']['service_url']
    administrator_secret = config_file['test']['administrator_secret']
    timeout = config_file['test']['timeout']
    config = Kaltura::KalturaConfiguration.new(@partner_id, service_url)
    config.logger = Logger.new(STDOUT)
    config.timeout = timeout

    @client = Kaltura::KalturaClient.new(config)
    ks = @client.session_service.start(administrator_secret,
                                       '', Kaltura::KalturaSessionType::ADMIN)
    @client.ks = ks
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def display_asset_params
    params[:display_asset]
  end
end
