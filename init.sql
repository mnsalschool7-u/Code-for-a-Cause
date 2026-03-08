-- Code for a Cause - Initial Database Script

-- Create Users table for volunteers, donors, and admins
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'volunteer', -- can be 'volunteer', 'donor', 'admin', 'organization'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Causes/Campaigns table
CREATE TABLE causes (
    cause_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    organizer_id INTEGER REFERENCES users(user_id),
    goal_amount DECIMAL(10, 2),
    current_amount DECIMAL(10, 2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'active', -- 'active', 'completed', 'cancelled'
    target_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Donations table to track contributions
CREATE TABLE donations (
    donation_id SERIAL PRIMARY KEY,
    cause_id INTEGER REFERENCES causes(cause_id),
    donor_id INTEGER REFERENCES users(user_id),
    amount DECIMAL(10, 2) NOT NULL,
    message TEXT,
    donation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Volunteer Signups table to track who is helping with what cause
CREATE TABLE volunteer_signups (
    signup_id SERIAL PRIMARY KEY,
    cause_id INTEGER REFERENCES causes(cause_id),
    volunteer_id INTEGER REFERENCES users(user_id),
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'approved', 'completed'
    signup_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
