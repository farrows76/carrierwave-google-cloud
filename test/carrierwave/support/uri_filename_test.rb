require 'test_helper'

class CarrierWave::Support::UriFilename::Test < ActiveSupport::TestCase
  test "should extract a decoded filename from file uri" do
    samples = {
      'uploads/file.txt' => 'file.txt',
      'uploads/files/samples/file%201.txt?foo=bar/baz.txt' => 'file 1.txt',
    }
    samples.each do |uri, name|
      assert_equal CarrierWave::Support::UriFilename.filename(uri), name
    end
  end
end