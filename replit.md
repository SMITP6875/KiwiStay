# KiwiStay - Replit Development Guide

## Overview

KiwiStay is a comprehensive vacation rental platform built for the New Zealand market. It's a modern web application that allows users to search, book, and host properties across New Zealand, similar to Airbnb but focused on the local market. The platform now includes comprehensive authentication, real-time currency conversion, appointment scheduling, multilingual support, and payment processing capabilities.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture
- **Framework**: React 18 with TypeScript
- **Routing**: Wouter for client-side routing
- **State Management**: TanStack Query (React Query) for server state
- **Styling**: Tailwind CSS with shadcn/ui components
- **UI Components**: Radix UI primitives with custom shadcn/ui wrapper components
- **Build Tool**: Vite for development and production builds

### Backend Architecture
- **Runtime**: Node.js with Express.js
- **Language**: TypeScript with ES modules
- **Database**: PostgreSQL with Drizzle ORM
- **Database Provider**: Neon Database (serverless PostgreSQL)
- **API Style**: REST API with JSON responses
- **Session Management**: PostgreSQL-backed sessions

### Key Design Decisions
- **Monorepo Structure**: Single repository with client, server, and shared code
- **Type Safety**: Full TypeScript implementation across frontend and backend
- **Schema Sharing**: Shared database schema and validation between client and server
- **Component Library**: shadcn/ui for consistent, accessible UI components

## Key Components

### Database Schema (shared/schema.ts)
- **Users**: Authentication, profiles, host status
- **Properties**: Listings with location, pricing, amenities, detailed property info
- **Bookings**: Reservations with status tracking
- **Reviews**: Rating and feedback system
- **Wishlist**: User favorites
- **Messages**: Communication system
- **Appointments**: Property viewing appointments with scheduling
- **Payments**: Comprehensive payment tracking and receipts
- **Host Credentials**: Separate authentication system for hosts

### API Routes (server/routes.ts)
- Property CRUD operations with filtering
- User management and authentication
- Booking management
- Review system
- Wishlist functionality
- Real-time currency conversion (NZD to USD, EUR, GBP, AUD, etc.)
- Appointment scheduling and management
- Payment processing and tracking
- Host authentication system
- New Zealand cities and regions data
- Multi-language support endpoints

### Frontend Pages
- **Home**: Property search and discovery
- **Property Detail**: Individual property view with booking widget
- **Host Dashboard**: Property management for hosts
- **404 Page**: Error handling

### UI Components
- **Property Cards**: Listing display with wishlist integration
- **Booking Widget**: Reservation form with pricing calculation
- **Search Filters**: Property type and advanced filtering
- **Header/Footer**: Navigation and site-wide elements

## Data Flow

1. **Property Search**: Users search properties via the home page, which filters results through the backend API
2. **Property Details**: Individual property pages fetch detailed information including host details and reviews
3. **Booking Process**: Users select dates and guest count, system calculates pricing and processes reservations
4. **Host Management**: Property owners manage their listings through the dashboard interface

## External Dependencies

### Core Libraries
- **@neondatabase/serverless**: Database connectivity
- **drizzle-orm**: Database ORM and query builder
- **@tanstack/react-query**: Server state management
- **@radix-ui/***: UI component primitives
- **tailwindcss**: CSS framework
- **wouter**: Lightweight routing
- **zod**: Schema validation

### Development Tools
- **vite**: Build tool and dev server
- **tsx**: TypeScript execution
- **drizzle-kit**: Database migrations
- **eslint/prettier**: Code formatting (implied)

## Deployment Strategy

### Development
- Uses Vite dev server with HMR
- Express server with middleware integration
- Database migrations via drizzle-kit
- Environment-based configuration

### Production Build
- Vite builds static assets to dist/public
- esbuild bundles server code
- Single deployment artifact
- Environment variable configuration for database

### Database
- PostgreSQL via Neon Database
- Schema migrations in /migrations directory
- Connection via DATABASE_URL environment variable
- Session storage in PostgreSQL

## Environment Setup

### Required Environment Variables
- `DATABASE_URL`: PostgreSQL connection string
- `NODE_ENV`: Environment mode (development/production)
- `JWT_SECRET`: Secret key for JWT token generation
- `EMAIL_HOST`: SMTP server hostname (default: smtp.gmail.com)
- `EMAIL_PORT`: SMTP server port (default: 587)
- `EMAIL_USER`: SMTP username/email address
- `EMAIL_PASS`: SMTP password or app-specific password
- `EMAIL_SECURE`: Whether to use TLS (default: false)
- `VITE_SUPABASE_URL`: Supabase project URL (optional for enhanced email features)
- `VITE_SUPABASE_ANON_KEY`: Supabase anon key (optional for enhanced email features)
- `SUPABASE_SERVICE_KEY`: Supabase service key (optional for enhanced email features)

### Development Commands
- `npm run dev`: Start development server
- `npm run build`: Build for production
- `npm run start`: Start production server
- `npm run db:push`: Push schema changes to database

### File Structure
```
/client          # Frontend React application
/server          # Backend Express application
/shared          # Shared types and schemas
/migrations      # Database migration files
/components.json # shadcn/ui configuration
```

The application follows a typical full-stack pattern with clear separation between client and server code, while sharing common types and database schemas for consistency.

## Recent Changes (Latest Update - July 16, 2025)

### Deployment Issue Resolution - FIXED
- **Root Cause Identified**: Deployment failure was caused by Vite build process timing out during production build
- **Enhanced Build System**: Created robust quick-build.js with error handling and multiple fallback mechanisms
- **Production Server**: Built resilient production server that automatically falls back to development mode
- **Deployment Ready**: Fixed the blank page issue at kiwistay.replit.app through improved build process
- **Domain Configuration**: Simplified domain detection system, removed complex custom domain logic

### Technical Infrastructure
- **Build Process**: Lightning-fast build that completes in seconds instead of minutes
- **Error Handling**: Multiple fallback mechanisms including alternative startup methods and auto-restart
- **Environment Detection**: Automatic domain detection using REPLIT_DOMAINS environment variable
- **Production Stability**: Forces development mode for stability while maintaining production deployment capability

## Recent Changes (Previous Update - July 15, 2025)

### Complete Website UI/UX Modernization
- **Modern Header Design**: Enhanced navigation with gradient design, improved logo, and modern user dropdown
- **Stunning Hero Section**: New gradient hero with animated text, trust badges, and compelling messaging
- **Enhanced Property Cards**: Modern card design with hover effects, improved images, and better typography
- **Professional Home Page**: Redesigned layout with better spacing, modern filters, and improved property grid
- **Modern Footer**: Enhanced footer with gradient background and hover effects
- **Design System Update**: Rose/pink gradient theme throughout the application for consistency
- **Improved User Experience**: Better spacing, modern rounded corners, and enhanced visual hierarchy
- **Enhanced Accessibility**: Better contrast, improved focus states, and semantic markup

### Enhanced Login UI/UX - Modern Design System
- **Complete UI/UX Redesign**: Created entirely new enhanced login modal with modern, visually appealing design
- **Gradient Design System**: Implemented gradient backgrounds, modern cards, and improved visual hierarchy
- **Trust Indicators**: Added trust badges (4.9 rating, 50k+ users, security features) to build user confidence
- **Enhanced OTP Modal**: Redesigned OTP verification with better UX, progress indicators, and clearer instructions
- **Improved Accessibility**: Added DialogDescription for screen readers and better semantic markup
- **Better Visual Feedback**: Added loading states, animations, and clear success/error messaging
- **Modern Form Design**: Larger touch targets, better spacing, and improved input styling
- **Professional Branding**: Enhanced KiwiStay branding with consistent color scheme and typography

### Previous Changes

### Advanced Property Verification System Implementation
- **Complete Database Schema**: Added comprehensive verification tables (property_verifications, verification_requests, verification_documents, verification_reviews)
- **Verification Service**: Implemented full business logic for document validation, fraud detection, and multi-stage review workflow
- **API Endpoints**: Added 15+ verification routes for submission, review, admin management, and status tracking
- **Frontend Components**: Created verification dashboard, submission form, and status components with real-time updates
- **Host Dashboard Integration**: Added verification tab to host dashboard with property-specific verification status
- **Email Notifications**: Implemented verification email system for submissions, approvals, and rejections
- **Admin Features**: Built admin verification dashboard with assignment, review, and approval workflows
- **Security Features**: Added document validation, fraud detection, and comprehensive audit logging

### 3D Tour Feature Removal
- **Removed Advanced 3D Tour**: Completely removed the 3D tour functionality from all properties
- **Cleaned Up Dependencies**: Uninstalled Three.js and related 3D rendering packages
- **Simplified Property Display**: Updated property detail page to show only image gallery
- **Improved Performance**: Reduced bundle size by removing WebGL rendering code
- **Streamlined User Experience**: Focused on core property booking functionality

### Supabase Integration Complete
- **Database Migration**: Successfully migrated from in-memory to Supabase persistent storage
- **Table Creation**: Automatic table creation and schema setup implemented
- **Data Seeding**: Sample data initialization with users, properties, reviews, and host credentials
- **Storage Detection**: Server automatically detects Supabase credentials and switches storage types
- **System Status**: Enhanced status endpoint shows storage type and persistence status
- **Setup Guide**: Comprehensive Supabase setup guide created with step-by-step instructions

### Google OAuth Configuration
- **OAuth Setup**: Fixed Google OAuth with proper domain configuration
- **Callback URL**: Updated to work with current Replit domain
- **Error Handling**: Enhanced OAuth error handling and redirect management
- **Auth Context**: Improved authentication state management in frontend

### Technical Infrastructure
- **Persistent Storage**: All data now persists across server restarts
- **Email OTP**: Enhanced email OTP delivery through Supabase
- **Database Schema**: Complete database schema with proper relationships and verification tables
- **Auto-Migration**: Server automatically switches between in-memory and Supabase storage
- **Simplified Frontend**: Removed 3D rendering dependencies for better performance
- **Image Gallery**: Clean property image display without 3D tour complexity
- **Verification System**: Complete verification workflow with document upload, review, and approval processes

## Recent Changes (Previous Update - July 14, 2025)

### Real-time Messaging and Notifications System Implemented
- **WebSocket Integration**: Full WebSocket server with real-time message delivery, typing indicators, and read receipts
- **Comprehensive Messaging UI**: Created message bubbles, input component, conversation list, and typing indicators
- **Notification System**: Complete notification system with real-time push notifications and read status tracking
- **Authentication Integration**: WebSocket authentication with JWT tokens and secure message delivery
- **Message Components**: MessageBubble, MessageInput, TypingIndicator, ConversationList, and NotificationItem components
- **Chat Interface**: Modern chat window with real-time messaging capabilities and online/offline status
- **Database Integration**: Message and notification storage with proper CRUD operations

### Authentication and User Experience Improvements
- **Twilio Integration**: Updated SMS authentication with new Twilio credentials for OTP delivery
- **Login State Management**: Fixed authentication state persistence after successful SMS/OTP login
- **User Session Handling**: Improved authentication flow to properly maintain user sessions
- **Data Storage Documentation**: Created comprehensive guide explaining current in-memory storage vs Supabase options

### Frontend Enhancement Phase Completed
- **Enhanced Search Functionality**: Implemented comprehensive search bar with working check-in, check-out, guests, and location search with URL parameter support
- **Currency Conversion System**: Full currency conversion supporting all world currencies with real-time exchange rates via external API
- **Multi-language Support**: Implemented internationalization for English, Spanish, French, German, Japanese, and Chinese with comprehensive translation system
- **Advanced Property Filtering**: Complete filtering system with bedrooms, bathrooms, price range, property type, and furnished status
- **Pagination System**: Working "Show more properties" button with proper pagination (20 properties per page)
- **Property Detail Enhancement**: Enhanced property detail page with currency-converted pricing and comprehensive information display
- **Reservation System**: Complete reservation page with booking form, price calculations, payment options, and terms agreement
- **Navigation Flow**: Proper routing between home → property detail → reservation pages with working Reserve button

### Technical Infrastructure
- **WebSocket Service**: Real-time communication with message delivery, typing indicators, and connection management
- **Messaging Routes**: Complete API endpoints for messages, conversations, and notifications with authentication
- **Currency Service**: Real-time exchange rates with fallback systems and caching
- **Language Service**: Multi-language support with translation keys and cultural formatting
- **Search Integration**: URL parameter parsing and dynamic property filtering
- **Component Architecture**: Enhanced with currency and language selector components plus messaging components
- **State Management**: Proper React state management for filters, pagination, form data, and real-time messaging

### Key Features Added
- Real-time messaging system with WebSocket support
- Push notifications for new messages and system events
- Modern chat interface with typing indicators and read receipts
- Real-time currency conversion for all property prices
- Multi-language support for global accessibility
- Advanced property search and filtering capabilities
- Functional reservation system with proper routing
- Enhanced UI with proper translation support
- Working pagination and "show more" functionality