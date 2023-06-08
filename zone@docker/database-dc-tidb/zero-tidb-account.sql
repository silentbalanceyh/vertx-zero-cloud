create user 'zero'@'%' identified by 'xxxxxxxx';
GRANT ALL PRIVILEGES ON mysql.* TO 'zero'@'%';
FLUSH PRIVILEGES;