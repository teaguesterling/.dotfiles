#!/bin/bash
# git-config.sh - Configure git settings securely
# This script sets up git configuration without storing sensitive data in the repository

set -e

echo "=== Git Configuration Setup ==="

# Basic user configuration
echo "Configuring git user settings..."
git config --global user.email "teaguesterling@gmail.com"
git config --global user.name "Teague Sterling"

# Push configuration
echo "Configuring git push settings..."
git config --global push.autoSetupRemote true
git config --global push.default current

# Branch configuration
echo "Configuring git branch settings..."
git config --global init.defaultBranch main

# Pull configuration
echo "Configuring git pull settings..."
git config --global pull.rebase false

# GPG signing configuration
echo ""
echo "=== GPG Signing Key Setup ==="
echo "Checking for existing GPG keys..."

# List existing keys
gpg --list-secret-keys --keyid-format=long

echo ""
echo "Do you want to generate a new GPG key? (y/n)"
read -r generate_key

if [[ "$generate_key" == "y" || "$generate_key" == "Y" ]]; then
    echo "Generating new GPG key..."
    echo "Follow the prompts:"
    echo "  - Choose RSA and RSA (default)"
    echo "  - Key size: 4096 bits"
    echo "  - Expiration: 2y (2 years) or 0 (no expiration)"
    echo "  - Name: Teague Sterling"
    echo "  - Email: teaguesterling@gmail.com"
    echo ""
    
    gpg --full-generate-key
    
    echo ""
    echo "New key generated! Here are your keys:"
    gpg --list-secret-keys --keyid-format=long
fi

echo ""
echo "Please enter your GPG key ID (the long string after 'rsa4096/'):"
read -r key_id

if [[ -n "$key_id" ]]; then
    echo "Configuring git to use GPG key: $key_id"
    git config --global user.signingkey "$key_id"
    git config --global commit.gpgsign true
    
    echo ""
    echo "=== Public Key for GitHub ==="
    echo "Copy this public key and add it to your GitHub account:"
    echo "GitHub Settings > SSH and GPG keys > New GPG key"
    echo ""
    gpg --armor --export "$key_id"
    echo ""
    echo "=== Configuration Complete ==="
    echo "Git is now configured with:"
    echo "  - User: Teague Sterling <teaguesterling@gmail.com>"
    echo "  - GPG signing enabled with key: $key_id"
    echo "  - Push: autoSetupRemote enabled"
    echo "  - Default branch: main"
    echo "  - Pull: merge strategy (no rebase)"
else
    echo "No key ID provided. Skipping GPG configuration."
    echo "Git basic configuration complete."
fi

echo ""
echo "You can run this script again anytime to reconfigure git settings."