#!/usr/bin/expect

set productionUser "user1"
set productionPassword "555"
set productionAddress "10.10.0.1"

set lastWordsFromPreviousOutput "from 10.10.0.2"

spawn ssh -l $productionUser $productionAddress

set timeout 60

expect {
    timeout {
        puts "Connection timed out"
        exit 1                          # bad exit. Time is over end we didn't succeed
    }

    "yes/no" {                          # when connecting for the very first time
        send "yes\r"
        exp_continue
    }

    "assword:" {                        # sending password to establish connection
        puts "sending password"
        send "$productionPassword\r"
        exp_continue
    }

    "assword for $productionUser:" {    # sending password to execute sudo command on remote machine
        puts "sending password for sudo"
        send "$productionPassword\r"
        expect eof
        puts "exiting 0"
        exit 0                          # good exit. We have input password after command had reqiured it and have made sure this command to finish
    }

    "$lastWordsFromPreviousOutput" {    # after the connection is established commands are executed on remote machine
        puts "mkdir folderrrr!!!!!"
        send "sudo mkdir folder\r"

        exp_continue
    }
}
