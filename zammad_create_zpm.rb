require 'json'
require 'base64'

szpm_file = Dir["#{ARGV[0]}/*.szpm"].first

szpm = JSON.parse(File.read(szpm_file))
szpm['version'] = ARGV[1]
szpm['files'] = szpm['files'].map do |file|
  file['location'] = Base64.encode64(File.read("#{ARGV[0]}/#{file['location']}")).strip
  file
end

zpm_file = szpm_file.split('.')
zpm_file[-2] += "-#{ARGV[1]}"
zpm_file[-1] = 'zpm'

File.write(zpm_file.join('.'), "#{JSON.pretty_generate(szpm)}\n")
