# Server Setup And Deployment Instructions

Add the new server to `~/.ssh/config`. Instead of `server_name`, use the correct
server name.

Create user on the server:

```bash
sudo adduser servisne_info
```

Add the user to sudoers:

```bash
sudo usermod -aG sudo servisne_info
```

Change the permissions of the user's home directory:

```bash
sudo chmod 755 /home/servisne_info
```

Add the public SSH key to `~/.ssh/authorized_keys` by executing:

```bash
ssh-copy-id servisne_info@server_name
```

Update the system:

```bash
sudo apt update && sudo apt -y full-upgrade
```

Set the locale:

```bash
sudo dpkg-reconfigure locales
```

Install dependencies (git, ruby, nginx, etc.):

```bash
sudo apt install -y cron ruby ruby-dev build-essential git nginx postgresql \
  postgresql-contrib libpq-dev nodejs htop redis-server libmagickwand-dev \
  libyaml-dev
```

Install [rbenv](https://github.com/rbenv/rbenv) and [ruby-build](https://github.com/rbenv/ruby-build).

**Note:** Configuration required for loading rbenv has to be placed in `~/.profile` instead of `~/.bashrc`:

```bash
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.profile
```

Install the required version of Ruby:

```
rbenv install 3.2.2
```

Install bundler:

```bash
sudo gem install bundler
```

Create PostgreSQL user:

```bash
sudo -u postgres createuser -s servisne_info
```

Set the PostgreSQL user password:

```bash
sudo -u postgres psql
\password servisne_info
```

Create the new database:

```bash
CREATE DATABASE servisne_info_production;
GRANT CONNECT, CREATE ON DATABASE servisne_info_production TO servisne_info;
```

Exit the PostgreSQL prompt:

```bash
\q
```

Put the database password in `servisne_info.env` (this file will be used by
systemd):

```bash
SERVISNE_INFO_DATABASE_PASSWORD="..."
```

Create a dump of the database with:

```bash
pg_dump -U servisne_info -W -F p -f servisne_info_production.sql servisne_info_production
```

To restore a database dump, execute:

```bash
scp servisne_info_production.sql server_name:~
psql -U servisne_info -d servisne_info_production -f servisne_info_production.sql
```

Copy `master.key` to the server:

```bash
mkdir -p servisne_info/shared/config
scp config/master.key server_name:servisne_info/shared/config
```

Put the new production server IP to `config/deploy/production.rb`.

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
server_name servisne.info; # Replace the existing server_name directive.

location @servisne_info_puma_production {
  proxy_pass http://servisne_info_puma_production;
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

Remove default Nginx site:

```bash
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
```

Copy the following configuration to `/etc/systemd/system/servisne_info_puma_production.service`:

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
sudo systemctl enable servisne_info_puma_production.service
```

Copy the following logrotate configuration to `/etc/logrotate.d/servisne_info`:

```
/home/servisne_info/servisne_info/shared/log/*.log {
  rotate 4
  create
  size 1M
  notifempty
  compress
  delaycompress
}
```

Deploy:

```bash
bin/cap production deploy
```

Install the SSL certificate using https://certbot.eff.org for both
`servisne.info` and `www.servisne.info`.

### Security

Disable password authentication by adding `PasswordAuthentication no` to
`/etc/ssh/sshd_config`.

Then, reload SSH daemon - `sudo systemctl reload sshd`.

Setup firewall:

```bash
sudo apt install ufw
sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
```

Restart the server.
