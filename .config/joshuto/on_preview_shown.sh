#!/usr/bin/env bash

FILE_PATH="$1"			# Full path of the previewed file
PREVIEW_X_COORD="$2"		# x coordinate of upper left cell of preview area
PREVIEW_Y_COORD="$3"
PREVIEW_WIDTH="$4"		# Width of the preview pane (number of fitting characters)
PREVIEW_HEIGHT="$5"		# Height of the preview pane (number of fitting characters)
let PREVIEW_Y_COORD="$PREVIEW_HEIGHT"/5		# y coordinate of upper left cell of preview area

mkdir -p "$HOME/.cache/joshuto"
TMP_FILE="$HOME/.cache/joshuto/thumbcache.png"

mimetype=$(file --mime-type -Lb "$FILE_PATH")

function kclear {
	kitty +kitten icat \
		--transfer-mode=file \
		--clear 2>/dev/null
}

function image {
	kclear
	kitty +kitten icat \
		--transfer-mode=file \
		--place "${PREVIEW_WIDTH}x${PREVIEW_HEIGHT}@${PREVIEW_X_COORD}x${PREVIEW_Y_COORD}" \
		"$1" 2>/dev/null
}

case "$mimetype" in
	image/*)
		thumbnail="$(allmytoes -sx "$FILE_PATH" 2>/dev/null)"
		if [ "$thumbnail" ]; then
			image "${thumbnail}"
		else
			kclear
		fi
		;;
	video/*)
		kclear
		ffmpegthumbnailer -i "$FILE_PATH" -f -m -c png -s 0 -o - 2>/dev/null | \
			kitty +kitten icat --transfer-mode=stream --place \
			"${PREVIEW_WIDTH}x${PREVIEW_HEIGHT}@${PREVIEW_X_COORD}x${PREVIEW_Y_COORD}"
		;;
	*)
		kclear
		;;
esac
