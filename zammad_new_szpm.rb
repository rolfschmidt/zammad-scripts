require "#{__dir__}/zammad_helper.rb"

name = ARGV[0].split('/')[-1]
filename = "#{ARGV[0]}/#{name.szpm_name}.szpm"

puts "create new szpm #{filename}..."

vendor = ENV['ZAMMAD_SCRIPTS_VENDOR'] || 'Example GmbH'
license = ENV['ZAMMAD_SCRIPTS_LICENSE'] || 'GNU AFFERO GENERAL PUBLIC LICENSE'
url = ENV['ZAMMAD_SCRIPTS_URL'] || 'http://example.com/'

File.write(filename, %Q[{
  "name": "#{name}",
  "version": "1.0.0",
  "vendor": "#{vendor}",
  "license": "#{license}",
  "url": "#{url}",
  "files": []
}])
