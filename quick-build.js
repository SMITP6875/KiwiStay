#!/usr/bin/env node

// Quick build script for deployment
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

console.log('🚀 Creating quick deployment build...');

// Create dist directory
const distDir = path.join(__dirname, 'dist');
if (!fs.existsSync(distDir)) {
  fs.mkdirSync(distDir, { recursive: true });
}

// Create a simple production server that serves the development build
const prodServer = `
// Quick production server for KiwiStay
import { spawn } from 'child_process';
import { fileURLToPath } from 'url';
import path from 'path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.join(__dirname, '..');

console.log('🌟 Starting KiwiStay production server...');
console.log('📁 Root directory:', rootDir);

// Force development mode for stability
process.env.NODE_ENV = 'development';

const serverPath = path.join(rootDir, 'server', 'index.ts');
console.log('🔧 Starting server from:', serverPath);

const server = spawn('npx', ['tsx', serverPath], {
  stdio: 'inherit',
  env: { ...process.env, NODE_ENV: 'development' },
  cwd: rootDir
});

server.on('error', (err) => {
  console.error('❌ Server failed to start:', err);
  
  // Try alternative startup method
  console.log('🔄 Trying alternative startup...');
  const altServer = spawn('node', ['-r', 'tsx/esm', serverPath], {
    stdio: 'inherit',
    env: { ...process.env, NODE_ENV: 'development' },
    cwd: rootDir
  });
  
  altServer.on('error', (altErr) => {
    console.error('❌ Alternative startup failed:', altErr);
    process.exit(1);
  });
});

server.on('exit', (code) => {
  if (code !== 0) {
    console.log('Server exited with code:', code);
    console.log('🔄 Attempting restart...');
    
    // Restart the server
    setTimeout(() => {
      const restartServer = spawn('npx', ['tsx', serverPath], {
        stdio: 'inherit',
        env: { ...process.env, NODE_ENV: 'development' },
        cwd: rootDir
      });
    }, 1000);
  }
});

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('📴 Shutting down gracefully...');
  server.kill('SIGINT');
});

process.on('SIGTERM', () => {
  console.log('📴 Shutting down gracefully...');
  server.kill('SIGTERM');
});
`;

fs.writeFileSync(path.join(distDir, 'index.js'), prodServer);

// Create package.json for production
const prodPackage = {
  "type": "module",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  }
};

fs.writeFileSync(path.join(distDir, 'package.json'), JSON.stringify(prodPackage, null, 2));

console.log('✅ Quick build complete!');
console.log('📦 Production files created in dist/');
console.log('🎯 Ready for deployment!');