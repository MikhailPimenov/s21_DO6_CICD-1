#!/usr/bin/expect

spawn scp src/cat/s21_cat user1@10.10.0.1:s21_cat
expect "Are you sure you want to continue connecting (yes/no/\[fingerprint\])?"
send "yes\r"
expect "user1@10.10.0.1's password:"
send "555\r"

spawn scp src/grep/s21_grep user1@10.10.0.1:s21_grep
expect "user1@10.10.0.1's password:"
send "555\r"

spawn ssh -t user1@10.10.0.1 "sh -c 'sudo mv s21_cat /usr/local/bin/' && sh -c 'sudo mv s21_grep /usr/local/bin/'"
expect "Are you sure you want to continue connecting (yes/no/\[fingerprint\])?"
send "yes\r"
expect "user1@10.10.0.1's password:"
send "555\r"
expect "password for user1:"
send "555\r"
