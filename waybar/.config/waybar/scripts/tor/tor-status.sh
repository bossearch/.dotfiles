#!/bin/sh

if systemctl is-active --quiet tor; then
  echo "{\"class\": \"active\", \"text\": \"\"}"
  exit
else
  echo "{\"class\": \"inactive\", \"text\": \"\"}"
  exit
fi
