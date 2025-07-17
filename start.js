#!/usr/bin/env node

const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

// Check if we're in production and if build files exist
const isProduction = process.env.NODE_ENV === 'production';
const buildPath = path.join(__dirname, 'dist');
const buildExists = fs.existsSync(buildPath);

console.log(`Environment: ${process.env.NODE_ENV || 'undefined'}`);
console.log(`Build path exists: ${buildExists}`);

if (isProduction && buildExists) {
  console.log('Starting in production mode...');
  const prodProcess = spawn('node', ['dist/index.js'], {
    stdio: 'inherit',
    env: { ...process.env, NODE_ENV: 'production' }
  });
  
  prodProcess.on('error', (err) => {
    console.error('Production server failed:', err);
    console.log('Falling back to development mode...');
    startDevelopment();
  });
  
  prodProcess.on('exit', (code) => {
    if (code !== 0) {
      console.log('Production server exited with error, falling back to development mode...');
      startDevelopment();
    }
  });
} else {
  console.log('Starting in development mode...');
  startDevelopment();
}

function startDevelopment() {
  const devProcess = spawn('npx', ['tsx', 'server/index.ts'], {
    stdio: 'inherit',
    env: { ...process.env, NODE_ENV: 'development' }
  });
  
  devProcess.on('error', (err) => {
    console.error('Development server failed:', err);
    process.exit(1);
  });
  
  devProcess.on('exit', (code) => {
    process.exit(code);
  });
}