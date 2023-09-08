require "#{__dir__}/zammad_helper.rb"

name = ARGV[0].split('/')[-1]

File.write("#{ARGV[0]}/#{name.szpm_name}.szpm", %Q[{
  "name": "#{name}",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": []
}])
