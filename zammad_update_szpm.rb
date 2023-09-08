require "#{__dir__}/zammad_helper.rb"

files = Dir["#{ARGV[0]}/**/*.*"].select{|f| f !~ /.*\.(md|szpm|zpm)/ }.map {|f| { location: f.sub("#{ARGV[0]}/", ''), permission: 644 } }

szpm_file = Dir["#{ARGV[0]}/*.szpm"].first

szpm = JSON.parse(File.read(szpm_file))
szpm['files'] = files

File.write(szpm_file, "#{JSON.pretty_generate(szpm)}\n")
