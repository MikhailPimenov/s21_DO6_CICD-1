#!/usr/bin/expect

set productionUser "user1"
set productionPassword "555"
set productionAddress "10.10.0.1"

set prompt "user1@production:~$ "

spawn ssh -l $productionUser $productionAddress

set timeout 20
expect {
    timeout {
        puts "Connection timed out"
        exit 1
    }

    "yes/no" {
        send "yes\r"
        exp_continue
    }

    "assword:" {
        send "$productionPassword\r"
        exp_continue
    }

    "$prompt" {
        send "mkdir folder\r"
        expect eof 
        exit 0 
    }
}

set timeout 60