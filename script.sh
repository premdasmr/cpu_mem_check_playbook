#!/bin/bash
TMPFILE=/tmp/cpu_mem_stat.sh.tmp
timeout 2 top -bc > $TMPFILE
CPU_USAGE=$(grep -A10000 'PID USER' $TMPFILE | tail -n+2 | awk '{sum+=$9} END {print sum}' | cut -d '.' -f1 )
	MEM_USAGE=$(grep -A10000 'PID USER' $TMPFILE | tail -n+2 | awk '{sum+=$10} END {print sum}' | cut -d '.' -f1)
if [[ "$CPU_USAGE" -gt 30 && "$MEM_USAGE" -gt 50 ]] ; then
        echo "ALERT: CPU USAGE is $CPU_USAGE and MEMORY USAGE is $MEM_USAGE"
fi
