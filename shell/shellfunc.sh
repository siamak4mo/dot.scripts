# my shell functions
# usage:
#   add the following line to your ~/.[your shell]rc file
#   `source /path/to/shellfunc.sh`

#--------#
# FFmpeg #
#--------#

# to eliminate metadata
# usage:
#         ffmeta file.ogg out.ogg
function ffmeta(){
    ffmpeg -i $1 -map_metadata -1 -c:v copy $2
}

# voice conversion (no video)
# usage:
#         ffogg file.mp3      -> output: file.ogg
#         ffogg file.mp3 webm -> output: file.webm
function ffogg(){
    ffmpeg -i $1 -vn ${1%.*}$([ -z "$2" ] && echo ".ogg" || echo ".$2")
}

# make the input audio file free!
# metadata elimination and converting to ogg format
# usage:
#         fffree file.mp3     -> output: file.ogg
function fffree(){
    local _tmpfile="/tmp/FF_FREE_OUT.${1##*.}"
    local _tmpogg="/tmp/FF_FREE_OUT.ogg"

    ffmeta "$1" "$_tmpfile" && ffogg "$_tmpfile"
    rm -f "$_tmpfile"

    [[ -s "$_tmpogg" ]] && mv "$_tmpogg" "${1%.*}.ogg"
}