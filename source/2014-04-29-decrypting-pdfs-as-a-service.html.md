---
title: Decrypting PDFs as a Service
date: 2014-04-29 16:08 ICT
description: "This script and service pair allow easy decrypting of encrypted PDFs"
tags: PDF, security, encryption, services, Mac OS

---

Sometimes, you just need to decrypt encrypted PDFs. A lot of them.

Here's a [shell script](https://gist.github.com/faun/11390337) to decrypt all encrypted PDFs in a folder. It uses the `security` command line tool for Mac OS, which stores the password for future use in the keychain.

```sh
#! /bin/sh

# Check if qpdf is installed
installed=$(which qpdf &> /dev/null)
if [ $? -eq 1 ]; then
    echo >&2 "Please install qpdf first (brew install qpdf)"
    exit 1
fi

# Fetch the password from the keychain
password_entered=false
password=$(security 2> /dev/null find-generic-password -a login -s decrypt_pdfs -D "application password" -w)

# Prompt for password if not in keychain
if [ -z $password ]; then
    echo "Enter the password to decrypt PDFs:"
    read -s password
    password_entered=true
fi

# Make a folder called 'decrypted' unless it exists
mkdir -p decrypted

# Decrypt all .pdf files in the current directory
for file in *.pdf; do
    set -e
    echo "Decrypting $file"
    qpdf --decrypt --password="$password" "$file" "decrypted/$file"
done

# Save the password to the keychain
if [ $password_entered != false ]; then
    echo "Save password in keychain?"
    read yn
    case $yn in
        [Yy]* ) security add-generic-password -a login -l pdf_password -s decrypt_pdfs -T "" -w $password; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
fi
```

Below is a similar [service](https://gist.github.com/faun/11394915) for Automator that decrypts PDFs from a selection of either files or folders or both.

```sh
#! /bin/sh

password=$(security 2> /dev/null find-generic-password -a login -s decrypt_pdfs -D "application password" -w)

set -e

decrypt_file () {
  source_file="$1"
  filename="$(basename "$source_file")"
  directory="$(dirname "$source_file")/decrypted"
  destination="$directory/$filename"
  mkdir -p "$directory"

  qpdf --decrypt --password="$password" "$source_file" "$destination"
}

for arg in "$@"; do

  if [[ -d $arg ]]; then
    for file in "$arg"/*.pdf; do
      decrypt_file "$file"
    done

  elif [[ -f $arg ]]; then
    decrypt_file "$arg"
  fi

done
```

Passwords are stored in the Mac OS keychain. It is required to save the password to the keychain using the command-line tool before using the service, since the service uses the stored keychain password to decrypt the PDF.
