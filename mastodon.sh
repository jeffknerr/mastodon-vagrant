#! /bin/bash -x

# do some manual mastodon install stuff that
# is hard to do in ansible (ie, I don't know how to
# do it in ansible...)


REPO=/home/mastodon/mastodon
INP=/home/mastodon/setup.txt
OUTP=/home/mastodon/output.txt

echo "running mastodon install stuff..."

cd /home/mastodon/mastodon
sudo -u mastodon bundle config deployment 'true'
sudo -u mastodon bundle config without 'development test'
sudo -u mastodon bundle install -j1

# run setup wizard, send output (password) to file
sudo -u mastodon RAILS_ENV=production bundle exec rake mastodon:setup < $INP > $OUTP 2>&1

systemctl restart nginx.service
touch /home/mastodon/scriptalreadyran
