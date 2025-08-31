#!/bin/bash
URL=${1:-"https://google.com"}
echo "🌐 Testing latency for $URL"
time curl -o /dev/null -s -w "✅ Response code: %{http_code} | Time: %{time_total}s\n" $URL
