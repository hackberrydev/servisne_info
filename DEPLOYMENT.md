# Server Setup And Deployment Instructions

Add the new server to `~/.ssh/config`. Instead of `server_name`, use the correct
server name.

Create user on the server:

```bash
adduser servisne_info
```

Add the user to sudoers:

```bash
usermod -aG sudo servisne_info
```

Add the public SSH key to `~/.ssh/authorized_keys`.

Update the system:

```bash
sudo apt-get update && sudo apt-get -y upgrade
```

Install dependencies (git, ruby, nginx, passenger, etc.):

```bash
sudo apt-get install -y ruby ruby-dev build-essential git nginx postgresql \
  postgresql-contrib libpq-dev nodejs htop redis-server libmagickwand-dev
```

Install rbenv.

Install the required version of Ruby:

```
rbenv install 2.7.1
```

Install bundler:

```bash
gem install bundler
```

Create PostgreSQL user:

```bash
sudo -u postgres createuser -s servisne_info
```

Set the PostgreSQL user password:

```bash
sudo -u postgres psql
\password servisne_info
\q
```

Put the database password in `servisne_info.env` (this file will be used by
systemd):

```bash
SERVISNE_INFO_DATABASE_PASSWORD="..."
```

Copy `master.key` to the server:

```bash
mkdir -p servisne_info/shared/config
scp config/master.key server_name:servisne_info/shared/config
```

Put the new production server IP to `config/deploy/production.rb`.

Deploy, from the development machine (it will fail):

```bash
bin/cap production deploy
```

Create database (on the server):

```bash
bin/rails db:create RAILS_ENV=production
```

Configure passwordless sudo - put following line to `/etc/sudoers` with
`visudo`:

```bash
servisne_info ALL=(ALL) NOPASSWD: ALL
```

Configure Nginx and Puma:

```bash
bin/cap production puma:config
bin/cap production puma:nginx_config
```

Add the following configuration to the Nginx configuration file:

```
server_name www.servisne.info; # Replace the existing server_name directive.

location @puma_servisne_info_production {
  proxy_pass http://puma_servisne_info_production;
  proxy_set_header  Host $host;
  proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header  X-Forwarded-Proto $scheme;
  proxy_set_header  X-Forwarded-Ssl on; # Optional
  proxy_set_header  X-Forwarded-Port $server_port;
  proxy_set_header  X-Forwarded-Host $host;
  access_log /home/servisne_info/servisne_info/shared/log/nginx.access.log;
  error_log /home/servisne_info/servisne_info/shared/log/nginx.error.log;
}
```

Disable paswordless sudo!

Enable restarting Puma without a password, by adding the following line to
`/etc/sudoers`:

```bash
servisne_info ALL=(ALL) NOPASSWD: /bin/systemctl restart puma_servisne_info_production
```

Remove default Nginx site:

```bash
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
```

To restore a database dump, execute:

```bash
scp servisne_info.dump server_name:~
pg_restore --no-privileges --no-owner -d servisne_info_production servisne_info.dump
```

Deploy again:

```bash
bin/cap production deploy
```

Copy the following configuration to `/etc/systemd/system/puma_servisne_info_production.service`:

```bash
[Unit]
Description=Servisne Info Server

[Service]
Type=simple
User=servisne_info
Group=servisne_info
WorkingDirectory=/home/servisne_info/servisne_info/current
EnvironmentFile=/home/servisne_info/servisne_info.env
ExecStart=/bin/bash -lc 'bundle exec puma -C /home/servisne_info/servisne_info/shared/puma.rb'
Restart=always

[Install]
WantedBy=multi-user.target
```

Enable the service:

```bash
sudo systemctl enable puma_servisne_info_production.service
```

Copy the following logrotate configuration to /etc/logrotate.d/servisne_info:

/home/servisne_info/servisne_info/shared/log/*.log {
  daily
  rotate 7
  create
  size 10M
  compress
  delaycompress
}

Install the SSL certificate using https://certbot.eff.org.

### Security

Disable password authentication by adding `PasswordAuthentication no` to
`/etc/ssh/sshd_config`.

Then, reload SSH daemon - `sudo systemctl reload sshd`.

Setup firewall:

```bash
sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
```

Restart the server.
