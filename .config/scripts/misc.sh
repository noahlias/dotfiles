#!/bin/bash

view_pdf() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: view_pdf <pdf-file-path> <page-number>"
        return 1
    fi

    local pdf_file=$1
    local page_number=$2
    local total_pages=$(pdfinfo "$pdf_file" | grep 'Pages:' | awk '{print $2}')
    local page_number_length=${#total_pages}
    local tmp_dir="${TMPDIR:-/tmp}"
    local output_file_prefix="${tmp_dir}/pdf_page_$(date +%s)_$$"
    local output_file="${output_file_prefix}-%0${page_number_length}d.png"

    # echo "Temporary file will be created with prefix: ${output_file_prefix}"

    pdftoppm -png -f "${page_number}" -l "${page_number}" "${pdf_file}" "${output_file_prefix}"

    # 页码格式化为动态位数
    local formatted_page_number=$(printf "%0${page_number_length}d" "${page_number}")
    local actual_output_file="${output_file_prefix}-${formatted_page_number}.png"

    if [ -f "${actual_output_file}" ]; then
        kitty +kitten icat "${actual_output_file}"
        rm -f "${actual_output_file}" # 删除临时文件
    else
        echo "Failed to generate or find the output PNG file."
        return 2
    fi
}


history_statistics() {
	# history command statistics
	history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n 10
}

ripgrep_fzf_vim() {
#https://github.com/junegunn/fzf/blob/master/ADVANCED.md#ripgrep-integration
# 1. Search for text in files using Ripgrep
# 2. Interactively narrow down the list using fzf
# 3. Open the file in Vim
	rg --color=always --line-number --no-heading --smart-case "${*:-}" |
  fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(nvim {1} +{2})'
}



download_bilix_audio() {
    bilix get_video $1 -fb chrome -oa -nh -d ./ && rm -r videos
}

download_bilix_video(){
	bilix get_video $1 -fb chrome --image  -nh -d ./
}

yt-dlp_mp3(){
	yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 $1
}

yt-dlp_mp4(){
  yt-dlp -S ext $1
}

#fast-translate
live_stream_translate(){
 python translate_livestream.py $1 --model_size_or_path medium --task transcribe --interval 7 --threshold 0.5 --min_silence_duration_ms 2000 --word_timestamps True --history_word_size 0 --language $2	
}

function goody2(){
	local message=$1
	curl -s 'https://www.goody2.ai/send' \
  -H 'authority: www.goody2.ai' \
  -H 'origin: https://www.goody2.ai' \
  -H 'referer: https://www.goody2.ai/chat' \
  --data-raw $'{"message":"'"$message"'","debugParams":null}' \
  --compressed |  awk '/event: message/{getline; if($0 !~ /"conversation"/) print substr($0, index($0, "{\"content\":\"") + 12, length($0) - index($0, "{\"content\":\"") - 13)}' | tr -d '\n'
}

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function iplot {
    cat <<EOF | gnuplot
    set terminal pngcairo enhanced font 'Fira Sans,10'
    set autoscale
    set samples 1000
    set output '|kitten icat --stdin yes'
    set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb"#fdf6e3" behind
    plot $@
    set output '/dev/null'
EOF
}
