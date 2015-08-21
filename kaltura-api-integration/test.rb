require 'rubygems'
#require 'test/unit'
#require 'shoulda'
require 'yaml'
require 'logger'

require 'kaltura'

config_file = YAML.load_file('kaltura.yml')

partner_id = config_file['test']['partner_id']
service_url = config_file['test']['service_url']
administrator_secret = config_file['test']['administrator_secret']
timeout = config_file['test']['timeout']

config = Kaltura::KalturaConfiguration.new(partner_id, service_url)
config.logger = Logger.new(STDOUT)
config.timeout = timeout

@client = Kaltura::KalturaClient.new(config)
session = @client.session_service.start(administrator_secret,
                                        '', Kaltura::KalturaSessionType::ADMIN)
@client.ks = session

entry_id = '0_o2g60jyq'

media_entry = @client.media_service.get(entry_id)

@user_service = Kaltura::KalturaUserService.new(@client)
@user = @user_service.get_by_login_id('poorva.mahajan@vertisinfotech.com')
@users = @user_service.list

puts '*' * 80 + '(Kaltura Media Entry...)'
puts media_entry.inspect

puts '#' * 100 + '(User...)'
puts @user.inspect

puts '&' * 90 + '(User List...)'
puts @users.inspect
# ks = client.session_service.start(secret, userId, type, partnerId, expiry, privileges)
# client.ks = ks

# entry_id = 'XXXYYYZZZA'

# media_entry = client.media_service.get(entry_id)
# puts media_entry.name
