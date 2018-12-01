# Rails Starter Application

[![Build Status](https://semaphoreci.com/api/v1/strika/rails-starter/branches/master/badge.svg)](https://semaphoreci.com/strika/rails-starter)

Includes:

- A simple admin interface
- Bootstrap
- Capybara
- Devise
- Kaminari
- Lograge
- RSpec

### Cloning

To start a new project, clone the repository:

```bash
git clone --depth 1 git@github.com:hackberryco/rails-starter.git <NEW_PROJECT_NAME>
```

`cd` into the new directory:

```bash
cd <NEW_PROJECT_NAME>
```

Remove the git repository:

```bash
rm -rf .git
```

Rename the application in `config/application.rb`, `config/deploy.rb` and
`config/database.yml`.

Set the application repository in `config/application.rb`.

Initialize the new git repository and you're good to go!

### Admin

To make a user admin, start the Rails console (`bin/rails console`) and execute:

```ruby
user = User.find(<USER_ID>)
user.make_admin
```

### Production setup

Create user on the server:

```bash
adduser developer
```

Add the user to sudoers:

```bash
usermod -aG sudo developer
```

Update the system:

```bash
sudo apt-get update && sudo apt-get -y upgrade
```

Install dependencies (git, ruby, nginx, passenger, etc.):

```bash
sudo apt-get install -y ruby ruby-dev build-essential git nginx postgresql \
  postgresql-contrib libpq-dev nodejs htop redis-server libmagickwand-dev
```

Install bundler:

```bash
gem install bundler
```

Create PostgreSQL user:

```bash
sudo -u postgres createuser -s developer
```

Set the PostgreSQL user password:

```bash
sudo -u postgres psql
\password developer
\q
```

Put database password in `application_name.env`:

```bash
APPLICATION_NAME_DATABASE_PASSWORD="..."
```

Load the new environment variables:

```bash
source ~/.bashrc
```

Copy `secrets.yml.key` to the server:

```bash
mkdir -p database/shared/config
scp config/secrets.yml.key server_name:database/shared/config
```

Put the new production server IP to `config/deploy/production.rb`.

Deploy, from the development machine (it will fail):

```bash
bundle exec cap production deploy
```

Create database (on the server):

```bash
bundle exec rake db:create
```

Configure passwordless sudo - put following line to `/etc/sudoers`:

```bash
developer ALL=(ALL) NOPASSWD: ALL
```

Configure Nginx and Puma:

```bash
bundle exec cap production puma:config
bundle exec cap production puma:nginx_config
```

Disable paswordless sudo!

Remove default Nginx site:

```bash
sudo rm /etc/nginx/sites-enabled/default
sudo service nginx restart
```

To restore a database dump, execute:

```bash
scp application_name.dump server_name:~
pg_restore --no-privileges --no-owner -d application_name_production application_name.dump
```

Deploy again:

```bash
bundle exec cap production deploy
```

Copy the following configuration to `/etc/systemd/system/application_name.service`:

```bash
[Unit]
Description=Application Name Server

[Service]
Type=simple
User=developer
Group=developer
WorkingDirectory=/home/developer/application_name/current
EnvironmentFile=/home/developer/application_name.env
ExecStart=/bin/bash -lc 'bundle exec puma -C /home/developer/application_name/shared/puma.rb'
Restart=always

[Install]
WantedBy=multi-user.target
```

Copy the following logrotate configuration to /etc/logrotate.d/application_name:

/home/developer/application_name/shared/log/*.log {
  daily
  rotate 7
  create
  size 10M
  compress
  delaycompress
}


### Security

Disable password authentication by adding `PasswordAuthentication no` to
`/etc/ssh/sshd_config`.

Then, reload SSH daemon - `sudo systemctl reload sshd`.

Setup firewall:

```bash
sudo ufw allow OpenSSH
sudo ufw allow https
sudo ufw enable
```
