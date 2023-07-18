#! /bin/bash

# do some manual mastodon install stuff that
# is hard to do in ansible (ie, I don't know how to
# do it in ansible...)


REPO=/home/mastodon/mastodon

echo "running mastodon install stuff..."

cd /home/mastodon/mastodon
sudo -u mastodon bundle config deployment 'true'
sudo -u mastodon bundle config without 'development test'
sudo -u mastodon bundle install -j1

# run setup wizard
sudo -u mastodon RAILS_ENV=production bundle exec rake mastodon:setup < setup.txt

systemctl restart nginx.service
touch /home/mastodon/scriptalreadyran
