#!/usr/bin/expect -f

spawn ssh-add ~/.ssh/deploy
expect "Enter passphrase for /home/ubuntu/.ssh/deploy:"
send "\n"
interact

