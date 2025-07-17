# Supabase Migration Guide for KiwiStay

## Overview

This guide will help you migrate your KiwiStay application from in-memory storage to Supabase for persistent data storage.

## Prerequisites

1. **Supabase Account**: Make sure you have a Supabase account and project
2. **Database URL**: You need your Supabase database connection string
3. **API Keys**: Ensure you have the correct Supabase URL and keys configured

## Step 1: Create Database Tables

Run the following SQL commands in your Supabase SQL editor to create the required tables:

```sql
-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    avatar TEXT,
    phone TEXT,
    is_host BOOLEAN DEFAULT FALSE,
    bio TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Properties table
CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    host_id INTEGER REFERENCES users(id) NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    type TEXT NOT NULL,
    address TEXT NOT NULL,
    city TEXT NOT NULL,
    region TEXT NOT NULL,
    country TEXT DEFAULT 'New Zealand',
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    bedrooms INTEGER NOT NULL,
    bathrooms INTEGER NOT NULL,
    max_guests INTEGER NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    images TEXT[] NOT NULL,
    amenities TEXT[] DEFAULT '{}',
    rules TEXT[] DEFAULT '{}',
    check_in_time TEXT DEFAULT '15:00',
    check_out_time TEXT DEFAULT '11:00',
    minimum_stay INTEGER DEFAULT 1,
    instant_book BOOLEAN DEFAULT FALSE,
    cancellation_policy TEXT DEFAULT 'flexible',
    security_deposit DECIMAL(10, 2) DEFAULT 0.00,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Bookings table
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    property_id INTEGER REFERENCES properties(id) NOT NULL,
    guest_id TEXT,
    check_in TIMESTAMP NOT NULL,
    check_out TIMESTAMP NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    guests INTEGER NOT NULL,
    guest_name TEXT,
    guest_email TEXT,
    guest_phone TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Reviews table
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    property_id INTEGER REFERENCES properties(id) NOT NULL,
    guest_id INTEGER REFERENCES users(id) NOT NULL,
    booking_id INTEGER REFERENCES bookings(id) NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Wishlist table
CREATE TABLE wishlists (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) NOT NULL,
    property_id INTEGER REFERENCES properties(id) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, property_id)
);

-- Messages table
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    sender_id INTEGER REFERENCES users(id) NOT NULL,
    receiver_id INTEGER REFERENCES users(id) NOT NULL,
    content TEXT NOT NULL,
    message_type TEXT DEFAULT 'text',
    property_id INTEGER REFERENCES properties(id),
    booking_id INTEGER REFERENCES bookings(id),
    read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Notifications table
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) NOT NULL,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    data JSONB,
    read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Appointments table
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) NOT NULL,
    property_id INTEGER REFERENCES properties(id) NOT NULL,
    date TIMESTAMP NOT NULL,
    time TEXT NOT NULL,
    duration TEXT DEFAULT '30 minutes',
    status TEXT DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Payments table
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    booking_id INTEGER REFERENCES bookings(id) NOT NULL,
    user_id INTEGER REFERENCES users(id) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency TEXT DEFAULT 'NZD',
    stripe_payment_intent_id TEXT,
    status TEXT NOT NULL,
    payment_method TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Host credentials table
CREATE TABLE host_credentials (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    user_id INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW()
);
```

## Step 2: Enable Row Level Security (RLS)

For security, enable RLS on all tables:

```sql
-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE properties ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE wishlists ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE host_credentials ENABLE ROW LEVEL SECURITY;
```

## Step 3: Create RLS Policies

Create basic policies for public access (you can customize these later):

```sql
-- Users policies
CREATE POLICY "Users can view all users" ON users FOR SELECT USING (true);
CREATE POLICY "Users can insert themselves" ON users FOR INSERT WITH CHECK (true);
CREATE POLICY "Users can update themselves" ON users FOR UPDATE USING (true);

-- Properties policies
CREATE POLICY "Properties are viewable by everyone" ON properties FOR SELECT USING (true);
CREATE POLICY "Hosts can insert properties" ON properties FOR INSERT WITH CHECK (true);
CREATE POLICY "Hosts can update their properties" ON properties FOR UPDATE USING (true);

-- Add similar policies for other tables...
```

## Step 4: Update Storage Configuration

Update your `server/storage.ts` to use Supabase storage:

```typescript
import { SupabaseStorage } from './supabase-storage';

// Replace MemStorage with SupabaseStorage
export const storage = new SupabaseStorage();
```

## Step 5: Test the Migration

1. Restart your application
2. Try creating a new user
3. Check your Supabase database to see if the data persists
4. Test property creation, booking, and messaging features

## Step 6: Data Seeding (Optional)

If you want to add sample data, you can run:

```sql
-- Insert sample users
INSERT INTO users (username, email, password, first_name, last_name, is_host) VALUES
('john_doe', 'john@example.com', 'hashed_password', 'John', 'Doe', true),
('jane_smith', 'jane@example.com', 'hashed_password', 'Jane', 'Smith', false);

-- Insert sample properties
INSERT INTO properties (host_id, title, description, type, address, city, region, bedrooms, bathrooms, max_guests, price_per_night, images) VALUES
(1, 'Cozy Auckland Apartment', 'A beautiful apartment in the heart of Auckland', 'apartment', '123 Queen Street', 'Auckland', 'Auckland', 2, 1, 4, 150.00, '["image1.jpg", "image2.jpg"]');
```

## Benefits of Migration

After migration, you'll have:
- **Persistent data** - No more data loss on server restart
- **Real-time subscriptions** - Live updates for messaging
- **Better scalability** - Database can handle more concurrent users
- **Backup and recovery** - Automatic backups with Supabase
- **Analytics** - Built-in analytics and monitoring

## Troubleshooting

- **Connection errors**: Check your Supabase URL and keys
- **Permission errors**: Verify RLS policies are correct
- **Data not showing**: Ensure tables were created successfully
- **Performance issues**: Add indexes for frequently queried columns

## Next Steps

Once migrated, you can:
1. Set up real-time subscriptions for messaging
2. Add more sophisticated RLS policies
3. Create indexes for better performance
4. Set up automated backups
5. Monitor database performance