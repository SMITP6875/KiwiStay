# Supabase Setup Guide for KiwiStay

## Quick Setup Instructions

Your KiwiStay application is configured for Supabase but needs the database tables created. Here's how to set it up:

### Step 1: Access Supabase Dashboard
1. Go to [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Sign in to your account
3. Select your KiwiStay project

### Step 2: Create Database Tables
1. Click on "SQL Editor" in the left sidebar
2. Click "New Query" 
3. Copy and paste the entire contents of `SUPABASE_DATABASE_SCHEMA.sql` into the editor
4. Click "Run" to execute the SQL

### Step 3: Verify Setup
After running the SQL, your application will automatically:
- Switch from in-memory to persistent storage
- Show sample properties with 3D tours
- Enable user registration and authentication

### What Gets Created:
- **11 Database Tables**: Users, properties, bookings, reviews, wishlist, messages, notifications, appointments, payments, host credentials, and sessions
- **Sample Data**: 3 users, 3 properties in Auckland/Wellington/Christchurch, reviews, and host credentials
- **Relationships**: Proper foreign key relationships between all tables

### Test the 3D Tours:
1. Visit the home page - you'll see 3 sample properties
2. Click on any property to view details
3. Look for the "3D Tour" preview card on the right
4. Click "Start 3D Tour" to experience the immersive walkthrough

## Database Schema Overview

The database includes these main tables:
- `users` - User accounts and profiles
- `properties` - Property listings with images and amenities
- `bookings` - Reservation system
- `reviews` - Property reviews and ratings
- `wishlist` - User favorites
- `messages` - Communication system
- `notifications` - System notifications
- `appointments` - Property viewing appointments
- `payments` - Payment tracking
- `host_credentials` - Host authentication
- `sessions` - Session management

## Sample Data Included

### Users:
- John Doe (Host) - john@example.com / password123
- Jane Smith (Guest) - jane@example.com / password123  
- Mike Wilson (Host) - mike@example.com / password123

### Properties:
- **Auckland Apartment** - 2 bed/1 bath, $150/night
- **Wellington Studio** - 1 bed/1 bath, $120/night
- **Christchurch House** - 3 bed/2 bath, $200/night

All properties include:
- Multiple high-quality images
- Detailed amenities
- Sample reviews
- 3D tour capability

## Troubleshooting

If you don't see properties after running the SQL:
1. Check the SQL Editor for any error messages
2. Refresh your application
3. Check the server logs for Supabase connection status

The application will automatically detect when Supabase is properly configured and switch from in-memory to persistent storage.