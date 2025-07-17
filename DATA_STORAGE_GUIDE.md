# KiwiStay Data Storage Guide

## Current Storage Implementation

Currently, KiwiStay uses **in-memory storage** (MemStorage) for all data. This means:

- **Data is NOT persistent** - all data is lost when the server restarts
- **No database required** - data is stored in JavaScript objects/Maps in memory
- **Fast performance** - no database queries, instant access
- **Development friendly** - easy to test and modify

## Data Types Stored

### User Data
- User profiles (name, email, phone, avatar)
- Authentication tokens and sessions
- Host status and credentials
- User preferences and settings

### Property Data
- Property listings (title, description, images)
- Location information (city, region, coordinates)
- Pricing and availability
- Amenities and features
- Host information

### Booking Data
- Reservations and booking details
- Payment information and receipts
- Booking status and history
- Guest and property associations

### Communication Data
- Messages between users
- Notifications and alerts
- Conversation history
- Read/unread status

### Additional Data
- Reviews and ratings
- Wishlist items
- Appointments and scheduling
- Property search history

## Supabase Integration Options

If you want to use Supabase for persistent storage, here are your options:

### Option 1: Supabase as Database
- Replace MemStorage with Supabase database
- Store all data in Supabase PostgreSQL tables
- Use Supabase client for database operations
- Enable real-time subscriptions for messaging

### Option 2: Supabase for Authentication Only
- Keep current MemStorage for application data
- Use Supabase Auth for user authentication
- Sync user data between systems
- Leverage Supabase's OAuth providers

### Option 3: Hybrid Approach
- Use Supabase for user authentication and profiles
- Use MemStorage for temporary data (messages, notifications)
- Use Supabase for persistent data (properties, bookings, reviews)

## Current Supabase Setup

Your project currently has Supabase configured for:
- **Email services** (password reset, welcome emails)
- **Authentication enhancement** (OTP verification)
- **Environment variables** are already set up:
  - `VITE_SUPABASE_URL`
  - `VITE_SUPABASE_ANON_KEY`
  - `SUPABASE_SERVICE_KEY`

## Migration Path to Supabase

To migrate from MemStorage to Supabase:

1. **Create Supabase tables** matching your current schema
2. **Update storage layer** to use Supabase client
3. **Migrate authentication** to Supabase Auth
4. **Set up real-time subscriptions** for messaging
5. **Test and verify** data persistence

## Data Persistence Note

⚠️ **Important**: Currently, your data is NOT saved permanently. When you restart the application, all data (users, properties, messages, bookings) will be reset to the sample data defined in the code.

To make data persistent, you would need to:
- Set up a proper database (PostgreSQL with Supabase)
- Replace MemStorage with DatabaseStorage
- Configure proper database migrations
- Update the storage interface implementation

Would you like me to help you migrate to Supabase for persistent data storage?