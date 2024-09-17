#!/bin/sh

# Find the PID of wl-screenrec
pid=$(pgrep wl-screenrec)

# Check if the PID is found
if [ -n "$pid" ]; then
  # Send SIGINT to gracefully stop wl-screenrec
  kill -INT "$pid"
  echo "Terminated wl-screenrec with PID $pid"
else
  echo "No wl-screenrec process found."
fi
