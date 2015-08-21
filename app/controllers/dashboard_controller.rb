
class DashboardController < ApplicationController
	before_action :setup_session_with_kaltura

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

  private
  # Use callbacks to share common setup or constraints between actions.
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

end
