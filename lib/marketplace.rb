require_relative "./marketplace/version"
require_relative "./article"
require_relative "./scraper"
require_relative "./cli"

require "pry"
require "open-uri"
require "nokogiri"
#require "net_http_ssl_fix" #necessary only for Windows because of https problem in Ruby
require "colorize"

#require_relative "./marketplace/cli"
