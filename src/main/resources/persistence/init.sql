CREATE TABLE user_setting (
    id BIGSERIAL PRIMARY KEY,
    language VARCHAR(50),
    notification VARCHAR(255),
    shared_data VARCHAR(255)
);
CREATE TABLE app_user (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    setting_id BIGINT,
    FOREIGN KEY (setting_id) REFERENCES user_setting(id)
);
CREATE TABLE pothole (
    id SERIAL PRIMARY KEY,
    date_found DATE NOT NULL,
    time_found TIME NOT NULL,
    severity VARCHAR(50) NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    country VARCHAR(255),
    city VARCHAR(255),
    u_id INT NOT NULL,
    FOREIGN KEY (u_id) REFERENCES app_user(id) ON DELETE CASCADE
);
CREATE TABLE unverified_user (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    v_code VARCHAR(50),
    purpose_type VARCHAR(50) NOT NULL,
    is_confirmed BOOLEAN DEFAULT FALSE
);

-- Thêm người dùng mới
INSERT INTO app_user (username, email, password, setting_id) VALUES
('vuthinh', 'vuthinh@example.com', 'password123', NULL),
('nguyenhuutai', 'nguyenhuutai@example.com', 'securepass', NULL),
('lekhautai', 'lekhautai@example.com', 'mypassword', NULL),
('theanhtai', 'theanhtai@example.com', 'securekey', NULL);

-- Thêm cài đặt cho từng người dùng
INSERT INTO user_setting (language, notification, shared_data) VALUES
('English', 'Enabled', 'Public'),
('Vietnamese', 'Disabled', 'Private'),
('English', 'Enabled', 'Private'),
('Vietnamese', 'Enabled', 'Public');

-- Gắn kết người dùng với cài đặt (setting_id)
UPDATE app_user SET setting_id = 1 WHERE username = 'vuthinh';
UPDATE app_user SET setting_id = 2 WHERE username = 'nguyenhuutai';
UPDATE app_user SET setting_id = 3 WHERE username = 'lekhautai';
UPDATE app_user SET setting_id = 4 WHERE username = 'theanhtai';

-- Thêm các ổ gà liên quan đến từng người dùng
INSERT INTO pothole (date_found, time_found, severity, latitude, longitude, country, city, u_id) VALUES
('2024-11-01', '08:30:00', 'High', 21.0285, 105.8542, 'Vietnam', 'Hanoi', 1), -- vuthinh
('2024-11-15', '10:45:00', 'Medium', 10.7629, 106.6821, 'Vietnam', 'Ho Chi Minh City', 2), -- nguyenhuutai
('2024-12-01', '09:00:00', 'Low', 20.9951, 105.8412, 'Vietnam', 'Hanoi', 3), -- lekhautai
('2024-12-02', '15:30:00', 'Critical', 10.7769, 106.7009, 'Vietnam', 'Ho Chi Minh City', 4); -- theanhtai

-- Thêm người dùng chưa xác minh
INSERT INTO unverified_user (email, v_code, purpose_type, is_confirmed) VALUES
('temp_vuthinh@example.com', '123456', 'VerifyUser', FALSE),
('temp_nguyenhuutai@example.com', '654321', 'ChangePass', TRUE),
('temp_lekhautai@example.com', '000001', 'VerifyUser', FALSE),
('temp_theanhtai@example.com', '000002', 'ChangePass', TRUE);