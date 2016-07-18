CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: ENV["FOG_PROVIDER"],
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: ENV["FOG_REGION"]
  }

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = true
    config.root = "#{Rails.root}/spec/support/uploads"
  else
    config.storage = :fog
  end
  
  #config.cache_dir = "#{Rails.root}/tmp/uploads"       # To let CarrierWave work on heroku
  config.fog_directory = ENV["FOG_DIRECTORY"]
end
