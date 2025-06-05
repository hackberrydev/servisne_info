# Project Information for Generative AI

This is a Ruby on Rails application.

## Deployment

The application is deployed on a Debian server. It uses Nginx and Puma. Systemd
is used to handle the Puma service.

More information about deployment settings can be found in ./DEPLOYMENT.md.

## Code Style

Follow the code style proposed by the Standard Ruby project.

## Development

Use `dip` for all Rails related commands. For example, instead of `bin/rails
spec` or `bundle exec rails spec`, use `dip rails spec`. Instead of `rspec`
or `bin/rspec`, use `dip rspec`.
