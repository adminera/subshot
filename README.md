<h1 align="center">
  <img src="static/subshotlogo2.jpg" alt="subshot" width="150px">
  <br>
</h1>

<h4 align="center">Fast live subdomain enumeration tool</h4>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#installation">Install</a> •
  <a href="#post installation">Post Installation</a> 
  <a href="#usage">Usage</a> •
  
</p>


---

`subshot` is a bash script tool that will take a given domain and enumerate the subdomains using the popular tool subfinder and then it will filter out the live subdomains using httpx

This tool will streamline web pentesting engagements and bug bounty hunting by allowing ethical hackers to filter out valuable subdomains to work on rather than manually checking the original subdomains.

This tool also streamlines the subdomain recon process as the ethical hacker does not need to run subfinder and httpx manually in the terminal which can cost time, especially over working with many targets.

# Features

- Fast and accurate subdomain enumeration
- Outputs in txt file for easy reading and modification
- Good user interacting in terminal for debugging and usage

# Install

`subshot` requires **subfinder** and **httpx** to install successfully. 

These can be installed on Github through here:

<a href="https://github.com/projectdiscovery/subfinder">Subfinder</a>

<a href="https://github.com/projectdiscovery/httpx">httpx</a>

Please make sure that `subshot` is in the same directory as subfinder and httpx

# Post Installation

In order to be able to run the program you must grant it the correct permissons first, Run the following in terminal:

```sh
chmod +x subshot.sh
```





