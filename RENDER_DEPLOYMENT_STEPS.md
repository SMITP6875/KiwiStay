# Deploy KiwiStay to Render.com - Step by Step

## Quick Setup (5 Minutes)

### Step 1: Push Your Code to GitHub
```bash
# If you haven't already, initialize git and push to GitHub
git add .
git commit -m "Ready for Render deployment"
git push origin main
```

### Step 2: Create Render Account
1. Go to **https://render.com**
2. Click **"Get Started"** 
3. Sign up with your GitHub account

### Step 3: Create Web Service
1. Click **"New +"** button
2. Select **"Web Service"**
3. Connect your GitHub repository
4. Choose your KiwiStay repository

### Step 4: Configure Build Settings
Fill in these exact settings:
- **Name**: `kiwistay` (or your preferred name)
- **Environment**: `Node`
- **Build Command**: `npm run build`
- **Start Command**: `npm start`
- **Instance Type**: `Free` (for testing)

### Step 5: Add Environment Variables
Click **"Advanced"** → **"Add Environment Variable"** and add these:

**Required Variables:**
```
DATABASE_URL=your-supabase-database-url
JWT_SECRET=your-random-secret-key
VITE_SUPABASE_URL=your-supabase-project-url
VITE_SUPABASE_ANON_KEY=your-supabase-anon-key
SUPABASE_SERVICE_KEY=your-supabase-service-key
NODE_ENV=production
```

**To get your Supabase values:**
1. Go to your Supabase dashboard
2. Settings → API
3. Copy the URL and anon key
4. For DATABASE_URL, go to Settings → Database → Connection string

### Step 6: Deploy
1. Click **"Create Web Service"**
2. Wait 3-5 minutes for deployment
3. Your app will be live at: `https://your-app-name.onrender.com`

## Testing Your Deployment

Once deployed, test these features:
- [ ] Homepage loads with properties
- [ ] User registration works
- [ ] Property search functions
- [ ] Property details page works
- [ ] Reservation system works

## Common Issues & Solutions

**Build fails**: Check that all environment variables are set correctly

**Database connection error**: Verify your DATABASE_URL format is correct

**Page not found**: Make sure your start command is `npm start`

## Your App is Ready!
All configuration files are already created in your project:
- ✅ `render.yaml` - Render configuration
- ✅ `package.json` - Correct build scripts
- ✅ `quick-build.js` - Fast build process
- ✅ All environment variables documented

## Next Steps After Deployment

1. **Custom Domain**: Add your own domain in Render settings
2. **Database Scaling**: Upgrade to paid plan for production
3. **Monitoring**: Set up alerts in Render dashboard
4. **SSL**: Automatically provided by Render

Your KiwiStay app is fully ready for professional deployment!