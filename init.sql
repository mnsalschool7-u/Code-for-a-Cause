-- Pilot Data Model - Equipment Collection Script

-- Users Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    employee_id VARCHAR(50) UNIQUE NOT NULL, -- or upn/samAccountName
    display_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    manager_id INTEGER REFERENCES users(id),
    is_manager BOOLEAN DEFAULT FALSE,
    last_synced_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Equipment Assignments Table
CREATE TABLE equipment_assignments (
    id SERIAL PRIMARY KEY,
    asset_tag VARCHAR(50) UNIQUE,
    serial VARCHAR(100) UNIQUE,
    model VARCHAR(100),
    assigned_to_employee_id VARCHAR(50) REFERENCES users(employee_id),
    source VARCHAR(50), -- e.g., 'Intune', 'Snipe-IT', etc.
    last_synced_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Collection Events Table
CREATE TABLE collection_events (
    id SERIAL PRIMARY KEY,
    asset_id INTEGER REFERENCES equipment_assignments(id), -- Could also use asset_tag or serial directly
    assigned_to_employee_id VARCHAR(50) REFERENCES users(employee_id),
    marked_collected_by_manager_employee_id VARCHAR(50) REFERENCES users(employee_id),
    marked_collected_at TIMESTAMP,
    notes TEXT,
    status VARCHAR(50) DEFAULT 'COLLECTED_PENDING_IT', -- e.g., 'COLLECTED_PENDING_IT', 'CLOSED_OUT'
    closed_out_by_it_employee_id VARCHAR(50) REFERENCES users(employee_id),
    closed_out_at TIMESTAMP
);
