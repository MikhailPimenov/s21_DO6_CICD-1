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
set successCat "s21_cat is found in /usr/local/bin/!"
set failCat "s21_cat is NOT found in /usr/local/bin/!"
set successGrep "s21_grep is found in /usr/local/bin/!"
set failGrep "s21_grep is NOT found in /usr/local/bin/!"
spawn ssh $productionUser@$productionAddress test -f "/usr/local/bin/s21_cat1" && echo $successCat || echo $failCat

set resultCat "found"

set timeout 10

expect {
    timeout {
        puts "Connection timed out"
        puts "s21_cat was not checked"
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

    $failCat {
        set resultCat "not_found"
    }
}


set resultGrep "found"
# checking if s21_cat was copied
spawn ssh $productionUser@$productionAddress test -f "/usr/local/bin/s21_grep" && echo $successGrep || echo $failGrep

set timeout 10

expect {
    timeout {
        puts "Connection timed out"
        puts "s21_cat was not checked"
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

    $failGrep {
        set resultGrep "not_found"
    }
}



if { $resultGrep == "not_found" } {
    puts 'AZAZAZAZAZZZ'
    exit 1
}
if { $resultCat == "not_found" } {
    puts 'AAARGH!'
    exit 1
}