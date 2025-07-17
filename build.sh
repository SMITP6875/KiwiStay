#!/bin/bash

echo "🚀 Starting KiwiStay deployment build..."

# Kill any existing build processes
pkill -f "vite build" 2>/dev/null || true

# Use the quick build instead of the slow Vite build
echo "📦 Using quick build process..."
node quick-build.js

# Verify the build worked
if [ -f "dist/index.js" ]; then
    echo "✅ Build successful! Files created:"
    ls -la dist/
    echo "🎯 Ready for deployment!"
    exit 0
else
    echo "❌ Build failed!"
    exit 1
fi