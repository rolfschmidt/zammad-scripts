require "#{__dir__}/zammad_helper.rb"

name = ARGV[0].split('/')[-1]
time = Time.now
path = "#{ARGV[0]}/db/addon/#{name.underscore}"
filename = "#{path}/#{time.year}#{"%02d" % time.month}#{"%02d" % time.day}#{"%02d" % time.hour}#{"%02d" % time.min}#{"%02d" % time.sec}_#{ARGV[1].underscore}.rb"

puts "create migration #{filename}"

FileUtils.mkdir_p(path)
File.write(filename, %Q[class #{ARGV[1]} < ActiveRecord::Migration[4.2]
  def self.up
  end

  def self.down
  end
end
])
