Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch('CONSUMER_KEY'), ENV.fetch('CONSUMER_SECRET')
  provider :facebook, ENV.fetch('FACEBOOK_KEY'), ENV.fetch('FACEBOOK_SECRET')
end