#!/bin/bash

# Banner
echo "              ______        ______       _____ "
echo "___________  ____  /___________  /_________  /_"
echo "__  ___/  / / /_  __ \\_  ___/_  __ \\  __ \\  __/"
echo "_(__  )/ /_/ /_  /_/ /(__  )_  / / / /_/ / /_  "
echo "/____/ \\__,_/ /_.___//____/ /_/ /_/\\____/\\__/  "
echo "                                               "
echo

# Ask for domain
read -p "Enter domain to run recon on: " domain

# Check if input is empty
if [ -z "$domain" ]; then
  echo "No domain entered. Exiting."
  exit 1
fi

# Set output file for live domains
live_subdomains_file="${domain}_live.txt"

# Run subfinder and pipe directly into httpx
echo "[*] Finding and verifying subdomains for $domain..."
./subfinder -d "$domain" -silent | ./httpx -silent > "$live_subdomains_file"

# Check if anything was found
if [ ! -s "$live_subdomains_file" ]; then
  echo "[!] No live subdomains found."
  exit 1
fi

# Final message
echo "[+] Recon complete!"
echo "Live subdomains saved to: $live_subdomains_file"
