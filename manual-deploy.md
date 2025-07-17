# Manual Deployment Guide for KiwiStay

## 🚨 Quick Solution: Use Render.com (Recommended)

Since Replit deployment is having issues and Netlify doesn't support full-stack apps, **Render.com** is your best option.

### Why Render is Perfect:
- ✅ **Free tier available**
- ✅ **Full-stack Node.js support** 
- ✅ **PostgreSQL database included**
- ✅ **Auto-deploy from GitHub**
- ✅ **Environment variables support**
- ✅ **Fast deployment (under 5 minutes)**

## Step-by-Step Render Deployment:

### 1. Prepare Your Code
```bash
# Test your build locally first
npm run build
npm start
```

### 2. Push to GitHub
```bash
git add .
git commit -m "Deploy to Render"
git push origin main
```

### 3. Deploy on Render
1. Go to **render.com** and sign up
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure these settings:
   - **Build Command**: `npm run build`
   - **Start Command**: `npm start`
   - **Environment**: `Node`

### 4. Add Environment Variables
In Render dashboard, add these secrets:
```
DATABASE_URL=your-supabase-url
JWT_SECRET=your-random-secret
VITE_SUPABASE_URL=your-supabase-url
VITE_SUPABASE_ANON_KEY=your-supabase-key
SUPABASE_SERVICE_KEY=your-service-key
```

### 5. Deploy
Click **"Create Web Service"** and wait 3-5 minutes.

## Alternative: Railway (One-Click Deploy)

### Quick Railway Setup:
```bash
npm install -g @railway/cli
railway login
railway up
```

Add environment variables in Railway dashboard.

## Why Other Platforms Don't Work:

- **Netlify**: Only static sites, no Node.js server
- **Vercel**: Works but more complex setup
- **Replit**: Deployment service having issues
- **GitHub Pages**: Static only, no backend

## Environment Variables You Need:

Get these from your Supabase dashboard:
```
DATABASE_URL=postgresql://...
VITE_SUPABASE_URL=https://...
VITE_SUPABASE_ANON_KEY=eyJh...
SUPABASE_SERVICE_KEY=eyJh...
JWT_SECRET=your-random-string
```

## Testing Your Deployment:

1. Visit your deployed URL
2. Test user registration
3. Test property search
4. Test booking system
5. Check mobile responsiveness

## Common Issues & Solutions:

**Issue**: Build timeout
**Solution**: Use the quick-build.js script

**Issue**: Environment variables not working
**Solution**: Double-check spelling and format

**Issue**: Database connection failed
**Solution**: Verify DATABASE_URL format

## Support:

If you get stuck, most platforms have excellent documentation:
- **Render**: docs.render.com
- **Railway**: docs.railway.app
- **Vercel**: vercel.com/docs

## Ready to Deploy?

1. Choose **Render.com** (recommended)
2. Follow the steps above
3. Your KiwiStay app will be live in minutes!

Your app is fully prepared for deployment with all necessary configuration files already created.