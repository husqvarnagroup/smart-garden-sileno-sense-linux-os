#!/bin/sh

LOGFILE="/run/expose-eeprom.log"
EEPROM_SYSFS="/sys/bus/i2c/devices/6-0050/eeprom"
EEPROM_COPY="/run/eeprom_cam0"
VIDEO_DEV="/dev/video0"

echo "[ $(date) ] Starting expose_eeprom.sh" >> "$LOGFILE"

# Wait up to 30s for /dev/video0
i=0
while [ ! -e "$VIDEO_DEV" ] && [ $i -lt 30 ]; do
    echo "[ $(date) ] Waiting for $VIDEO_DEV..." >> "$LOGFILE"
    sleep 1
    i=$((i + 1))
done

if [ ! -e "$VIDEO_DEV" ]; then
    echo "[ $(date) ] ERROR: $VIDEO_DEV not found after 30s" >> "$LOGFILE"
    exit 1
fi

echo "[ $(date) ] $VIDEO_DEV is present" >> "$LOGFILE"

# Wait up to 30s for EEPROM file
i=0
while [ ! -r "$EEPROM_SYSFS" ] && [ $i -lt 30 ]; do
    echo "[ $(date) ] Waiting for EEPROM at $EEPROM_SYSFS..." >> "$LOGFILE"
    sleep 1
    i=$((i + 1))
done

if [ ! -r "$EEPROM_SYSFS" ]; then
    echo "[ $(date) ] ERROR: EEPROM not readable after 30s" >> "$LOGFILE"
    exit 1
fi

# Copy EEPROM to /run
echo "[ $(date) ] EEPROM found — copying to $EEPROM_COPY" >> "$LOGFILE"
cat "$EEPROM_SYSFS" > "$EEPROM_COPY"
chown root:gardena "$EEPROM_COPY"
chmod 644 "$EEPROM_COPY"
echo "[ $(date) ] EEPROM expose complete" >> "$LOGFILE"
