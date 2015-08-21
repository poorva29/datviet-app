require 'rubygems'
require 'yaml'
require 'logger'
require 'kaltura'
require 'date'

class DashboardController < ApplicationController
  def index
	config_file = YAML.load_file('kaltura.yml')

	@partner_id = config_file['test']['partner_id']
	service_url = config_file['test']['service_url']
	administrator_secret = config_file['test']['administrator_secret']
	timeout = config_file['test']['timeout']

	config = Kaltura::KalturaConfiguration.new(@partner_id, service_url)
	config.logger = Logger.new(STDOUT)
	config.timeout = timeout

	@client = Kaltura::KalturaClient.new(config)
	session = @client.session_service.start(administrator_secret,
	                                        '', Kaltura::KalturaSessionType::ADMIN)
	@client.ks = session

	@media_type_video = Kaltura::KalturaMediaType::VIDEO
	@media_type_audio = Kaltura::KalturaMediaType::AUDIO

	filter = Kaltura::KalturaMediaEntryFilter.new()
	#filter.source_type_equal = Kaltura::KalturaEntryStatus::READY
	#filter.media_type_equal = Kaltura::KalturaMediaType::VIDEO

	pager = Kaltura::KalturaFilterPager.new()
	pager.page_size = 50
	pager.page_index = 1

	@list = @client.media_service.list(filter, pager);

	#entry_id = '0_o2g60jyq'

	#media_entry = @client.media_service.get(entry_id)
	#puts '*' * 80
	#puts media_entry.name

	# ks = client.session_service.start(secret, userId, type, partnerId, expiry, privileges)
	# client.ks = ks

	# entry_id = 'XXXYYYZZZA'

	# media_entry = client.media_service.get(entry_id)
	# puts media_entry.name

  end
end
