CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'your_access_key',
    aws_secret_access_key: 'your_secret_key',
    region:                'your_region'
  }
  config.fog_directory  = 'your_bucket_name'
end
