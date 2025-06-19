#!/bin/bash

# Banner
echo "              ______        ______       _____ "
echo "___________  ____  /___________  /_________  /_"
echo "__  ___/  / / /_  __ \\_  ___/_  __ \\  __ \\  __/"
echo "_(__  )/ /_/ /_  /_/ /(__  )_  / / / /_/ / /_  "
echo "/____/ \\__,_/ /_.___//____/ /_/ /_/\\____/\\__/  "
echo "                                               "
echo

# Ask for mode: single domain or list
echo "Choose scan mode:"
echo "1) Single domain"
echo "2) List of domains from a file"
read -p "Enter your choice (1 or 2): " mode

# Function to clean domains
clean_domain() {
  local raw="$1"
  echo "$raw" | sed 's/^[*.]*//'
}

# Function to run recon for a domain and append to master file
run_recon() {
  local raw_domain="$1"
  local domain
  domain=$(clean_domain "$raw_domain")

  echo "[*] Finding and verifying subdomains for $domain..."
  ./subfinder -d "$domain" -silent | ./httpx -silent > temp_live.txt

  if [ -s temp_live.txt ]; then
    echo "[+] Live subdomains for $domain:"
    cat temp_live.txt

    {
      echo "===== $domain ====="
      cat temp_live.txt
      echo
    } >> "$master_output"
  else
    echo "[!] No live subdomains found for $domain"
  fi

  rm -f temp_live.txt
}

# Handle mode selection
if [ "$mode" == "1" ]; then
  read -p "Enter domain to scan: " domain_input
  if [ -z "$domain_input" ]; then
    echo "[!] No domain entered. Exiting."
    exit 1
  fi

  clean_name=$(clean_domain "$domain_input")
  master_output="${clean_name}_live_domains.txt"
  > "$master_output"

  run_recon "$domain_input"

elif [ "$mode" == "2" ]; then
  read -p "Enter path to domains file: " domains_file
  if [ ! -f "$domains_file" ]; then
    echo "[!] File not found: $domains_file"
    exit 1
  fi

  filename=$(basename "$domains_file")
  base="${filename%.*}"
  master_output="${base}_live_domains.txt"
  > "$master_output"

  while IFS= read -r line || [[ -n "$line" ]]; do
    domain=$(echo "$line" | tr -d '[:space:]')
    [ -z "$domain" ] && continue
    run_recon "$domain"
    echo
  done < "$domains_file"

else
  echo "[!] Invalid option. Please choose 1 or 2."
  exit 1
fi

echo "[+] Recon complete!"
echo "Results saved in: $master_output"
