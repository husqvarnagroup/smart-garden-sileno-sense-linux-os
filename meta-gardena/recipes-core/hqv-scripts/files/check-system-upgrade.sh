#! /bin/sh

curr_part=$(fw_printenv -n mmcpartition 2>/dev/null)
prev_part=$(fw_printenv -n prev_mmcpartition 2>/dev/null)
upgrade_available=$(fw_printenv -n upgrade_available 2>/dev/null)

if [ -n "$upgrade_available" ] && [ "$upgrade_available" -eq 1 ]; then
    if [ -n "$prev_part" ] && [ "$curr_part" -eq "$prev_part" ]; then
        echo "Error: current and previous partitions are the same!"
        echo "FAIL" > /home/gardena/os-upgrade-status
    else
        echo "Successful upgrade from partition ${prev_part} to ${curr_part}"
        echo "SUCCESS" > /home/gardena/os-upgrade-status
    fi

    # Clear upgrade flag and bootcount
    fw_setenv upgrade_available 0
    fw_setenv bootcount 0
fi
