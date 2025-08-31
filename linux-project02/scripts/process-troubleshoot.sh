#!/bin/bash
echo "🔎 Top 5 CPU-consuming processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "🔎 Top 5 memory-consuming processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
