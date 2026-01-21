require "#{__dir__}/zammad_helper.rb"

if ARGV[0].to_s.empty? || ARGV[1].to_s.empty?
  puts "Usage:"
  puts "\truby #{File.expand_path(__FILE__)} /workspace/Example-Addon 1.0.0"
  puts ""
  exit
end

szpm_file = Dir["#{ARGV[0]}/*.szpm"].first

szpm = JSON.parse(File.read(szpm_file))
szpm['version'] = ARGV[1]
szpm['files'] = szpm['files'].map do |file|
  file['encode'] = 'base64'
  file['content'] = Base64.strict_encode64(File.read("#{ARGV[0]}/#{file['location']}"))
  file
end

zpm_file = szpm_file.split('.')
zpm_file[-2] += "-#{ARGV[1]}"
zpm_file[-1] = 'zpm'
zpm_file = zpm_file.join('.')

puts "create zpm #{zpm_file}"

File.write(zpm_file, "#{JSON.pretty_generate(szpm)}\n")
