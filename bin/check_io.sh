
#!/bin/bash

IOSTAT="$(iostat -g ALL | grep ALL)"
DATETIME="$(date --iso-8601=minutes)"
IOSTAT_TPS="$(echo ${IOSTAT} | awk '{print $2}')"
IOSTAT_READ="$(echo ${IOSTAT} | awk '{print $3}')"
IOSTAT_WRITE="$(echo ${IOSTAT} | awk '{print $4}')"

echo "${DATETIME} io.tps=${IOSTAT_TPS} io.read=${IOSTAT_READ} io.write=${IOSTAT_WRITE}"

