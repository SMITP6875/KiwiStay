-- KiwiStay Database Schema for Supabase
-- Copy and paste this into your Supabase SQL editor to create all tables

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE IF NOT EXISTS public.users (
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
CREATE TABLE IF NOT EXISTS public.properties (
    id SERIAL PRIMARY KEY,
    host_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
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
    amenities JSONB DEFAULT '[]',
    images JSONB DEFAULT '[]',
    is_furnished BOOLEAN DEFAULT FALSE,
    available_from DATE,
    available_to DATE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Bookings table
CREATE TABLE IF NOT EXISTS public.bookings (
    id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL REFERENCES public.properties(id) ON DELETE CASCADE,
    guest_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    guests INTEGER NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Reviews table
CREATE TABLE IF NOT EXISTS public.reviews (
    id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL REFERENCES public.properties(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Wishlist table
CREATE TABLE IF NOT EXISTS public.wishlist (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    property_id INTEGER NOT NULL REFERENCES public.properties(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, property_id)
);

-- Messages table
CREATE TABLE IF NOT EXISTS public.messages (
    id SERIAL PRIMARY KEY,
    sender_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    recipient_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    property_id INTEGER REFERENCES public.properties(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Notifications table
CREATE TABLE IF NOT EXISTS public.notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Appointments table
CREATE TABLE IF NOT EXISTS public.appointments (
    id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL REFERENCES public.properties(id) ON DELETE CASCADE,
    guest_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    host_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    appointment_date TIMESTAMP NOT NULL,
    status TEXT DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Payments table
CREATE TABLE IF NOT EXISTS public.payments (
    id SERIAL PRIMARY KEY,
    booking_id INTEGER NOT NULL REFERENCES public.bookings(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL,
    currency TEXT DEFAULT 'NZD',
    payment_method TEXT NOT NULL,
    payment_status TEXT DEFAULT 'pending',
    transaction_id TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Host credentials table
CREATE TABLE IF NOT EXISTS public.host_credentials (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    host_username TEXT NOT NULL UNIQUE,
    host_password TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Insert sample data
INSERT INTO public.users (username, email, password, first_name, last_name, is_host) VALUES
('john_doe', 'john@example.com', '$2b$10$8K1p5ULTRGv9e1TRMWWBSuIlHnbvPOzjYpzW8K1p5ULTRGv9e1TRM', 'John', 'Doe', true),
('jane_smith', 'jane@example.com', '$2b$10$8K1p5ULTRGv9e1TRMWWBSuIlHnbvPOzjYpzW8K1p5ULTRGv9e1TRM', 'Jane', 'Smith', false),
('mike_wilson', 'mike@example.com', '$2b$10$8K1p5ULTRGv9e1TRMWWBSuIlHnbvPOzjYpzW8K1p5ULTRGv9e1TRM', 'Mike', 'Wilson', true)
ON CONFLICT (email) DO NOTHING;

INSERT INTO public.properties (host_id, title, description, type, address, city, region, bedrooms, bathrooms, max_guests, price_per_night, amenities, images) VALUES
(1, 'Cozy Auckland Apartment', 'A beautiful apartment in the heart of Auckland with stunning harbor views', 'apartment', '123 Queen Street', 'Auckland', 'Auckland', 2, 1, 4, 150.00, '["wifi", "kitchen", "parking"]', '["https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"]'),
(3, 'Wellington Waterfront Studio', 'Modern studio with Wellington harbor views', 'studio', '456 Waterfront', 'Wellington', 'Wellington', 1, 1, 2, 120.00, '["wifi", "kitchen", "gym"]', '["https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"]'),
(1, 'Christchurch Garden House', 'Charming house with beautiful garden', 'house', '789 Garden Road', 'Christchurch', 'Canterbury', 3, 2, 6, 200.00, '["wifi", "kitchen", "garden", "parking"]', '["https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"]')
ON CONFLICT DO NOTHING;

INSERT INTO public.reviews (property_id, user_id, rating, comment) VALUES
(1, 2, 5, 'Amazing place! Great location and very clean.'),
(2, 2, 4, 'Nice studio, perfect for a short stay.'),
(3, 2, 5, 'Beautiful house with an incredible garden!')
ON CONFLICT DO NOTHING;

INSERT INTO public.host_credentials (user_id, host_username, host_password) VALUES
(1, 'john_host', '$2b$10$8K1p5ULTRGv9e1TRMWWBSuIlHnbvPOzjYpzW8K1p5ULTRGv9e1TRM'),
(3, 'mike_host', '$2b$10$8K1p5ULTRGv9e1TRMWWBSuIlHnbvPOzjYpzW8K1p5ULTRGv9e1TRM')
ON CONFLICT (host_username) DO NOTHING;