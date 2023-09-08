require "#{__dir__}/zammad_helper.rb"

name = ARGV[0].split('/')[-1]
filename = name.szpm_name

puts "create zzpm #{filename}..."

File.write("#{ARGV[0]}/#{filename}.szpm", %Q[{
  "name": "#{name}",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": []
}])
