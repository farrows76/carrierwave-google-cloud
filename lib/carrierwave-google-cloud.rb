require 'google-cloud-storage'
require 'carrierwave'
require 'carrierwave/google/cloud/version'
require 'carrierwave/storage/google'
require 'carrierwave/storage/google_file'
require 'carrierwave/storage/google_options'
require 'carrierwave/support/uri_filename'

module CarrierWave
  module Uploader
    class Base
      ConfigurationError = Class.new(StandardError)

      add_config :google_attributes
      add_config :google_bucket
      add_config :google_bucket_public
      add_config :google_credentials
      add_config :google_request_expiration

      configure do |config|
        config.storage_engines[:google] = 'CarrierWave::Storage::Google'
      end
    end
  end
end
