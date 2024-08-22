if Rails.env.production?
  Sentry.init do |config|
    config.dsn = Rails.application.credentials.sentry_dsn
    config.send_default_pii = false
  end
end
