CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV["aws_access_key_id"],
    aws_secret_access_key: ENV["aws_secret_access_key"],
    region: ENV["aws_region"]
  }

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory = ENV["aws_bucket"]
end
