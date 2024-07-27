 -- Table: chat_room
CREATE TABLE chat_room (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME
);

 -- Table: user_contact
CREATE TABLE user_contact (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_code INT NOT NULL,
    phone_number INT NOT NULL
);

-- Table: users
CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number INT NOT NULL,
    email VARCHAR(50) NOT NULL,
    user_type ENUM('admin', 'client', 'artist') DEFAULT 'client',
    registered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    status ENUM('active', 'inactive', 'blocked', 'deleted') DEFAULT 'active',
    verification_code VARCHAR(255)
);

-- Table: user_address
CREATE TABLE user_address (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    postal_code VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

-- Table: admin
CREATE TABLE admin (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    profile_pic MEDIUMBLOB NOT NULL,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: client
CREATE TABLE client (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    user_address_id INT NOT NULL,
    profile_pic MEDIUMBLOB NOT NULL,
    background_pic MEDIUMBLOB NOT NULL,
    biography VARCHAR(255),
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (user_address_id) REFERENCES user_address(id)
);

-- Table: art_store
CREATE TABLE art_store (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    store_status ENUM('open', 'closed') NOT NULL DEFAULT 'closed',
    closed_at DATETIME
);

-- Table: pick_up_address
CREATE TABLE pick_up_address (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    postal_code VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE artist_application (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    psa_file MEDIUMBLOB NOT NULL,
    valid_id MEDIUMBLOB NOT NULL,
    approved BOOLEAN NOT NULL DEFAULT FALSE,
    disapproval_reason VARCHAR(255),
    applied_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approved_on DATETIME
);

CREATE TABLE artist (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    user_address_id INT NOT NULL,
    application_id INT NOT NULL,
    approved BOOLEAN NOT NULL DEFAULT FALSE,
    profile_pic MEDIUMBLOB NOT NULL,
    background_pic MEDIUMBLOB NOT NULL,
    biography VARCHAR(255),
    pick_up_address_id INT NOT NULL,
    commission_avail BOOLEAN NOT NULL DEFAULT TRUE,
    art_store_id INT NOT NULL,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (user_address_id) REFERENCES user_address(id),
    FOREIGN KEY (art_store_id) REFERENCES art_store(id),
    FOREIGN KEY (pick_up_address_id) REFERENCES pick_up_address(id),
    FOREIGN KEY (application_id) REFERENCES artist_application(id)
);

DELIMITER //

CREATE TRIGGER update_artist_approved
AFTER INSERT ON artist_application
FOR EACH ROW
BEGIN
    UPDATE artist
    SET approved = NEW.approved
    WHERE application_id = NEW.id;
END//

DELIMITER ;

-- Table: portfolio_website
CREATE TABLE portfolio_website (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    portfolio_name VARCHAR(50) NOT NULL,
    portfolio_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artist(id)
);

-- Table: social_media_profile
CREATE TABLE social_media_profile (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    platform VARCHAR(50) NOT NULL,
    account_id VARCHAR(100),
    username VARCHAR(100),
    profile_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artist(id)
);

-- Table: portfolio
CREATE TABLE portfolio (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    photo MEDIUMBLOB NOT NULL,
    description VARCHAR(255) NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artist(id)
);

-- Table: chat
CREATE TABLE chat (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    chat_room_id INT NOT NULL,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    chat_status ENUM('sent', 'delivered', 'read') DEFAULT 'sent',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    FOREIGN KEY (chat_room_id) REFERENCES chat_room(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: attribute
CREATE TABLE attribute (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type ENUM('medium', 'style', 'theme') NOT NULL
);

-- Table: artist_attribute
CREATE TABLE artist_attribute (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artist_id INT NOT NULL,
    attribute_id INT NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artist(id),
    FOREIGN KEY (attribute_id) REFERENCES attribute(id)
);

-- Table: artwork
CREATE TABLE artwork (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    art_store_id INT NOT NULL,
    art_title VARCHAR(50) NOT NULL,
    photo MEDIUMBLOB NOT NULL,
    art_description VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    sale_on DATETIME NOT NULL,
    sold BOOLEAN NOT NULL DEFAULT FALSE,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (art_store_id) REFERENCES art_store(id)
);

-- Table: artwork_attribute
CREATE TABLE artwork_attribute (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artwork_id INT NOT NULL,
    attribute_id INT NOT NULL,
    FOREIGN KEY (artwork_id) REFERENCES artwork(id),
    FOREIGN KEY (attribute_id) REFERENCES attribute(id)
);

-- Table: cart
CREATE TABLE cart (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: commission
CREATE TABLE commission (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    accepted BOOLEAN NOT NULL DEFAULT FALSE,
    artist_id INT NOT NULL,
    date_accepted DATETIME,
    date_completed DATETIME,
    rating INT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    canceled_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (artist_id) REFERENCES artist(id)
);

-- Table: transaction
CREATE TABLE transaction (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    artist_id INT NOT NULL,
    commission_id INT,
    cart_id INT,
    payment_type VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    status VARCHAR(50) NOT NULL,
    transaction_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (artist_id) REFERENCES artist(id),
    FOREIGN KEY (cart_id) REFERENCES cart(id),
    FOREIGN KEY (commission_id) REFERENCES commission(id)
);

-- Table: artist_rating
CREATE TABLE artist_rating (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    commission_id INT NOT NULL,
    stars INT NOT NULL,
    comment VARCHAR(255),
    rated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (commission_id) REFERENCES commission(id)
);

-- Table: artwork_rating
CREATE TABLE artwork_rating (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    artwork_id INT NOT NULL,
    stars INT NOT NULL,
    comment VARCHAR(255),
    rated_on DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artwork_id) REFERENCES artwork(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: action_type
CREATE TABLE action_type (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(50) NOT NULL
);

-- Table: post
CREATE TABLE post (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    image MEDIUMBLOB,
    content TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table: comments
CREATE TABLE comments (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    parent_comment_id INT,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    FOREIGN KEY (post_id) REFERENCES post(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_comment_id) REFERENCES comments(id)
);

-- Table: notification
CREATE TABLE notification (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    recepient_id INT NOT NULL,
    action_type_id INT NOT NULL,
    post_id INT,
    chat_room_id INT,
    comment_id INT,
    message TEXT NOT NULL,
    viewed BOOLEAN NOT NULL DEFAULT FALSE,
    received_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (server_id) REFERENCES users(id),
    FOREIGN KEY (recepient_id) REFERENCES users(id),
    FOREIGN KEY (action_type_id) REFERENCES action_type(id),
    FOREIGN KEY (chat_room_id) REFERENCES chat_room(id),
    FOREIGN KEY (post_id) REFERENCES post(id),
    FOREIGN KEY (comment_id) REFERENCES comments(id)
);

-- Table: contract
CREATE TABLE contract (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    commission_id INT NOT NULL,
    quotation DECIMAL(10, 2) NOT NULL,
    deadline DATETIME,
    FOREIGN KEY (commission_id) REFERENCES commission(id)
);

-- Table: cart_item
CREATE TABLE cart_item (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    artwork_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES cart(id),
    FOREIGN KEY (artwork_id) REFERENCES artwork(id)
);

-- Table: artwork_shipping
CREATE TABLE artwork_shipping (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artwork_id INT NOT NULL,
    is_cod BOOLEAN NOT NULL DEFAULT FALSE,
    transportation VARCHAR(100) NOT NULL,
    artwork_weight INT NOT NULL,
    artwork_width INT,
    artwork_length INT,
    artwork_height INT,
    FOREIGN KEY (artwork_id) REFERENCES artwork(id)
);

CREATE TABLE user_payment_info (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,  -- Foreign key to the users table
    payout_account VARCHAR(100) NOT NULL,
    account_no VARCHAR(20) NOT NULL UNIQUE,
    account_name VARCHAR(100) NOT NULL,
    account_type ENUM('pay-in','pay-out'),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table: user_relationship
CREATE TABLE user_relationship (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    followed_id INT NOT NULL,
    followed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (followed_id) REFERENCES users(id)
);

