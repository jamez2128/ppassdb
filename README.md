## Depedencies
### Global:
- `gpg`

### Optional:
- `tree`
- `notify-send`

### GNU/Linux:
- `xclip` or `wl-copy`

### Windows:
- `Bash` (Either `Git bash` or `WSL`)

### Android:
- `Termux`
- `Termux: API`

## Installation
### ppassdb:
```
curl -LO  https://raw.githubusercontent.com/jamez2128/ppassdb/master/ppassdb
```
For system-wide installation, put the script to `/usr/local/bin` (Need root privileges in Linux):
```
cp ppassdb /usr/local/bin
```

## Uninstallation
If you want to know where the script saves the files and you want to delete it, run this command:
```
ppassdb -L | sed -n 2p
```
If you think that it is safe to delete, run this command:
```
rm -r "$(ppassdb -L | sed -n 2p)"
```
### Uninstall ppassdb:
```
rm ppassdb /usr/local/bin
```

## Examples

If the script doesn't run, make sure that you that the file has
permissions to run. To give it execution permissions:
```
chmod +x ./ppassdb
```
## Usage
```
ppassdb <operation> [options] <filename>
```

## Operations
- `-h`, `--help`      To shows this help message
- `-E`              For adding and encryting text files.
- `-D`              For decrypting text file.
- `-L`              Lists all the added encrypted text files.

## Options
- `-n`      Pushes feedback messages to notifications (Only works on Linux)

### Specific for `-E` only:
- `-g`       Auto generates a random string and encrypts it.

### Specific to both `-D` and `-E`:
- `-c`      Clears the clipboard after a period of time.
- `-f`      This will be the input file name. "/" are not allowed in this 
        option and will be replaced with "_" if present.
- `-i`      An identifier to group encrypted files. This is optional and if 
        this option is not called, it will use the default folder.
- `-s`      Shows the text. This will return a successful exit status even if 
        the clipboard failed.
- `-j`      Puts text to the generated html to copy it from the web browser.

## Examples
Lists all encrypted file:
```
ppassdb -L
```

Encrypt a text:
```
ppassdb -E -i "username" -f "website.pass" 
```

Decrypts the password and put it into the system clipboard and clears for a period of time:
```
ppassdb -Dc -i "username" -f "website.pass"
```

## Directory Location
If you want to know where the script saves the files, run this command:
```
ppassdb -L | sed -n 2p
```
If you want to know all the possible locations, it is listed below

### Priorities for searching existed directories:
- `/storage/emulated/0/ppassdb`
- `$APPDATA/ppassdb`
- `~/Library/Application Support/ppassdb`
- `~/.ppassdb`
- `~/.local/share/ppassdb`
- `$XDG_DATA_HOME/ppassdb`

### Priorities for initializing directories:
- `/storage/emulated/0/ppassdb`
- `$APPDATA/ppassdb`
- `~/Library/Application Support/ppassdb`
- `$XDG_DATA_HOME/ppassdb`
- `~/.local/share/ppassdb`
- `~/.ppassdb`
- Current directory
