# Ultimate Devil Download
> **Yt-Dlp & Aria2 TUI Download Script**

An easy and fast download MP3, MP4, Flac from Youtube and other files with Aria2

![preview](https://github.com/OwlMyName/Yt-Dlp-And-Aria2-TUI-Script/blob/e1722f12ff9404c83466a89724d44918ca309c9b/preview.jpg)

> Note: emulator WezTerm with ASCII art on background: not a part of script, sorry

# Featuring:
Easy download any file from YouTube and other without an interface, just drop link with flag and file download. Only text and minimalistic, only terminal only hardcore!
And soul with Easter eggs included.

This is my firsts steps in code, and i want to make the really good, easy and powerfully, but... Everything will happen, but not right away. And this takes and this text and repo too.

This script with AI help, but i write and moderate project. Sorry about that, i fix this in last time.


# How it Works

* Format: [Link] [Flag] (For example: https://youtu.be/... -4).

| Flag | Action | Note |
| --- | --- | --- |
| `-3` | Download MP3 | Audio only |
| `-4` | Download MP4 | Video + Audio |
| `-5` | Download FLAC | High Quality Audio |
| `-6` | Link | Direct link output |
| `-exit` | Exit script | Works without link |

This note you see at the every start of script.

# What do need a script:
* GNU Linux
* Yt-Dlp
* Bash 4+
* Ffmpeg
* Nodejs

And rewrite path to Cookies browser (This make to unlock 18+ and other content) and path to download.

> Note: if you on Ubuntu, Debian, some Fedora  or on other OS with outdated version OS for Yt-DLP- build from source. Official repository: https://github.com/yt-dlp/yt-dlp

# Who will be next:
* Many fix problem. 
* Flags for download to many directories (-D to dowload on "Desktop" or -C on "Clips", as an example).
* Maybe part of logic.

# My recommendation:
Make file executable:
> chmod +x DWL.sh

Make an simlink on directory /usr/local/bin/ to call script one command.
> sudo ln -s script-dir/DWL.sh /usr/local/bin/dwl
