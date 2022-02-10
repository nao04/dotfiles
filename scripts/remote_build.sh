#!/usr/bin/env bash

# Functions
function tg_msg {
	curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendMessage -d chat_id=$TG_ID \
	-d "disable_web_page_preview=true" \
	-d "disable_notification=true" \
	-d "parse_mode=html" \
	-d text="$1"
}

function tg_sticker {
	curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendSticker -d chat_id=$TG_ID \
	-d "disable_web_page_preview=true" \
	-d "disable_notification=true" \
	-d "parse_mode=html" \
	-d sticker="$1"
}

function tg_file {
	curl -s -X POST https://api.telegram.org/bot$TG_TOKEN/sendDocument -F chat_id=$TG_ID \
	-F "disable_web_page_preview=true" \
	-F "disable_notification=true" \
	-F "parse_mode=html" \
	-F document=@"$1" \
	-F caption="$2"
}

function tg_cast {
tg_msg \
"<b>Compilation initialized</b>
<b>Host</b>: <code>$(uname)</code>
<b>Kernel</b>: <code>$KERNEL</code>
<b>Version</b>: <code>$VERSION</code>
<b>LTS tag</b>: <code>$(make kernelversion)</code>
<b>Compiler</b>: <code>$CC</code>
<b>HEAD</b>: <code>$(git log --oneline -1)</code>"
}

function success {
	tg_file $ANYKERNEL/*.zip "Compilation finished!"
	tg_sticker "CAACAgIAAxkBAAFh3MdiAcOwVLT_M0PQopc5XMeV7qRYpwACPwIAApPp0xVhfsrxRHKTcCME"
	exit 0
}

function fail {
	tg_msg "Compilation failed on $1!"
	tg_sticker "CAACAgEAAxkBAAFh3MtiAcQGRbTCc0SqX_OWgup-R1FBLwACGQAD1xiAIQ82b0HScxLhIwQ"
	exit 1
}
