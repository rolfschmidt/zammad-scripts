require 'json'
require 'base64'

name = ARGV[0].split('/')[-1]

File.write("#{ARGV[0]}/#{name.gsub(/([^-])([A-Z])/, '\1_\2').downcase}.szpm", %Q[{
  "name": "#{name}",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": []
}])
