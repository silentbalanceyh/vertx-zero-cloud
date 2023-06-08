#!/usr/bin/env bash
brew remove mysql
brew cleanup

# sudo rm /usr/local/mysql
sudo rm -rf /usr/local/var/mysql
sudo rm -rf /usr/local/mysql*
# sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/MySql*

# launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /private/var/db/receipts/*mysql*

# my.cnf
sudo rm /usr/local/etc/my.cnf