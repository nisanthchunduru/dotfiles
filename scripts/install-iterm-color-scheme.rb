#!/usr/bin/env ruby

require "net/http"
require "uri"
require "json"
require "tmpdir"

class Error < StandardError
  attr_reader :context

  def initialize(context = {})
    @context = context
    super(context.to_json)
  end
end

class MissingArgumentError < Error; end
class ColorSchemeDownloadError < Error; end
class ColorSchemeListFetchError < Error; end

BASE_URL = "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes"
API_URL = "https://api.github.com/repos/mbadolato/iTerm2-Color-Schemes/contents/schemes"

def install_all_color_schemes
  uri = URI(API_URL)
  response = Net::HTTP.get_response(uri)
  raise ColorSchemeListFetchError.new(code: response.code, url: API_URL, body: response.body) unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
    .select { |f| f["name"].end_with?(".itermcolors") }
    .map { |f| f["name"].delete_suffix(".itermcolors") }
    .each { |name| install_color_scheme(name) }
end

def install_color_scheme(name)
  puts "Installing \"#{name}\" iTerm Color Theme"
  url = "#{BASE_URL}/#{URI.encode_uri_component(name)}.itermcolors"
  uri = URI(url)
  response = Net::HTTP.get_response(uri)
  raise ColorSchemeDownloadError.new(code: response.code, url: url, body: response.body) unless response.is_a?(Net::HTTPSuccess)

  Dir.mktmpdir do |dir|
    path = File.join(dir, "#{name}.itermcolors")
    File.write(path, response.body)
    system("open", path)
    puts "✔ Installed \"#{name}\" iTerm Color Theme"
    sleep 1
  end
end

if ARGV.include?("--all")
  install_all_color_schemes
elsif ARGV.empty?
  raise MissingArgumentError, "Usage: #{$PROGRAM_NAME} <scheme-name> [scheme-name ...] | --all"
else
  ARGV.each { |name| install_color_scheme(name) }
end
