if Rails.env.production?
  Raven.configure do |config|
    config.dsn = Rails.application.credentials.sentry_dsn
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  end
end
