#!/bin/bash

# Get the PID of wvkbd

pkill wvkbd-mobintl || wvkbd-mobintl -L 200
