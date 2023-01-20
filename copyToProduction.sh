#!/usr/bin/expect

set productionUser "user1"
set productionPassword "555"
set productionAddress "10.10.0.1"

set timeout 10

spawn ssh -l $productionUser $productionAddress
expect "yes/no" {send "yes\r"}
expect "password:" {send "$productionPassword\r"}
sleep 5
expect "$ " {send "mkdir folder\r"}
set timeout 60