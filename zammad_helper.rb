require 'json'
require 'base64'
require 'fileutils'
require 'net/http'
require 'uri'

VENDOR = ENV['ZAMMAD_SCRIPTS_VENDOR'] || 'Example GmbH'
LICENSE = ENV['ZAMMAD_SCRIPTS_LICENSE'] || 'MIT'
URL = ENV['ZAMMAD_SCRIPTS_URL'] || 'http://example.com/'

def check_package_base_dir!(package_base_dir)
  szpm_files = Dir.glob("#{package_base_dir}/*.szpm")

  if szpm_files.empty?
    puts "Error: No .szpm file found in #{package_base_dir}. Are you sure this is an addon directory?"
    exit 1
  end

  szpm_files.select { |szpm_file| File.symlink?(szpm_file) }.each do |szpm_file|
    puts "Error: #{szpm_file} is a symlink. This looks like a zammad directory with a linked addon, not an addon source directory. Refusing to continue to prevent recursive linking."
    exit 1
  end
end

def short_display(root_dir, package_base_dir)
  common_base = root_dir.split('/').zip(package_base_dir.split('/')).take_while { |a, b| a == b }.map(&:first).join('/')
  puts "Base: #{common_base}" unless common_base.empty?
  ->(path) { common_base.empty? ? path : path.sub(common_base, '') }
end

class String
  def szpm_name
    split = self.split('-').map(&:underscore).join('-')
  end

  def underscore
    camel_cased_word = self
    return camel_cased_word.to_s.dup unless /[A-Z-]|::/.match?(camel_cased_word)
    word = camel_cased_word.to_s.gsub("::", "/")
    word.gsub!(/(?:(?<=([A-Za-z\d]))|\b)((?=a)b)(?=\b|[^a-z])/) { "#{$1 && '_' }#{$2.downcase}" }
    word.gsub!(/(?<=[A-Z])(?=[A-Z][a-z])|(?<=[a-z\d])(?=[A-Z])/, "_")
    word.tr!("-", "_")
    word.downcase!
    word
  end
end
