SKIPALL=true cap production deploy
ssh root@letsthryve.com "rm /var/www/letsthryve/current/db/production.sqlite3; cp /var/www/letsthryve/shared/production.sqlite3 /var/www/letsthryve/current/db/"
SKIPALL=true cap production puma:restart
