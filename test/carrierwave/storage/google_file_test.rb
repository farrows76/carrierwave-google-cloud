require 'test_helper'
require 'minitest/mock'

class CarrierWave::Storage::GoogleFile::Test < ActiveSupport::TestCase
  setup do
    mock = MiniTest::Mock.new
    path = 'files/1/file.txt'
    file = mock.expect(:file, content_type: 'content/type', path: '/file/path')
    bucket = mock.expect(:bucket, object: file)
    connection = mock.expect(:connection, bucket: bucket)

    uploader = CarrierWave::Uploader::Base.new
    @google_file = CarrierWave::Storage::GoogleFile.new(uploader, connection, path)
  end

  test "should return the internal file instance from alias" do
    file = Object.new
    @google_file.file = file
    assert_equal @google_file.to_file, file
  end

  test "should return the retrieved file" do
    file = Object.new
    assert_equal @google_file.retrieve.file, file
  end

  test "should return the file extension" do
    @google_file.path = 'file.txt'
    assert_equal @google_file.extension, 'txt'
  end

  test "should return nil for file extension" do
    @google_file.path = 'file'
    assert_nil @google_file.extension
  end
end