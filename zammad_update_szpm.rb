require "#{__dir__}/zammad_helper.rb"

if ARGV[0].to_s.empty?
  puts "Usage:"
  puts "\truby #{File.expand_path(__FILE__)} /workspace/Example-Addon"
  puts ""
  exit
end

files = Dir["#{ARGV[0]}/**/*.*"].select{|f| f !~ /.*\.(md|szpm|zpm)/ }.map {|f| { location: f.sub("#{ARGV[0]}/", ''), permission: 644 } }

szpm_file = Dir["#{ARGV[0]}/*.szpm"].first

szpm = JSON.parse(File.read(szpm_file))
szpm['files'] = files

puts "Updated file list in szpm file #{szpm_file}"

File.write(szpm_file, "#{JSON.pretty_generate(szpm)}\n")
