require "#{__dir__}/zammad_helper.rb"

if ARGV[0].to_s.empty? || ARGV[1].to_s.empty?
  puts "Usage:"
  puts "\truby #{File.expand_path(__FILE__)} /workspace/zammad /workspace/Example-Addon"
  puts ""
  exit
end

root_dir         = ARGV[0]
package_base_dir = ARGV[1]
Dir.glob("#{package_base_dir}/**/*") do |entry|
  entry = entry.sub('//', '/')
  file = entry
  file = file.sub(%r{#{package_base_dir}}, '')
  dest = "#{root_dir}/#{file}"

  if File.symlink?(dest.to_s)
    puts "Unlink file: #{dest}"
    File.delete(dest.to_s)
  end

  backup_file = "#{dest}.link_backup"
  if File.exist?(backup_file)
    puts "Restore backup file of #{backup_file} -> #{dest}."
    File.rename(backup_file, dest.to_s)
  end
end
