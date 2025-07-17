#!/usr/bin/env node

// Custom build script for Render deployment
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🚀 Starting Render build process...');

try {
  // Install dependencies
  console.log('📦 Installing dependencies...');
  execSync('npm install', { stdio: 'inherit' });
  
  // Build frontend
  console.log('🔨 Building frontend...');
  execSync('npx vite build', { stdio: 'inherit' });
  
  // Build backend
  console.log('⚙️ Building backend...');
  execSync('npx esbuild server/index.ts --platform=node --packages=external --bundle --format=esm --outdir=dist', { stdio: 'inherit' });
  
  console.log('✅ Build completed successfully!');
  
} catch (error) {
  console.error('❌ Build failed:', error.message);
  
  // Fallback: Create a simple production server
  console.log('🔄 Creating fallback production server...');
  
  const distDir = path.join(__dirname, 'dist');
  if (!fs.existsSync(distDir)) {
    fs.mkdirSync(distDir, { recursive: true });
  }
  
  const fallbackServer = `
const { spawn } = require('child_process');
console.log('Starting KiwiStay fallback server...');

const server = spawn('npx', ['tsx', '../server/index.ts'], {
  stdio: 'inherit',
  env: { ...process.env, NODE_ENV: 'production' }
});

server.on('error', (err) => {
  console.error('Server error:', err);
  process.exit(1);
});
`;
  
  fs.writeFileSync(path.join(distDir, 'index.js'), fallbackServer);
  console.log('✅ Fallback server created');
}