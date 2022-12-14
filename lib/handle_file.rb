# frozen_string_literal: true

require_relative 'helpers'
require_relative 'config'
require 'net/http'

module SpecRefLib
  # Displays the keyword/method provided
  class HandleFile
    def initialize
      @default_file = nil
      fetch_default_file
    end

    def fetch_default_file
      uri = URI.parse(SpecRefLib::Config.default_url)
      @default_file = Net::HTTP.get_response(uri)
    rescue StandardError
      @default_file = nil
    end

    def fetch_json
      JSON.parse(File.read(ENV.fetch(SpecRefLib::Config.env)))
    rescue StandardError
      if @default_file.nil?
        SpecRefLib::Helpers.log 'Invalid file'
        SpecRefLib::Helpers.leave
      else
        JSON.parse(@default_file.body)
      end
    end
  end
end
