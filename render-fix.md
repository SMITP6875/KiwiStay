# Fix Render Deployment Error

## Problem: "vite: not found" Error
The build is failing because Vite isn't installed during the build process.

## Solution: Update Build Command

Change your Render build settings to:
```
Build Command: npm install && npm run build
Start Command: npm start
```

Or use this alternative build command:
```
Build Command: npm ci && npm run build
```

## Alternative: Use the render-build.js Script

If the above doesn't work, try this custom build script:

1. In Render, set Build Command to: `node render-build.js`
2. Set Start Command to: `npm start`

## Node.js Version
Make sure Render is using Node.js 18 or higher:
- In Render dashboard, go to Environment
- Add: `NODE_VERSION=18`

## Complete Fix Steps:

1. **Update Build Command**: `npm install && npm run build`
2. **Keep Start Command**: `npm start`
3. **Add Node Version**: `NODE_VERSION=18` in environment variables
4. **Redeploy**: Click "Manual Deploy" in Render dashboard

This should resolve the "vite: not found" error.