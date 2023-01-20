#!/usr/bin/expect

spawn ssh user1@10.10.0.1
expect "user1@10.10.0.1's password:"
send "555"
spawn mkdir from_runner_folder
interact