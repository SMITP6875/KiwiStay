# KiwiStay Deployment Guide

## Platform Options for Full-Stack Node.js Apps

Since Replit deployment is having issues and Netlify only supports static sites, here are the best alternatives for your full-stack application:

## 1. 🌟 **Render** (Recommended - Free Tier Available)

### Why Render is Perfect for KiwiStay:
- **Full-stack support**: Perfect for Node.js + React applications
- **Free tier**: Great for testing and small projects
- **PostgreSQL support**: Built-in database options
- **Auto-deploy**: Connects to GitHub for automatic deployments
- **Environment variables**: Easy secret management

### Render Deployment Steps:

1. **Push to GitHub**:
   ```bash
   git add .
   git commit -m "Deploy to Render"
   git push origin main
   ```

2. **Create Render Account**:
   - Go to [render.com](https://render.com)
   - Sign up with GitHub

3. **Create Web Service**:
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Choose your KiwiStay repository

4. **Configure Build Settings**:
   - **Build Command**: `npm run build`
   - **Start Command**: `npm start`
   - **Environment**: `Node`

5. **Add Environment Variables**:
   - DATABASE_URL (your Supabase URL)
   - JWT_SECRET (any random string)
   - All your other secrets

6. **Deploy**: Click "Create Web Service"

### Render-specific files (already created):
- `render.yaml` (optional but recommended)
- `package.json` scripts are already configured

## 2. 🚀 **Railway** (Excellent for Node.js)

### Why Railway is Great:
- **One-click deployment**: Very simple setup
- **Database included**: PostgreSQL with one click
- **Fair pricing**: Pay only for what you use
- **Fast deployment**: Usually under 2 minutes

### Railway Deployment Steps:

1. **Install Railway CLI**:
   ```bash
   npm install -g @railway/cli
   ```

2. **Login and Deploy**:
   ```bash
   railway login
   railway up
   ```

3. **Add Environment Variables**:
   - Use Railway dashboard to add secrets
   - Add DATABASE_URL and other environment variables

## 3. 🔥 **Vercel** (Great for Full-Stack)

### Why Vercel Works Well:
- **Full-stack support**: Perfect for Node.js APIs
- **Easy deployment**: Connect GitHub repository
- **Global CDN**: Fast worldwide access
- **Free tier**: Generous limits

### Vercel Deployment Steps:

1. **Install Vercel CLI**:
   ```bash
   npm install -g vercel
   ```

2. **Deploy**:
   ```bash
   vercel --prod
   ```

3. **Or use GitHub Integration**:
   - Go to [vercel.com](https://vercel.com)
   - Import your GitHub repository
   - Configure environment variables

## 4. 🌐 **Heroku** (Classic Choice)

### Why Heroku Still Works:
- **Mature platform**: Very stable
- **Add-ons**: Easy database and service integration
- **Documentation**: Excellent guides
- **Buildpacks**: Automatic Node.js detection

### Heroku Deployment Steps:

1. **Install Heroku CLI**:
   ```bash
   # Install from heroku.com/cli
   ```

2. **Login and Create App**:
   ```bash
   heroku login
   heroku create your-app-name
   ```

3. **Configure Environment Variables**:
   ```bash
   heroku config:set DATABASE_URL=your-supabase-url
   heroku config:set JWT_SECRET=your-secret
   ```

4. **Deploy**:
   ```bash
   git add .
   git commit -m "Deploy to Heroku"
   git push heroku main
   ```

## 5. 💎 **Digital Ocean App Platform**

### Why Digital Ocean is Reliable:
- **Professional platform**: Enterprise-grade
- **Competitive pricing**: Good value
- **Database options**: Managed PostgreSQL
- **Monitoring**: Built-in analytics

### Digital Ocean Deployment Steps:

1. **Create Account**: Go to [digitalocean.com](https://digitalocean.com)
2. **Create App**: Use "App Platform"
3. **Connect GitHub**: Link your repository
4. **Configure Settings**: Set build and run commands
5. **Add Environment Variables**: Use their dashboard

## Quick Setup Commands

### For Render/Railway/Vercel:
```bash
# Make sure your code is ready
npm run build

# Test production build locally
npm start
```

### Environment Variables You'll Need:
```
DATABASE_URL=your-supabase-connection-string
JWT_SECRET=your-random-secret-key
VITE_SUPABASE_URL=your-supabase-url
VITE_SUPABASE_ANON_KEY=your-supabase-anon-key
SUPABASE_SERVICE_KEY=your-supabase-service-key
```

## Recommended Deployment Order:

1. **Try Render first** (easiest, free tier)
2. **Railway as backup** (very reliable)
3. **Vercel for speed** (if you need global CDN)
4. **Heroku for stability** (if budget allows)

## Why Netlify Doesn't Work:

Netlify only supports static sites and serverless functions. Your KiwiStay app needs:
- Full Node.js server
- Database connections
- WebSocket support
- Session management

These require a full server environment, not just static hosting.

## Next Steps:

1. Choose a platform (Render recommended)
2. Push your code to GitHub
3. Follow the platform-specific steps above
4. Add your environment variables
5. Deploy and test!

Would you like me to help you with any specific platform setup?