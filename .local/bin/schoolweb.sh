#!/usr/bin/env bash

# Temporary set rule to open firefox on desktop 2
bspc rule --add firefox desktop=3 follow=on
firefox -P skole &
sleep 0.25
# Revert temporary rule
bspc rule --add firefox desktop=2 follow=on
