require 'json'
require 'base64'

File.write("#{ARGV[0]}/#{ARGV[1].gsub(/([^-])([A-Z])/, '\1_\2').downcase}.szpm", %Q[{
  "name": "#{ARGV[1]}",
  "version": "1.0.0",
  "vendor": "Example GmbH",
  "license": "GNU AFFERO GENERAL PUBLIC LICENSE",
  "url": "http://example.com/",
  "files": []
}])
