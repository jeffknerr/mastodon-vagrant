#! /bin/bash

# do some manual mastodon install stuff that
# is hard to do in ansible (ie, I don't know how to
# do it in ansible...)


REPO=/home/mastodon/mastodon

echo "running mastodon install stuff..."

systemctl restart nginx.service
touch /home/mastodon/scriptalreadyran
