module CarrierWave
  module Storage
    class GoogleOptions
      attr_reader :uploader

      def initialize(uploader)
        @uploader = uploader
      end

      def read_options
        google_read_options
      end

      def expiration_options(options = {})
        uploader_expiration = uploader.google_authenticated_url_expiration
        { expires_in: uploader_expiration }.merge(options)
      end

      private

      def google_attributes
        uploader.google_attributes || {}
      end

      def google_read_options
        uploader.google_read_options || {}
      end

      def google_write_options
        uploader.google_write_options || {}
      end
    end
  end
end
