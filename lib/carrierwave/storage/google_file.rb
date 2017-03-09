module CarrierWave
  module Storage
    class GoogleFile
      attr_writer :file
      attr_accessor :uploader, :connection, :path, :google_options, :file_exists

      delegate :content_type, :size, to: :file

      def initialize(uploader, connection, path)
        @uploader = uploader
        @connection = connection
        @path = path
      end

      def file
        by_verifying_existence { @file ||= bucket.file(path) }
        @file
      end

      alias to_file file

      def retrieve
        by_verifying_existence { @file ||= bucket.file(path) }
        self
      end

      def by_verifying_existence(&block)
        self.file_exists = true
        yield
      rescue Exception => exception
        if (exception.class == ::Google::Cloud::Error::NotFoundError) && (exception.message == 'Not Found')
          self.file_exists = false
        end
      end

      def attributes
        return unless file_exists
        {
          content_type: file.content_type,
          size: file.size,
          updated_at: file.updated_at.to_s,
          etag: file.etag
        }
      end

      def delete
        deleted = file.delete
        self.file_exists = false if deleted
        deleted
      end

      def exists?
        self.file_exists
      end

      def extension
        elements = path.split('.')
        elements.last if elements.size > 1
      end

      def filename(options = {})
        CarrierWave::Support::UriFilename.filename(file.url)
      end

      def read
        tmp_file = Tempfile.new(CarrierWave::Support::UriFilename.filename(file.name))
        (file.download tmp_file.path, verify: :all).read
      end

      def store(new_file)
        new_file_path = uploader.filename ? uploader.filename : new_file.filename
        bucket.create_file new_file.path, "#{uploader.store_dir}/#{new_file_path}"
        self
      end

      def copy_to(new_path)
        file.copy("#{uploader.store_dir}/#{new_path}")
      end

      def url(options = {})
        return unless file_exists
        uploader.google_bucket_is_public ? public_url : authenticated_url
      end

      def authenticated_url
        file.signed_url
      end

      def public_url
        uploader.asset_host ? "#{uploader.asset_host}/#{path}" : file.public_url.to_s
      end

      private

      def bucket
        bucket ||= connection.bucket(uploader.google_bucket)
      end
    end
  end
end
