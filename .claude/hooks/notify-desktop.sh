#!/usr/bin/env bash
# 공통 데스크톱 알림 발사기 (훅 진입점이 아니라 다른 훅이 호출하는 유틸).
# 사용법: notify-desktop.sh <kind> <title> <body>
#   kind: done(작업 완료) | attention(응답 필요) | escalate(미확인이 길어져 격상)
#
# 의도: 플랫폼별 알림 수단을 한곳에 모아 호출부가 종류만 고르게 한다.
# 알림 실패가 훅을 깨뜨리면 안 되므로 어떤 경로로 끝나도 exit 0을 유지한다.
#
# 소리 구분: 세 종류가 서로 다른 소리를 쓴다. 여러 창을 동시에 볼 때
# "끝난 건지 답을 해야 하는 건지"를 화면을 보지 않고 구분하기 위한 것이고,
# escalate는 여러 번 놓친 뒤에만 울리므로 가장 길고 강한 소리를 쓴다.

set -u

kind="${1:-done}"
title="${2:-Claude Code}"
body="${3:-}"

[ "${CLAUDE_NOTIFY_DISABLE:-0}" = "1" ] && exit 0

# 본문이 길면 토스트가 잘리므로 미리 줄인다.
if [ "${#body}" -gt 180 ]; then
  body="${body:0:177}..."
fi

case "$kind" in
  escalate)  win_sound="Ring06.wav" ;;
  attention) win_sound="Alarm03.wav" ;;
  *)         win_sound="tada.wav" ;;
esac

# PowerShell 리터럴에 넣기 위해 작은따옴표를 이스케이프한다.
ps_escape() { printf '%s' "$1" | sed "s/'/''/g"; }

notify_windows() {
  local pwsh
  pwsh=$(command -v powershell.exe 2>/dev/null) || pwsh=""
  [ -n "$pwsh" ] || pwsh="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
  [ -x "$pwsh" ] || return 1

  local t b s script enc
  t=$(ps_escape "$title"); b=$(ps_escape "$body"); s=$(ps_escape "$win_sound")
  script=$(cat <<PSEOF
\$ErrorActionPreference='SilentlyContinue'
\$player = New-Object Media.SoundPlayer ('C:\\Windows\\Media\\' + '$s')
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
\$tpl=[Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
\$n=\$tpl.GetElementsByTagName('text')
\$n.Item(0).AppendChild(\$tpl.CreateTextNode('$t')) | Out-Null
\$n.Item(1).AppendChild(\$tpl.CreateTextNode('$b')) | Out-Null
\$app='{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\\WindowsPowerShell\\v1.0\\powershell.exe'
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier(\$app).Show([Windows.UI.Notifications.ToastNotification]::new(\$tpl))
# 토스트를 먼저 띄우고 소리는 끝까지 재생한다. Play()로 비동기 재생하면
# PowerShell이 먼저 끝나면서 긴 소리가 중간에 잘린다.
\$player.PlaySync()
PSEOF
)
  # 한글이 깨지지 않도록 UTF-16LE + base64로 넘긴다.
  enc=$(printf '%s' "$script" | iconv -f UTF-8 -t UTF-16LE 2>/dev/null | base64 -w0 2>/dev/null) || return 1
  [ -n "$enc" ] || return 1
  "$pwsh" -NoProfile -NonInteractive -EncodedCommand "$enc" >/dev/null 2>&1
  return 0
}

notify_macos() {
  command -v osascript >/dev/null 2>&1 || return 1
  local t b
  t=$(printf '%s' "$title" | sed 's/"/\\"/g')
  b=$(printf '%s' "$body" | sed 's/"/\\"/g')
  osascript -e "display notification \"$b\" with title \"$t\"" >/dev/null 2>&1
  if command -v afplay >/dev/null 2>&1; then
    case "$kind" in
      escalate)  afplay /System/Library/Sounds/Basso.aiff  >/dev/null 2>&1 & ;;
      attention) afplay /System/Library/Sounds/Sosumi.aiff >/dev/null 2>&1 & ;;
      *)         afplay /System/Library/Sounds/Glass.aiff  >/dev/null 2>&1 & ;;
    esac
  fi
  return 0
}

notify_linux() {
  command -v notify-send >/dev/null 2>&1 || return 1
  local urgency=normal
  case "$kind" in attention|escalate) urgency=critical ;; esac
  notify-send -u "$urgency" "$title" "$body" >/dev/null 2>&1
  if command -v paplay >/dev/null 2>&1; then
    paplay /usr/share/sounds/freedesktop/stereo/message.oga >/dev/null 2>&1 &
  fi
  return 0
}

sent=0
if grep -qi microsoft /proc/version 2>/dev/null; then
  notify_windows && sent=1
elif [ "$(uname -s 2>/dev/null)" = "Darwin" ]; then
  notify_macos && sent=1
else
  notify_linux && sent=1
fi

# 어떤 수단도 없으면 최소한 터미널 벨이라도 울린다.
[ "$sent" = "1" ] || printf '\a' >/dev/tty 2>/dev/null

exit 0
