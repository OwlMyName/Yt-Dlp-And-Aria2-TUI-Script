#!/bin/bash

cd "$(dirname "$0")"

# Make window name
echo -ne "\033]0;Download Hub\a"

# Note menu
echo "======================= Ultimate Devil Download ======================="
echo "Format: [Link] [Flag] +Optional [Path] [Timecode]"
echo "For Example:https://youtu.be/... -4 -D 33:01-34:01"
echo ""
echo "Are you gonna make the right choice?"
echo "[-3] = MP3"
echo "[-4] = MP4"
echo "[-5] = FLAC"
echo "[-6] = Link"
echo ""
echo "Choose your path, Samurai!"
echo "[-D] = Desktop"
echo "[-C] = Clips"
echo "[-M] = Music"
echo ""
echo "John Connor, it is time!"
echo "Default 00:00"
echo "[33:01] = Timecode from"
echo "[33:01-34:01] = 1 Min Part For Example "
echo ""
echo "Service Command"
echo "[-upd] = Update"
echo "[-exit] = Exit"
echo "======================================================================="

# === Settings ===
# Paths and for cookies
COOKIES="[Browser]: [Path]" #Note: write without [], just "firefox: path". All types of browsers learn on official repo of Yt-Dlp

# -- Main Dirs --
DIR_DESKTOP="$HOME/Desktop"
DIR_CLIPS="$HOME/Videos/Clips"
DIR_MUSIC="$HOME/Music"
# Note: you can add many paths, just add it here and in main cycle

# Template for saves
TPL_SINGLE="%(title)s.%(ext)s" #Note: If you download one file from link, not a playlist
TPL_PLAYLIST="%(playlist_title)s/%(playlist_index)02d - %(title)s.%(ext)s" #Note: If you download a playlist or album
# Template for Aria2
ARIA_ARGS="aria2c:-c -x 16 -s 16 -k 1M"

# === Guts and Parts ===

# 1. Timecode module (invalid input = ignored, full download)
get_timecode() {
    local tc="$1"
    local t='[0-9]{1,2}(:[0-5][0-9]){1,2}'

    if [[ "$tc" =~ ^${t}(-${t})?$ ]]; then
        [[ "$tc" == *-* ]] || tc="${tc}-inf"        # 3:00 -> 3:00-inf
        SECTION_ARGS=(--download-sections "*${tc}" --force-keyframes-at-cuts)
        FINAL_PATH="${FINAL_PATH%'.%(ext)s'} [${tc//:/.}].%(ext)s"
        echo ">> [System] Clip mode: $tc"
    else
        echo ">> [System] Bad timecode '$tc', ignoring. Downloading full."
    fi
}
 


# === Modules ===

# 1. MP3 module
get_mp3() {
    local target_link="$1"
    local playlist_flag="$2"
    local final_path="$3"
    
    echo ">> [MP3] Downloading Audio, Please Wait..."
    
    yt-dlp --cookies-from-browser "$COOKIES" --js-runtimes node \
           --downloader aria2c --downloader-args "$ARIA_ARGS" \
           "$playlist_flag" -f "ba/b" -x --audio-format mp3 --audio-quality 0 \
           --embed-metadata --embed-thumbnail --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -id3v2_version 3" \
           --no-check-certificate "${SECTION_ARGS[@]}" -o "$final_path" "$target_link" 
#          --no-check-certificate -o "$final_path" "$target_link"
           
    preset_msg="[OK] Ready. Bon Appetit Mon Ami."
}

# 2. MP4 module
get_mp4() {
    local target_link="$1"
    local playlist_flag="$2"
    local final_path="$3"
    
    echo ">> [MP4] Downloading Video, Please Wait..."
    
    yt-dlp --cookies-from-browser "$COOKIES" --js-runtimes node \
           --downloader aria2c --downloader-args "$ARIA_ARGS" \
           "$playlist_flag" -S "ext:mp4:m4a" --remux-video mp4 \
           --embed-metadata --embed-thumbnail \
           --no-check-certificate "${SECTION_ARGS[@]}" -o "$final_path" "$target_link" 
#          --no-check-certificate -o "$final_path" "$target_link"
           
    preset_msg="[OK] Ready. Bon Appetit Mon Ami."
}


# 3. Flac module
get_flac() {
    local target_link="$1"
    local playlist_flag="$2"
    local final_path="$3"
    
    echo ">> [FLAC] Hi-Fi Audio Downloading, Please Wait..."
    
    yt-dlp --cookies-from-browser "$COOKIES" --js-runtimes node \
           --downloader aria2c --downloader-args "$ARIA_ARGS" \
           "$playlist_flag" -f "ba/b" -x --audio-format flac \
           --embed-metadata --embed-thumbnail --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -id3v2_version 3" \
           --no-check-certificate "${SECTION_ARGS[@]}" -o "$final_path" "$target_link" 
#          --no-check-certificate -o "$final_path" "$target_link"
           
    preset_msg="[OK] Ready. Bon Appetit Mon Ami."
}

# 4 Link (Aria2) module
get_link() {
    local target_link="$1"
    local work_dir="$2"
    
    echo ">> [Link] The Thing On Link, Please Wait"
    
    aria2c -c -x 16 -s 16 -k 1M -d "$work_dir" "$target_link"
           
    preset_msg="[OK] Ready. Bon Appetit Mon Ami."
}



# === Brain, do not touch, pereebet! ===
while true; do
    preset_msg=""
    
    read -e -p ">>> Link: " input
    if [[ -z "$input" ]]; then continue; fi
    
    if [[ "${input,,}" == *"-exit"* || "${input,,}" == "shutup" ]]; then
        echo ">> [System] It's my final message. Goodbye..."
        break
    fi

    if [[ "${input,,}" == "-upd" ]]; then
        echo ">> [System] Updating!"
        yt-dlp -U
        continue
    fi


    # String to parts
    read -a args <<< "$input"
    TARGET_LINK=""
    FORMAT_FLAG=""
    DIR_FLAG="-D" #Note: Default dir Desktop, if you do not choose any paths
    TIME_RANGE=""


    # Parts magic
    for item in "${args[@]}"; do
        if [[ "$item" == http* || "$item" == www* || "$item" == *youtube.com* || "$item" == *youtu.be* ]]; then
            TARGET_LINK="${item%\"}" # Сразу чистим от кавычек
            TARGET_LINK="${TARGET_LINK#\"}"
        elif [[ "$item" == "-3" || "$item" == "-4" || "$item" == "-5" || "$item" == "-6" ]]; then
            FORMAT_FLAG="$item"
        elif [[ "$item" == "-D" || "$item" == "-C" || "$item" == "-M" ]]; then # D-Desktop, C-Clips, M-Music
            DIR_FLAG="$item"
        elif [[ "$item" == *:* ]]; then            
            TIME_RANGE="$item"
        fi
    done

    # Err message
    if [[ -z "$TARGET_LINK" || -z "$FORMAT_FLAG" ]]; then
        echo "[!] Err: Unknown Pleasures. Please Choose flag: [-3], [-4], [-5] or [-6], and dir"
        continue
    fi


    # Dirs call
    case "$DIR_FLAG" in
        -D) WORK_DIR="$DIR_DESKTOP" ;;
        -C) WORK_DIR="$DIR_CLIPS" ;;
        -M) WORK_DIR="$DIR_MUSIC" ;;
    esac

    # Playlist check
    if [[ "$FORMAT_FLAG" != "-6" ]]; then
        echo ">> [System] Probing link..."
        p_count=$(yt-dlp --flat-playlist --print playlist_count "$TARGET_LINK" 2>/dev/null | head -n 1)
        
        if [[ "$p_count" =~ ^[0-9]+$ ]] && [[ "$p_count" -gt 1 ]]; then
            echo ">> [System] Playlist detected! ($p_count items)."
            PLAY_FLAG="--yes-playlist"
            FINAL_PATH="${WORK_DIR}/${TPL_PLAYLIST}"
        else
            echo ">> [System] Single file detected."
            PLAY_FLAG="--no-playlist"
            FINAL_PATH="${WORK_DIR}/${TPL_SINGLE}"
        fi
    fi

    SECTION_ARGS=()                                
    [[ -n "$TIME_RANGE" && "$FORMAT_FLAG" != "-6" ]] && get_timecode "$TIME_RANGE"



    # 5. Module call
    case "$FORMAT_FLAG" in
        -3) get_mp3 "$TARGET_LINK" "$PLAY_FLAG" "$FINAL_PATH" ;;
        -4) get_mp4 "$TARGET_LINK" "$PLAY_FLAG" "$FINAL_PATH" ;;
        -5) get_flac "$TARGET_LINK" "$PLAY_FLAG" "$FINAL_PATH" ;;
        -6) get_link "$TARGET_LINK" "$WORK_DIR" ;;
    esac

    if [[ -n "$preset_msg" ]]; then
        echo "$preset_msg"
    fi
    echo "----------------------------------------------------"
done