# Ultimate Devil Download
> **Yt-Dlp & Aria2 TUI Download Script**

An easy and fast download MP3, MP4, Flac from Youtube and other files with Aria2

![preview](https://github.com/OwlMyName/Yt-Dlp-And-Aria2-TUI-Script/blob/7253a057970e7322d54564b4317687719dc47caf/demo.gif)

> Note: emulator WezTerm with ASCII art on background: not a part of script, sorry!

# Featuring:
Easily download any file from YouTube and other platforms without a GUI, just drop link with flags and file download. Only text and minimalistic, only terminal, only hardcore!
And soul with Easter eggs included.

This is my first steps in code, and I want to make the really good, easy and powerfully, but... Everything will happen, but not right away. And this takes and this text and repository too.

This script was created with AI assistance, but I personally write and moderate project. Sorry about that, I'm constantly learning and improving it.

## How it Works

* Format: [Link] [Flag] (For Example:https://youtu.be/... -4 -D 33:01-34:01).

| Flag | Action | Note |
| --- | --- | --- |
| `-3` | Download MP3 | Audio only |
| `-4` | Download MP4 | Video + Audio |
| `-5` | Download FLAC | High Quality Audio |
| `-6` | Link | Download file by direct link (Aria2) |


| Directories flag| Path | Description |
| --- | --- | ---|
| `-D` | "$HOME/Desktop" | Save file to Desktop |
| `-C` | "$HOME/Videos/Clips" | Save file to Clips
| `-M` | "$HOME/Music" | Save file to Music

|Timecodes| Description |
| --- | --- |
| `33:01` | Dowload from this time to end
| `33:01-34:01` | For example, one minute fragment from 33:01 to 34:01

|Service Command| Description | Note
| --- | --- | --- |
| `-exit` | Exit script
| `-upd` | Update Yt-Dlp | Only "yt-dlp -U" command, sorry 



This note you see at the every start of script.

## Before First Run

- **Paths.** The folders in the "Settings" part (Desktop, Clips, Music) are just examples. Change them to your own. Desktop is the default one, used when you don't pick a path flag.
- **Cookies.** Set your browser in the `COOKIES` variable in the "Settings" part. This lets yt-dlp use your browser session, so 18+ and other restricted content works. Until you set it, downloads will fail: the script has no error handling yet.
- **Updating.** `-upd` runs `yt-dlp -U`, which only works if yt-dlp is a standalone binary from GitHub Releases. If you installed it another way, edit the `-upd` block in the script:
  - pipx: `pipx upgrade yt-dlp`
  - pip: `pip install -U yt-dlp`

## Requirements:
* GNU Linux
* Yt-Dlp
* Bash 4+
* Ffmpeg
* Nodejs
* Aria2


> Note: if you on Ubuntu, Debian, some Fedora distribution or on other OS with outdated version for Yt-DLP- build from source. Official repository: https://github.com/yt-dlp/yt-dlp

## Why Bash?

Simplicity, a straightforward text interface, speed, and low hardware resource usage for background tasks

## My recommendation:
Make file executable:
> chmod +x DWL.sh

Make an simlink on directory /usr/local/bin/ to call script one command.
> sudo ln -s /path/to/script-dir/DWL.sh /usr/local/bin/dwl
