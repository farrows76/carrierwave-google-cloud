module CarrierWave
  module Storage
    class Google < Abstract
      def self.connection_cache
        @connection_cache ||= {}
      end

      def self.clear_connection_cache!
        @connection_cache = {}
      end

      def store!(file)
        CarrierWave::Storage::GoogleFile.new(uploader, connection, uploader.store_path).tap do |google_file|
          google_file.store(file)
        end
      end

      def retrieve!(identifier)
        CarrierWave::Storage::GoogleFile.new(uploader, connection, uploader.store_path(identifier)).retrieve
      end

      def connection
        @connection ||= begin
          cert_path = Gem.loaded_specs['google-api-client'].full_gem_path + '/lib/cacerts.pem'
          ENV['SSL_CERT_FILE'] = cert_path
          self.class.connection_cache[credentials] ||=
            ::Google::Cloud.new(
              credentials[:google_project] ||
              ENV['GOOGLE_PROJECT'], credentials[:google_keyfile] ||
              ENV['GOOGLE_KEYFILE']
            ).storage
        end
      end

      def credentials
        uploader.google_credentials
      end
    end
  end
end
