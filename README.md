# Ultimate Devil Download
> **Yt-Dlp & Aria2 TUI Download Script**

An easy and fast download MP3, MP4, Flac from Youtube and other files with Aria2

![preview](https://github.com/OwlMyName/Yt-Dlp-And-Aria2-TUI-Script/blob/7253a057970e7322d54564b4317687719dc47caf/demo.gif)

> Note: emulator WezTerm with ASCII art on background: not a part of script, sorry!

# Featuring:
Easily download any file from YouTube and other platforms without a GUI, just drop link with flags and file download. Only text and minimalistic, only terminal only hardcore!
And soul with Easter eggs included.

This is my first steps in code, and I want to make the really good, easy and powerfully, but... Everything will happen, but not right away. And this takes and this text and repository too.

This script was created with AI assistance, but I personally write and moderate project. Sorry about that, I'm constantly learning and improving it.

# How it Works

* Format: [Link] [Flag] (For example: https://youtu.be/... -4).

| Flag | Action | Note |
| --- | --- | --- |
| `-3` | Download MP3 | Audio only |
| `-4` | Download MP4 | Video + Audio |
| `-5` | Download FLAC | High Quality Audio |
| `-6` | Link | Direct link output |
| `-exit` | Exit script | Works without link |

| Directories flag| Path | Description |
| --- | --- | ---|
| `-D` | "$HOME/Desktop" | Save file to Desktop |
| `-C` | "$HOME/Videos/Clips" | Save file to Clips
| `-M` | "$HOME/Music" | Save file to Music

This note you see at the every start of script.

> Important Note: Paths here is just example, you can add and rewrite paths. Recommendation: if you don't have this paths, rewrite it on script before start in "Settings" part. Especially Desktop path, this is a default path

> Important Note: And rewrite path to Cookies browser (This make to unlock 18+ and other content) in "Settings" part. The script currently doesn't have error handling and if you don't rewrite paths- the script will crash.


# Requirements:
* GNU Linux
* Yt-Dlp
* Bash 4+
* Ffmpeg
* Nodejs


> Note: if you on Ubuntu, Debian, some Fedora distribution or on other OS with outdated version for Yt-DLP- build from source. Official repository: https://github.com/yt-dlp/yt-dlp

# Why Bash?

Simplicity, a straightforward text interface, speed, and low hardware resource usage for background tasks

# My recommendation:
Make file executable:
> chmod +x DWL.sh

Make an simlink on directory /usr/local/bin/ to call script one command.
> sudo ln -s /path/to/script-dir/DWL.sh /usr/local/bin/dwl
