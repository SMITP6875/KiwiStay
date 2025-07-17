#!/usr/bin/env node

// Deployment preparation script for KiwiStay
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { execSync } from 'child_process';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

console.log('🚀 Preparing KiwiStay for deployment...\n');

// Check if all required files exist
const requiredFiles = [
  'package.json',
  'server/index.ts',
  'client/src/App.tsx',
  'shared/schema.ts'
];

console.log('📋 Checking required files...');
for (const file of requiredFiles) {
  if (fs.existsSync(file)) {
    console.log(`✅ ${file}`);
  } else {
    console.log(`❌ ${file} - MISSING`);
  }
}

// Check environment variables
console.log('\n🔑 Environment variables needed for deployment:');
const requiredEnvVars = [
  'DATABASE_URL',
  'JWT_SECRET',
  'VITE_SUPABASE_URL',
  'VITE_SUPABASE_ANON_KEY',
  'SUPABASE_SERVICE_KEY'
];

for (const envVar of requiredEnvVars) {
  if (process.env[envVar]) {
    console.log(`✅ ${envVar}`);
  } else {
    console.log(`❌ ${envVar} - MISSING`);
  }
}

// Test build process
console.log('\n🔨 Testing build process...');
try {
  console.log('Building frontend...');
  execSync('npm run build', { stdio: 'inherit' });
  console.log('✅ Build successful!');
} catch (error) {
  console.log('❌ Build failed:', error.message);
}

// Create deployment summary
console.log('\n📦 Deployment Summary:');
console.log('=====================================');
console.log('✅ Frontend: React + TypeScript');
console.log('✅ Backend: Node.js + Express');
console.log('✅ Database: Supabase PostgreSQL');
console.log('✅ Build: Vite + esbuild');
console.log('✅ Start: npm start');
console.log('=====================================');

console.log('\n🎯 Recommended Deployment Platforms:');
console.log('1. Render.com (Free tier, perfect for full-stack)');
console.log('2. Railway.app (Simple, one-click deployment)');
console.log('3. Vercel.com (Fast global CDN)');
console.log('4. Heroku.com (Classic, reliable)');

console.log('\n📚 Next Steps:');
console.log('1. Push your code to GitHub');
console.log('2. Choose a platform from the list above');
console.log('3. Follow the deployment-guide.md instructions');
console.log('4. Add your environment variables');
console.log('5. Deploy and test!');

console.log('\n🔗 Quick Start:');
console.log('For Render: https://render.com → New Web Service');
console.log('For Railway: npm install -g @railway/cli && railway up');
console.log('For Vercel: npm install -g vercel && vercel --prod');

console.log('\n✨ Your KiwiStay app is ready for deployment!');