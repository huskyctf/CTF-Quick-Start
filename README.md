# CTF-Quick-Start

When deploying a temporary cloud machine for a Capture The Flag (CTF) style challenge, it can be beneficial to have a standard workspace starting point. This script sets up a basic folder structure and penetration notes template.

## Usage

Basic use:
```bash
./ctf-setup.sh /path/to/empty/directory
```

Download and run in the current empty folder:
```bash
curl -s https://raw.githubusercontent.com/huskyctf/CTF-Quick-Start/main/ctf-setup.sh | bash /dev/stdin .
```

Create a new folder "ctf" and run in that folder:
```bash
mkdir ctf && cd ctf
curl -s https://raw.githubusercontent.com/huskyctf/CTF-Quick-Start/main/ctf-setup.sh | bash /dev/stdin .
```
