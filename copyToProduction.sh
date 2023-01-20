#!/usr/bin/expect

set productionUser "user1"
set productionPassword "555"
set productionAddress "10.10.0.1"

set prompt "user1@production:~$ "
set lastWordsFromPreviousOutput "from 10.10.0.2"

# spawn ssh -t $productionUser $productionAddress "bash -c 'sudo mkdir folder'"
spawn ssh -l $productionUser $productionAddress
# // put script in file!!!! and execute script-file with permissions 
set timeout 10
set exit_code 1
expect {
    timeout {
        puts "Connection timed out"
        exit $exit_code
    }

    "yes/no" {
        send "yes\r"
        exp_continue
    }

    "assword:" {
        puts "sending password"
        send "$productionPassword\r"
        exp_continue
    }

    "assword for $productionUser:" {
        puts "sending password for sudo"
        send "$productionPassword\r"
        # exp_continue
        expect eof
        exit 0
    }

    "$lastWordsFromPreviousOutput" {
        puts "mkdir folderrrr!!!!!"
        send "sudo mkdir folder\r"
        
        # expect "$ " {
            # exit 0
        # }
        exp_continue
    }
}
