CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    city VARCHAR(100),
    country VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fleet (
    id SERIAL PRIMARY KEY,
    vehicle_number VARCHAR(50) UNIQUE NOT NULL,
    type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    status VARCHAR(50) DEFAULT 'available',
    current_latitude DECIMAL(10, 8),
    current_longitude DECIMAL(11, 8),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS shipments (
    id SERIAL PRIMARY KEY,
    tracking_id VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT NOT NULL REFERENCES customers(id),
    origin_address TEXT NOT NULL,
    destination_address TEXT NOT NULL,
    destination_latitude DECIMAL(10, 8),
    destination_longitude DECIMAL(11, 8),
    status VARCHAR(50) DEFAULT 'pending',
    weight DECIMAL(10, 2),
    shipment_date DATE NOT NULL,
    estimated_delivery DATE,
    actual_delivery DATE,
    vehicle_id INT REFERENCES fleet(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tracking_updates (
    id SERIAL PRIMARY KEY,
    shipment_id INT NOT NULL REFERENCES shipments(id),
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    location_name VARCHAR(255),
    status VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS barcodes (
    id SERIAL PRIMARY KEY,
    shipment_id INT NOT NULL REFERENCES shipments(id),
    barcode_value VARCHAR(255) UNIQUE NOT NULL,
    qr_code_data TEXT,
    scanned_at TIMESTAMP,
    scanned_location VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS routes (
    id SERIAL PRIMARY KEY,
    vehicle_id INT NOT NULL REFERENCES fleet(id),
    shipment_id INT NOT NULL REFERENCES shipments(id),
    sequence INT,
    distance_km DECIMAL(10, 2),
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    phone VARCHAR(20),
    vehicle_id INT REFERENCES fleet(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_shipments_tracking_id ON shipments(tracking_id);
CREATE INDEX idx_shipments_customer_id ON shipments(customer_id);
CREATE INDEX idx_tracking_updates_shipment_id ON tracking_updates(shipment_id);
CREATE INDEX idx_barcodes_shipment_id ON barcodes(shipment_id);
CREATE INDEX idx_fleet_vehicle_number ON fleet(vehicle_number);
CREATE INDEX idx_users_email ON users(email);
