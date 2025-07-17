#!/usr/bin/env node

// Production deployment script for KiwiStay
import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import { spawn } from 'child_process';
import fs from 'fs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const app = express();
const PORT = process.env.PORT || 5000;

console.log('🚀 Starting KiwiStay deployment server...');

// Set production environment
process.env.NODE_ENV = 'production';

// Import and start the actual server
async function startServer() {
  try {
    // Import the server routes
    const { registerRoutes } = await import('./server/routes.js');
    
    // Set up middleware
    app.use(express.json());
    app.use(express.urlencoded({ extended: false }));
    
    // Register all routes
    const server = await registerRoutes(app);
    
    // Start the server
    server.listen(PORT, '0.0.0.0', () => {
      console.log(`✅ KiwiStay server running on port ${PORT}`);
      console.log(`🌐 Access your app at: http://localhost:${PORT}`);
    });
    
  } catch (error) {
    console.error('❌ Failed to start server:', error);
    
    // Fallback: Start with development server
    console.log('🔄 Falling back to development server...');
    
    const devServer = spawn('npx', ['tsx', 'server/index.ts'], {
      stdio: 'inherit',
      env: { ...process.env, NODE_ENV: 'development' },
      cwd: __dirname
    });
    
    devServer.on('error', (err) => {
      console.error('❌ Development server failed:', err);
      process.exit(1);
    });
  }
}

startServer();