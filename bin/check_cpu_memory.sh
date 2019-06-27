#!/bin/bash

LOAD_USAGE="$(cat /proc/loadavg)"
CPU_USAGE="$(vmstat 1 2 -S M -a|tail -1)"
MEM_USAGE="$(free -m| grep -i mem:)"


MEM_TOTAL="$(echo ${MEM_USAGE} | awk '{print $2}')"
MEM_FREE="$(echo ${MEM_USAGE} | awk '{print $4}')"

MEM_USEDPCT=$(echo $MEM_TOTAL $MEM_FREE | awk '{printf "%4.2f", ($1-$2)/$1}')
CPU_LOAD="$(echo ${LOAD_USAGE} | awk '{print $2}')"
CPU_USER="$(echo ${CPU_USAGE} | awk '{print $13}')"
CPU_SYSTEM="$(echo ${CPU_USAGE} | awk '{print $14}')"
CPU_IDLE="$(echo ${CPU_USAGE} | awk '{print $15}')"
CPU_IOWAIT="$(echo ${CPU_USAGE} | awk '{print $16}')"
CPU_ST="$(echo ${CPU_USAGE} | awk '{print $17}')"
CPU_TOTAL=$((CPU_USER+CPU_SYSTEM+CPU_IOWAIT+CPU_ST))
DATETIME="$(date --iso-8601=minutes)"

echo "${DATETIME} memory.total=${MEM_TOTAL} memory.free=${MEM_FREE} memory.freepct=${MEM_USEDPCT} cpu.total=${CPU_TOTAL} cpu.user=${CPU_USER} cpu.system=${CPU_SYSTEM} cpu.idle=${CPU_IDLE} cpu.iowait=${CPU_IOWAIT} cpu.stolen=${CPU_ST} cpu.load=${CPU_LOAD}"
