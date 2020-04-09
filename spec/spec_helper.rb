require 'coveralls'
Coveralls.wear!
require 'dotenv'
Dotenv.load
require 'pry'
require 'vcr'
require 'workflows'

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr"
  config.hook_into :webmock
  config.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
  config.default_cassette_options = { serialize_with: :yaml, record: :once, allow_playback_repeats: true, decode_compressed_response: true}

  config.filter_sensitive_data('<AUTH DATA>') { |interaction|
    auths = interaction.request.headers['Authorization'].first
    if (match = auths.match /^Basic\s+([^,\s]+)/ )
      match.captures.first
    end
  }
end

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation

end
