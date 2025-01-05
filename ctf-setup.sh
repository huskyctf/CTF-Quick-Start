#!/bin/bash
#
# Title: CTF-Quick-Start
# Author: github.com/huskyctf
#
# Description: Setup a standardised folder structure for temporary cloud CTF machines.
#
# Usage: ./ctf-setup.sh /path/to/empty/directory
#

# Check if directory exists and is empty

if [ $# -eq 0 ]; then
    echo "Usage: ./ctf-setup.sh /path/to/empty/directory"
    exit
fi

if [ ! -d $1 ]; then
    echo "Error: Specified directory does not exist"
    exit
fi

if [[ ! -r $1 || ! -w $1 ]]; then
    echo "Error: You do not have read/write permissions to specified directory"
    exit
fi

if [ ! -z "$(ls -A $1)" ]; then
    echo "Error: Please specify an empty directory"
    exit
fi


echo "[+] Script is running..."


# Create the subfolder layout

mkdir "$1/www" "$1/nmap" "$1/hosts" "$1/custom-wordlists"


# Add important blank files

touch "$1/www/index.html"
touch "$1/custom-wordlists/usernames.txt"
touch "$1/custom-wordlists/passwords.txt"


# Generate an RSA key in case SSH access is possible on the target later

ssh-keygen -q -f $1/id_rsa -t rsa -C '' -N ''
mv "$1/id_rsa.pub" "$1/www/id_rsa.pub"


# Setup a notes.md with a few basic commands

cat << 'EOF' > "$1/notes.md"

# Penetration Test Notes

## Date:
## Name:


# Target(s)

```
export IP="127.0.0.1/32"
```

## Found Credentials

```
username::password    # example line
```


# Reconnaissance

## Host Discovery

```
ping -c 1 $IP
sudo nmap -vv -n -sn $IP
```


## Port Scanning

```
sudo nmap -vv -n -sS -p- $IP
export PORTS="21,22,80,8080"
```

## Initial Service Enumeration

```
sudo nmap -vv -n -sV -sC -p $PORTS $IP
```


# Initial Access

```
Basic checks:
1. Identify and enumerate service versions
2. Research for any CVEs
3. Check for default credentials or anonymous access
4. Enumerate usernames and check for common passwords
5. Check for service specific misconfigurations or injections
6. Upgrade shells to SSH or establish other persistence
```



# Privilege Escalation




EOF


# Confirm script has completed

echo "[+] The script has finished and folders are setup"
