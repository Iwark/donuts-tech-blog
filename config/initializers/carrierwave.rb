CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id:  Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region: 'ap-northeast-1'
  }

  if Rails.env.production? || Rails.env.staging?
    config.fog_directory = 'techblog'
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  else
    config.fog_directory = 'techblog-dev'
  end

end