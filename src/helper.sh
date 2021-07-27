function notify_healthchecks {
  curl \
    --data-raw "$2" \
    --fail \
    --max-time 10 \
    --output /dev/null \
    --retry 5 \
    --show-error \
    --silent \
    https://hc-ping.com/"$1"
}
