#!/usr/bin/expect

set productionUser "user1"
set productionPassword "555"
set productionAddress "10.10.0.1"

# find out mannually what is the last line and the last words
# 10.10.0.2 is address of vm with runner (where this script is executed)
set lastWordsFromPreviousOutput "from 10.10.0.2"    

# spawn ssh -l $productionUser $productionAddress


spawn scp src/cat/s21_cat $productionUser@$productionAddress:s21_cat

set timeout 10
expect {
    timeout {
        puts "Connection timed out"
        puts "s21_cat was not copied"
        exit 1
    }

    # when connecting for the very first time
    "yes/no" {                              
        send "yes\r"
        exp_continue
    }

    # sending password to establish connection
    "assword:" {                                
        puts "sending password"
        send "$productionPassword\r"
        exp_continue
        exit 0
    }
}


spawn scp src/grep/s21_grep $productionUser@$productionAddress:s21_grep

set timeout 10
expect {
    timeout {
        puts "Connection timed out"
        puts "s21_grep was not copied"
        exit 1
    }

    # when connecting for the very first time
    "yes/no" {                              
        send "yes\r"
        exp_continue
    }

    # sending password to establish connection
    "assword:" {                                
        puts "sending password"
        send "$productionPassword\r"
        exp_continue
        exit 0
    }
}

set timeout 120

# order inside does not matter
expect { 
    timeout {
        puts "Connection timed out"
        # bad exit. Time is over end script was not executed
        exit 1                              
    }

    # when connecting for the very first time
    "yes/no" {                              
        send "yes\r"
        exp_continue
    }

    # sending password to establish connection
    "assword:" {                                
        puts "sending password"
        send "$productionPassword\r"
        exp_continue
    }

    

    # after the connection is established commands are executed on remote machine
    "$lastWordsFromPreviousOutput" {        
        # puts "mkdir folderrrr!!!!!"
        # send "sudo mkdir folder\r"
        
        puts "moving executables!!!!!!"
        send "sh -c 'sudo mv s21_cat /usr/local/bin/' && sh -c 'sudo mv s21_grep /usr/local/bin/'"

        # sending password to execute sudo command on remote machine
        "assword for $productionUser:" {        
        puts "sending password for sudo"
        send "$productionPassword\r"
        
            expect {
                "$ " {
                    puts "success"
                    # good exit. We have input password after command had reqiured it and have made sure this command \to finish
                    exit 0                      
                }                         
                "File exists" {
                    puts "File exists. Exiting"
                    exit 1
                }
            }
        }


        exp_continue
    }
}
