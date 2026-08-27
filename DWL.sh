#!/bin/bash

# Переходим в папку со скриптом
cd "$(dirname "$0")"

# Меняем заголовок вкладки терминала
echo -ne "\033]30;Download Hub\007"

# Выплевываем стартовое меню
echo "======================= Ultimate Devil Download ======================="
echo "Format: [Link] [Flag] (For example: https://youtu.be/... -4)"
echo ""
echo "Are you gonna make the right choice?"
echo "[-3] = MP3"
echo "[-4] = MP4"
echo "[-5] = FLAC"
echo "[-6] = Link"
echo ""
echo "[-exit] = Exit"
echo "======================================================================="

# Общие флаги и пути
COOKIES="firefox:$HOME/.var/app/net.waterfox.waterfox/.waterfox/8ivjcj1i.OwlUSR"
OUT_PATH="$HOME/Desktop/%(playlist_title,title)s/%(playlist_index&{} - |)s%(title)s.%(ext)s"
ARIA_ARGS="aria2c:-c -x 16 -s 16 -k 1M"

# 1. Модуль для MP3
get_mp3() {
    local target_link="$1"
    echo ">> [MP3] Downloading Audio, Please Wait..."
    
    yt-dlp --cookies-from-browser "$COOKIES" --js-runtimes node \
           --downloader aria2c --downloader-args "$ARIA_ARGS" \
           --no-playlist -f "ba/b" -x --audio-format mp3 --audio-quality 0 \
           --embed-metadata --embed-thumbnail \
           --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -id3v2_version 3" \
           --no-check-certificate -o "$OUT_PATH" "$target_link"
           
    preset_msg="[OK] Ready. Bon Appetit Mon Ami."
}

# 2. Модуль для MP4
get_mp4() {
    local target_link="$1"
    echo ">> [MP4] Downloading Video, Please Wait..."
    
    yt-dlp --cookies-from-browser "$COOKIES" --js-runtimes node \
           --downloader aria2c --downloader-args "$ARIA_ARGS" \
           --no-playlist -S "ext:mp4:m4a" --remux-video mp4 \
           --embed-metadata --embed-thumbnail \
           --no-check-certificate -o "$OUT_PATH" "$target_link"
           
    preset_msg="[OK] Ready. Bon Appetit Mon Ami."
}

# 3. Модуль для Прямого скачивания тяжелых файлов (Aria2c соло)
get_link() {
    local target_link="$1"
    echo ">> [Link] The Think On Link, Please Wait"
    
    # Качаем напрямую на рабочий стол средствами чистой арии
    aria2c -c -x 16 -s 16 -k 1M -d "$HOME/Desktop" "$target_link"
    
    preset_msg="[OK] Ready. Bon Appetit Mon Ami."
}

# 4. Модуль для FLAC (Исправленный под нативные теги)
get_flac() {
    local target_link="$1"
    echo ">> [FLAC] Hi-Fi Audio Downloading, Please Wait..."
    
    yt-dlp --cookies-from-browser "$COOKIES" --js-runtimes node \
           --downloader aria2c --downloader-args "$ARIA_ARGS" \
           --no-playlist -f "ba/b" -x --audio-format flac \
           --embed-metadata --embed-thumbnail \
           --no-check-certificate -o "$OUT_PATH" "$target_link"
           
    preset_msg="[OK] Ready. Bon Appetit Mon Ami."
}

# --- Мозги, не трогать, переебет! ---
while true; do
    preset_msg=""

    read -e -p ">>> Link: " input
    input=$(echo "$input" | xargs)
    if [[ -z "$input" ]]; then continue; fi
    
    # Кнопка паники и выхода
    if [[ "${input,,}" == *"-exit"* || "${input,,}" == "shutup" ]]; then
        echo "Its my final message. Goodbye..."
        break
    fi

    # Разделяем строку на флаг и ссылку
    flag="${input##* }"
    link="${input% *}"

    link="${link%\"}"
    link="${link#\"}"

    # Значения по умолчанию (Одиночный файл)
    PLAYLIST_FLAG="--no-playlist"
    OUT_PATH="$HOME/Desktop/%(title)s.%(ext)s"

    # Прозваниваем только если это запросы к yt-dlp (-3, -4, -5)
    if [[ "$flag" == "-3" || "$flag" == "-4" || "$flag" == "-5" ]]; then
        echo ">> [System] Probing link..."
        
        # Запрашиваем количество элементов (2>/dev/null глушит лишние ошибки, чтобы терминал был чистым)
        p_count=$(yt-dlp --flat-playlist --print playlist_count "$link" 2>/dev/null | head -n 1)
        
        # Регулярное выражение ^[0-9]+$ проверяет, что ответ состоит только из цифр.
        # -gt 1 проверяет, что цифра больше единицы.
        if [[ "$p_count" =~ ^[0-9]+$ ]] && [[ "$p_count" -gt 1 ]]; then
            echo ">> [System] Playlist detected! ($p_count items). Creating directory..."
            # Переключаем реле на плейлист
            PLAYLIST_FLAG="--yes-playlist"
            # Формируем путь с папкой (название плейлиста) и нумерацией
            OUT_PATH="$HOME/Desktop/%(playlist_title)s/%(playlist_index)02d - %(title)s.%(ext)s"
        else
            echo ">> [System] Single file detected."
        fi
    fi
    # ---------------------------------------------------------

    # Распределительный щит модулей (передаем новые переменные внутрь)
    case "$flag" in
        -3) get_mp3 "$link" "$PLAYLIST_FLAG" "$OUT_PATH" ;;
        -4) get_mp4 "$link" "$PLAYLIST_FLAG" "$OUT_PATH" ;;
        -5) get_flac "$link" "$PLAYLIST_FLAG" "$OUT_PATH" ;;
        -6) get_link "$link" ;;
         *)
            echo "[!] Err: Unknown Pleasures. Please Choose: [-3], [-4], [-5] or [-6]."
            continue
            ;;
    esac

    # Разрядка буфера отложенных сообщений
    if [[ -n "$preset_msg" ]]; then
        echo "$preset_msg"
    fi
    
    echo "----------------------------------------------------"
done