#!/bin/sh
# The seeded user scanner1 logs in (the site redirects to the user's home), so the database
# was imported and the site reaches it.
curl -s -o /dev/null -D - -d 'username=scanner1' -d 'password=scanner1' http://web/users/login.php \
  | grep -qi '^location:'
