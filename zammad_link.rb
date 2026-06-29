# Copyright (C) 2012-2026 Zammad Foundation, https://zammad-foundation.org/

require "#{__dir__}/zammad_helper.rb"

if ARGV[0].to_s.empty? || ARGV[1].to_s.empty?
  puts 'Usage:'
  puts "\truby #{File.expand_path(__FILE__)} /workspace/zammad /workspace/Example-Addon"
  puts ''
  exit
end

root_dir         = ARGV[0]
package_base_dir = ARGV[1]

if Dir.glob("#{package_base_dir}/*.szpm").empty?
  puts "Error: No .szpm file found in #{package_base_dir}. Are you sure this is an addon directory?"
  exit 1
end

display = short_display(root_dir, package_base_dir)

Dir.glob("#{package_base_dir}/**/*") do |entry|
  entry = entry.sub('//', '/')
  file = entry
  file = file.sub(%r{#{package_base_dir}}, '')
  file = file.sub(%r{^/}, '')

  next if file.start_with?('README')
  next if file.end_with?('.zpm')

  dest = "#{root_dir}/#{file}"
  if File.directory?(entry.to_s) && !File.exist?(dest.to_s)
    puts "Create dir: #{display.call(dest)}"
    FileUtils.mkdir_p(dest.to_s)
  end

  if File.file?(entry.to_s) && File.file?(dest.to_s) && !File.symlink?(dest.to_s)
    backup_file = "#{dest}.link_backup"
    if File.exist?(backup_file)
      raise "Can't link #{entry} -> #{dest}, destination and .link_backup already exists!"
    end

    puts "Create backup file of #{display.call(dest)} -> #{display.call(backup_file)}."
    File.rename(dest.to_s, backup_file)
  end

  if File.file?(entry)
    if File.symlink?(dest.to_s)
      File.delete(dest.to_s)
    end
    puts "Link file: #{display.call(entry)} -> #{display.call(dest)}"
    File.symlink(entry.to_s, dest.to_s)
  end
end
