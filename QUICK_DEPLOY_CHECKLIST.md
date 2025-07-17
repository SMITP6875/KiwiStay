# KiwiStay - Quick Deploy Checklist ✅

## Ready to Deploy on Render.com

### ✅ Pre-Deployment Check
- [x] App is working locally
- [x] All 100+ properties loading
- [x] Database connection working
- [x] Build scripts configured
- [x] Environment variables available

### 🚀 Deploy Steps (5 Minutes)

#### 1. Go to Render.com
**Link**: https://render.com
- Sign up with GitHub
- Click "New +" → "Web Service"

#### 2. Connect Repository
- Choose your KiwiStay repository
- Branch: `main` (or your default branch)

#### 3. Configure Settings
```
Name: kiwistay
Environment: Node
Build Command: npm run build
Start Command: npm start
```

#### 4. Add Environment Variables
Copy these from your current Replit environment:
```
DATABASE_URL=your-supabase-database-url
VITE_SUPABASE_URL=your-supabase-project-url
VITE_SUPABASE_ANON_KEY=your-supabase-anon-key
SUPABASE_SERVICE_KEY=your-supabase-service-key
NODE_ENV=production
```

**Need JWT_SECRET?** Add this:
```
JWT_SECRET=kiwistay-secret-key-2025
```

#### 5. Deploy
- Click "Create Web Service"
- Wait 3-5 minutes
- Your app will be live!

### 🎯 After Deployment

Test these features:
- Homepage with properties
- Search functionality
- Property details
- User registration
- Reservation system

### 💡 Pro Tips

1. **Free Tier**: Perfect for testing
2. **Custom Domain**: Add later in settings
3. **Auto-Deploy**: Pushes to GitHub auto-deploy
4. **Monitoring**: Built-in in Render dashboard

### 🔧 Alternative Platforms

If Render doesn't work:
1. **Railway**: `npm install -g @railway/cli && railway up`
2. **Vercel**: `npm install -g vercel && vercel --prod`
3. **Heroku**: Follow heroku.com deployment guide

### 🆘 Need Help?

- **Render Docs**: docs.render.com
- **Your build works**: Already tested locally
- **All files ready**: render.yaml, package.json configured

**Your KiwiStay app is deployment-ready!**