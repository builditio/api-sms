# config/initializers/carrierwave.rb

CarrierWave.configure do |config|

  config.aws_credentials = {

    access_key_id:     'AKIAJOATM5XDGNO7YRBA',
    secret_access_key: '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',
    region:            'us-west-2'
  }
  config.storage  = :aws
  config.aws_bucket = 'builditsms'
  config.aws_acl = "public-read"
  config.asset_host = "https://builditsms.s3-us-west-2.amazonaws.com"

end
