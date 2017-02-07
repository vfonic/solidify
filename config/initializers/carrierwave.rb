CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.development?
    config.fog_provider = 'fog/aws'

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      region: ENV.fetch('AWS_S3_REGION')
    }

    config.fog_directory = ENV.fetch('AWS_S3_BUCKET_NAME')
    config.fog_authenticated_url_expiration = 120
    # config.fog_public     = true
    # optional, defaults to {}
    # config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
    config.storage = :fog
  else
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
    config.storage = :file
    config.enable_processing = false if Rails.env.test? || Rails.env.cucumber?
  end
end
