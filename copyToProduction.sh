#!/usr/bin/expect

set productionUser "user1"
set productionPassword "555"
set productionAddress "10.10.0.1"

spawn ssh -l $productionUser $productionAddress

set timeout 10
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

    "$ " {
        send "mkdir folder\r"
    }
}

set timeout 60