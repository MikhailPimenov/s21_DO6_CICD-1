#!/usr/bin/expect

set productionUser "user1"
set productionPassword "555"
set productionAddress "10.10.0.1"

# find out mannually what is the last line and the last words
# 10.10.0.2 is address of vm with runner (where this script is executed)
set lastWordsFromPreviousOutput "from 10.10.0.2"    

# sometimes ubuntu suggests to upgrade after the connection is established
set lastWordsFromPreviousOutput2 "Run 'do-release-upgrade' to upgrade to it."

# checking if s21_cat was copied
ssh productionUser@productionAddress test -f "/etc/local/bin/s21_cat" && echo found_azaza || echo not_found_azazz

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

    "lost connection" {
        puts "Something whent wrong. Perhaps there are issues with the production server"
        exit 1
    }
}
