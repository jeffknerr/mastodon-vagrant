# mastodon-vagrant
set up mastodon server example using vagrant and ansible

Following this *excellent* guide:

https://www.linuxbabe.com/debian/install-mastodon-debian-server

## quickstart

NOTE: all of the below was done on an ubuntu 22.04 computer with 32GB
of memory (July 2023). Also, as mentioned in the guide above, the vm
needs 3GB of memory to be able to compile the CSS/JS assets.

- install ansible and vagrant
- set up ansible "hosts" file
- clone this repo
- use `vagrant up` to start vm
- use `ansible-playbook msrv.yml` to run playbook/config the vm

```
$ alias vg='vagrant'
$ export ANSIBLE_NOCOWS=1
$ sudo apt-add-repository -y ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install gnupg software-properties-common 
$ sudo apt-get install ansible vagrant git virtualbox
$ sudo vim /etc/ansible/hosts
$ cat /etc/ansible/hosts
[msrv]
192.168.56.30
[msrv:vars]
ansible_user=vagrant
ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key
$ git clone https://github.com/jeffknerr/mastodon-vagrant.git
$ cd mastodon-vagrant
# this next one takes a few minutes...
$ vg up
$ vg status
# accept the ssh host keys
$ ssh -i ~/.vagrant.d/insecure_private_key vagrant@192.168.56.30
$ ansible msrv -a date
$ ansible-playbook msrv.yml
# just to check stuff
$ vg ssh msrv
# see if the app works (log in as admin user with password pass.123)
# point browser to
# https://192.168.56.30
# and accept the security risk of using a self-signed cert
```

When finished, you can use `vg halt` to stop the virtual machine,
and `vg destroy` to remove it completely (useful if you want to
start over).

## todo

- how to run the config commands via a playbook...
- how to set up the db via a playbook
- how to set up the admin user

```
/home/mastodon/mastodon$ sudo -u mastodon RAILS_ENV=production bundle exec rake mastodon:setup
RAILS_ENV=production rails db:setup
RAILS_ENV=production rails assets:precompile 
```

## postgres commands

Here's what the db should look like (mastodon user can Create DB):

```
$ vg ssh msrv
Last login: ....
vagrant@social:~$ sudo -u postgres -i psql
psql (13.11 (Debian 13.11-0+deb11u1))
Type "help" for help.

postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+-----------------------
 mastodon  | mastodon | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =Tc/mastodon         +
           |          |          |             |             | mastodon=CTc/mastodon
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
(4 rows)

postgres=# \c mastodon
You are now connected to database "mastodon" as user "postgres".
mastodon=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 mastodon  | Create DB                                                  | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}

mastodon=# \dt
Did not find any relations.
mastodon=#
```

The above is *before* I've run the rails bundle commands to set 
up the DB. That's why `\dt` doesn't show anything.

