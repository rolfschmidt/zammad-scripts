require 'json'
require 'base64'
require 'fileutils'
require 'net/http'
require 'uri'

VENDOR = ENV['ZAMMAD_SCRIPTS_VENDOR'] || 'Example GmbH'
LICENSE = ENV['ZAMMAD_SCRIPTS_LICENSE'] || 'MIT'
URL = ENV['ZAMMAD_SCRIPTS_URL'] || 'http://example.com/'

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
