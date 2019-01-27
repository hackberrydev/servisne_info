if Rails.env.production?
  Raven.configure do |config|
    config.dsn = Rails.application.secrets.sentry_dsn!
  end
end
