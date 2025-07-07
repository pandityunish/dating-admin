#!/bin/bash
# Find all TextField widgets without cursorColor set
grep -r "TextField(" --include="*.dart" . | grep -v "cursorColor"
