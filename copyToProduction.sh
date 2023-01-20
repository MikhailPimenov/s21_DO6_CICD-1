#!/usr/bin/expect

set productionUser "user1"
set productionPassword "555"
set productionAddress "10.10.0.1"

set lastWordsFromPreviousOutput "from 10.10.0.2"    # find it out mannually, what is the last line and the last words

spawn ssh -l $productionUser $productionAddress

set timeout 120

expect {
    timeout {
        puts "Connection timed out"
        exit 1                              # bad exit. Time is over end script was not executed
    }

    "yes/no" {                              # when connecting for the very first time
        send "yes\r"
        exp_continue
    }

    "assword:" {                            # sending password to establish connection
        puts "sending password"
        send "$productionPassword\r"
        exp_continue
    }

    "assword for $productionUser:" {        # sending password to execute sudo command on remote machine
        puts "sending password for sudo"
        
        send "$productionPassword\r"
        
        expect {
            "$ " {
                puts "success"
                exit 0                      # good exit. We have input password after command had reqiured it and have made sure this command \to finish
            }                         
            "File exists" {
                puts "File exists. Exiting"
                exit 1
            }
        }
    }

    "$lastWordsFromPreviousOutput" {        # after the connection is established commands are executed on remote machine
        puts "mkdir folderrrr!!!!!"
        send "sudo mkdir folder\r"

        exp_continue
    }
}
