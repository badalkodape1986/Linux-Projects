#!/bin/bash
DIR=${1:-"/etc"}
BASELINE="baseline.md5"
if [ ! -f $BASELINE ]; then
  echo "📥 Creating baseline checksum for $DIR..."
  find $DIR -type f -exec md5sum {} \; > $BASELINE
  echo "✅ Baseline saved to $BASELINE"
else
  echo "🔎 Comparing current state of $DIR with baseline..."
  md5sum -c $BASELINE | grep -E "FAILED|changed"
fi
