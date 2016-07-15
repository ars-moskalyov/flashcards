CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV["aws_access_key_id"],
    aws_secret_access_key: ENV["aws_secret_access_key"],
    region: ENV["aws_region"]
  }

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = true
    config.root = "#{Rails.root}/spec/support/uploads"
  else
    config.storage = :fog
  end
  
  #config.cache_dir = "#{Rails.root}/tmp/uploads"       # To let CarrierWave work on heroku
  config.fog_directory = ENV["aws_bucket"]
end
