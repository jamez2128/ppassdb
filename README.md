# `ppassdb`
- It is POSIX compliant shell script that manages encrypted text files.
- It is an another alternative to [password-store](https://www.passwordstore.org/).
- It uses `gpg` to encrypt files.
- Aims for portability.
- Designed to work on most Operating Systems including Android and Windows.
- It encrypts text files and encrypts them indivdually or with a key pair .
- It mainly puts the encrypted text to clipboard after decryption.
- If the script doesn't support the clipboard, there is an option to
use the web browser instead.

# `dpassmenu`
- A simple dmenu script that decrypts files to clipboard with
ppassdb that I definitely not copied from the [password-store](https://www.passwordstore.org/)
devs.
- Very powerful script especially if binded on a keyboard

## Table of Contents
- [Depedencies](#Depedencies)
	- [Optional](#Optional)
	- [GNU/Linux](#gnu-linux)
	- [Windows](#Windows)
	- [Android](#Android)
- [Installation](#Installation)
	- [ppassdb](#install-ppassdb)
	- [dpassmenu](#install-dpassmenu)
- [Uninstallation](#Uninstallation)
	- [Remove encrypted all files](#remove-encrypted-files)
	- [Uninstall ppassdb](#uninstall-ppassdb)
	- [Uninstall dpassmenu](#uninstall-dpassmenu)
- [Manual](#Manual)
	- [ppassdb](#ppassdb-manual)
		- [Usage](#Usage-ppassdb)
		- [Operations](#Operations-ppassdb)
		- [Options](#Options-ppassdb)
		- [Examples](#ppassdb-examples)
	- [dpassmenu](#dpassmenu-manual)
		- [Usage](#Usage-dpassmenu)
		- [Options](#Options-dpassmenu)
- [Directory location](#directory-location)
	- [Priorities for searching existed directories](#search-directory) 
	- [Priorities for initializing directories](#initialize-directory) 
	- [Changing Directory Locations](#change-directory) 

## Depedencies
- `gnupg`
- `oauthtool` (For OTP codes)

### Optional:
- `tree`
- `notify-send`
- `zbar` (For decoding QR Codes)
- `qrencode`(For generating QR Codes)

### <a name=gnu-linux></a> GNU/Linux:
- `xclip` or `wl-copy`
- `dmenu` (`dpassmenu`)

### Windows:
- `Bash` (Either `Git bash` or `WSL`)

### Android:
- `Termux`
- `Termux: API`

## Installation
### <a name=install-ppassdb></a> `ppassdb`:
Step 1: Download the file by entering this command:
```
curl -LO  https://raw.githubusercontent.com/jamez2128/ppassdb/master/ppassdb
```

Step 2: Give execution permissions:
```
chmod +x ./ppassdb
```

Step 3: For system-wide installation, put the script to `/usr/local/bin` (Need root privileges in Linux):
```
cp ./ppassdb /usr/local/bin
```
### <a name=install-dpassmenu></a>`dpassmenu`:
Step 1: Download the file by entering this command:
```
curl -LO  https://raw.githubusercontent.com/jamez2128/ppassdb/master/dpassmenu
```

Step 2: Give execution permissions:
```
chmod +x ./dpassmenu
```
Step 3: For system-wide installation, put the script to `/usr/local/bin` (Need root privileges in Linux):

```
cp ./dpassmenu /usr/local/bin
```

## Uninstallation
If you want to know where the script saves the files and you want to delete it, run this command:
```
ppassdb location
```
If you think that it is safe to delete, run this command:
### <a name="remove-encrypted-files"></a> Remove all encrypted files:
```
rm -r "$(ppassdb location)"
```
### <a name="uninstall-ppassdb"></a>Uninstall `ppassdb`:
```
rm  /usr/local/bin/ppassdb
```
### <a name=uninstall-dpassmenu></a> Uninstall `dpassmenu`:
```
rm /usr/local/bin/dpassmenu
```
## Manual
### <a name="ppassdb-manual"></a>`ppassdb`
#### <a name="Usage-ppassdb">Usage
```
ppassdb <operation> [options] <filename>
```

#### <a name="Operations-ppassdb">Operations
- `help`, `--help`				To shows this help message.
- `add`, `insert`				For adding and encrypting text files.
- `open`					For decrypting and opening an encrypted
					text file.
- `list`, `ls`				Lists all the added encrypted text
					files.If a sub directory is not
					specified, it will list all encrypted
					files from all subdirectories.
- `location`, `pwd`				Outputs the path to where all the
					encrypted files will be stored.

#### <a name="Options-ppassdb"></a>Options
- `--notify`				Pushes feedback messages to
					notifications. (Only works on Linux)

##### Specific for `-E` only:
- `--qr-code=\</path/to/image.png\>`		Decodes QR Code and encrypts the text.
					If it is an OTP. It is highly
					recommended to specify --otp to
					validate it when encrypting.
- `--generate`				Auto generates a random string and
					encrypts it.
- `--char-length=<NUMBER>`			Specify the number of characters to
					randomly generate.
- `--char-type=<STRING>`			Specify the type of characters to
					randomly generate.
	- `[:graph:]` - All printable characters, except whitespace
	- `[:alnum:]` - All letters and numbers
	- `[:alpha:]` - Letters only
	- `[:lower:]` - Capital letters only
	- `[:upper:]` - Small letters only 
	- `[:digit:]` - Numbers only
	For more options, refer to the tr manual
- `--recipient=\<GPG ID\>`			Encrypts it with a existing user
					ID name made 
					with a key pair. Without this option,
					it will use symetric encryption
					instead.
- `--multi-line`				Encrypts a multi-line text instead
					of a single line.
##### Specific to both `-D` and `-E`:
- `-n`, `--no-clip`				This option will not attempt to
					copy to clipboard.
- `-l`, `--clear`				Clears the clipboard after a period
					of time.
- `-o`, `--show-secret`			Shows the text. This will return a
					successful exit status even if the
					clipboard failed.
- `--html`					Puts text to the generated html to 
					copy it from the web browser.
- `--forget`				Forgets password after an operation
					was performed
- `--otp`					For decryption, it converts the OTP
					URL to OTP code. For encryption, it
					verifies and tell information about the
					OTP URL to encrypt so to know whether
					the URL is valid for code generation.
- `--show-qr-code`				Encodes text to QR code. It is useful
					to scan OTP URL's to authenticator
					apps on phones. If you are using it for
					OTP's, it is recommended to use the
					--otp option to validate it.

#### <a name=ppassdb-examples></a> Examples
##### Shows the path to all the encrypted files:
```
ppassdb location
```

##### List all encrypted files:
```
ppassdb list
```

##### List all encrypted files from a specific directory:
```
ppassdb list "username"
```

##### Encrypt a text:
```
ppassdb add "username/website.pass" 
```

##### Generate a random password and encrypt it:
```
ppassdb add --generate "username/website.pass" 
```

##### Generate a random password with specific options and encrypts it:
```
ppassdb add --generate --char-length=16 --char-type="[:graph:]" "username/website.pass" 
```

##### Decrypts the password and put it into the system clipboard and clears for a period of time:
```
ppassdb open --clear  "username/website.pass"
```

##### Decrypts the password, show it and doesn't copy to system clipboard:
```
ppassdb open --no-clip --show-secret  "username/website.pass"
```

##### Decodes a QR code and encrypts it (Typically used in 2FA OTP):
```
ppassdb add --qr-code="/path/to/qr/code.png" "username/website.otp"
```

##### Decrypts the password and turns the OTP URL to a code and clears the clipboard for the period of time:
```
ppassdb open --otp --clear \"username/website.otp\"
```

##### Decrypts the password and encodes OTP URL back to QR code so it can be scanned by authenticators apps:
```
ppassdb open --no-clip --show-qr-code \"username/website.otp\"
```

### <a name="dpassmenu-manual"></a>`dpassmenu`

A simple dmenu script for ppassdb

#### <a name="Usage-dpassmenu"></a>Usage
```
dpassmenu [options]
```

#### <a name="Options-dpassmenu"></a>Options
- `--help`		To show this help message
- `--otp`		Generate an OTP code instead of the
		encrypted text. All files without the
		.otp at the end are hidden unless
		if --show-all is specified.
- `--show-all`	Show all files even if otp is specified.
- `--sort`		Sort all files and folders together

##  <a name="directory-location"></a>Directory Location
If you want to know where the script saves the files, run this command:
```
ppassdb location
```
If you want to know all the possible locations, it is listed below

###  <a name="search-directory"></a>Priorities for searching existed directories:
- `/storage/emulated/0/ppassdb`
- `%APPDATA%\ppassdb`
- `~/Library/Application Support/ppassdb`
- `~/.ppassdb`
- `~/.local/share/ppassdb`
- `$XDG_DATA_HOME/ppassdb`

###  <a name="initialize-directory"></a>Priorities for initializing directories:
- `/storage/emulated/0/ppassdb`
- `%APPDATA%\ppassdb`
- `~/Library/Application Support/ppassdb`
- `$XDG_DATA_HOME/ppassdb`
- `~/.local/share/ppassdb`
- `~/.ppassdb`
- Current directory

### <a name="change-directory"></a> Changing Directory Locations:
If you wish to change the location, you can do so by editing directly in
the script's variable in the Configuration part, or exporting "PPASSDB_HOME" as 
an environmental variable. For example:
- Change to Home Directory:
```
export PPASSDB_HOME="$HOME/.ppassdb"
```

- Change to XDG Base Directory
```
export PPASSDB_HOME="$HOME/.local/share/ppassdb"
```

or this (Must have XDG_DATA_HOME defined)
```
export PPASSDB_HOME="$XDG_DATA_HOME/ppassdb"
```
It is recommended to set the environmental variable so not it does need to check
for directories everytime the script runs. You have to suffix an empty directory
or the directory that has files already made by the script. If you plan to change it,
make sure to move it to desired directory first before setting an environmental variable.
