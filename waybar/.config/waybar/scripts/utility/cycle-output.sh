#!/bin/bash

# Define the two sinks (output devices)
SINK_1="alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3"
SINK_2="alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo"

# Get the current default sink
CURRENT_SINK=$(pactl info | grep "Default Sink" | cut -d ' ' -f 3)

# Check if the current default sink is SINK_1 and switch to SINK_2, or vice versa
if [ "$CURRENT_SINK" == "$SINK_1" ]; then
    pactl set-default-sink $SINK_2
    pkill -SIGRTMIN+13 waybar
else
    pactl set-default-sink $SINK_1
    pkill -SIGRTMIN+13 waybar
fi
