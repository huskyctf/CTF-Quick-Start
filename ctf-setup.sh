#!/bin/bash
#
# Title: CTF-Quick-Start
# Author: github.com/huskyctf
#
# Description: Setup a standard file/folder structure for temporary cloud CTF machines.
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

mkdir "$1/www" "$1/nmap" "$1/wordlists"


# Add important placeholder files

touch "$1/www/index.html"
touch "$1/wordlists/usernames.txt"
touch "$1/wordlists/passwords.txt"
touch "$1/credentials.txt"


# Generate an RSA key in case SSH access is possible on the target later

ssh-keygen -q -f $1/id_rsa -t rsa -C '' -N ''
mv "$1/id_rsa.pub" "$1/www/id_rsa.pub"


# Setup a notes.md with a few basic commands

cat << 'EOF' > "$1/notes.md"

# Penetration Testing Target(s)

Name:
Date:

```
export IP="127.0.0.1/32"
```

## Host Discovery

```
ping -c 1 $IP
sudo nmap -vv -n -sn $IP
```


## Port Scanning & Service Enumeration

```
sudo nmap -vv -n -sS -p- $IP
export PORTS="21,22,80,8080"
sudo nmap -vv -n -sV -sC -p $PORTS $IP
```


## Initial Access

```
1. Identify service versions / tech stack
2. Default or known credentials and anonymous access
3. Known vulnerabilities (CVEs)
4. Username enumeration and password spray
5. Service specific misconfigurations, injections or business logic flaws
6. Upgrade shells to SSH and establish persistence
```


## Privilege Escalation

```
1. Maintain persistence / C2
2. Enumerate security controls
3. ARP and routing tables
4. Stored credentials
5. Services or binaries on the host
```


EOF


# Confirm script has completed

echo "[+] The script has finished and folders are setup"
