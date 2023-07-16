# mastodon-vagrant
set up mastodon using vagrant and ansible

Following this *excellent* guide:

https://www.linuxbabe.com/debian/install-mastodon-debian-server

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

