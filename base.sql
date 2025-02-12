create table Personnel (
	personnel_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    ssn VARCHAR(11) UNIQUE NOT NULL,
    medicare_number VARCHAR(20) UNIQUE NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    province VARCHAR(50),
    postal_code VARCHAR(10),
    email VARCHAR(255),
	telephone_number int,
    roles varchar(30) check (roles in ('General Manager', 'Deputy Manager', 'Treasurer', 'Secretary', 'Administrator', 'Coach', 'Assistant Coach', 'Captain', 'Other'))NOT NULL,
    mandate varchar(15) check (mandate in('Volunteer', 'Salaried')) NOT NULL
);
ALTER TABLE Personnel MODIFY COLUMN telephone_number VARCHAR(20);
ALTER TABLE Personnel CHANGE COLUMN role roles VARCHAR(30) CHECK (roles IN ('General Manager', 'Deputy Manager', 'Treasurer', 'Secretary', 'Administrator', 'Coach', 'Assistant Coach', 'Captain', 'Other')) NOT NULL;
ALTER TABLE Personnel DROP CHECK Personnel_chk_1;
ALTER TABLE Personnel CHANGE COLUMN role roles VARCHAR(30) NOT NULL;
ALTER TABLE Personnel ADD CONSTRAINT chk_roles CHECK (roles IN ('General Manager', 'Deputy Manager', 'Treasurer', 'Secretary', 'Administrator', 'Coach', 'Assistant Coach', 'Captain', 'Other'));





CREATE TABLE ClubLocation (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type varchar(10) Check(type in('Head', 'Branch')),
    address VARCHAR(255),
    city VARCHAR(100),
    province VARCHAR(50),
    postal_code VARCHAR(20),
    phone_number VARCHAR(20),
    web_address VARCHAR(255),
    capacity INT,
    manager_name varchar(50),
    manager_id int,
    number_members int,
    FOREIGN KEY (manager_id) REFERENCES Personnel(personnel_id)
);


CREATE TABLE PersonnelAssignment (
    personnel_id INT,
    location_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (personnel_id, location_id, start_date),
    FOREIGN KEY (personnel_id) REFERENCES Personnel(personnel_id),
    FOREIGN KEY (location_id) REFERENCES ClubLocation(location_id)
);

CREATE TABLE FamilyMember (
    family_member_id INT AUTO_INCREMENT PRIMARY KEY,
    current_location_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    ssn VARCHAR(11),
    medicare_number VARCHAR(20),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(100),
    province VARCHAR(50),
    postal_code VARCHAR(10),
    email VARCHAR(255),
    FOREIGN KEY (current_location_id) REFERENCES ClubLocation(location_id)
);

CREATE TABLE ClubMembers (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    family_member_id int NOT NULL,
    current_location_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE,
    height FLOAT,
    weight FLOAT,
    age int,
    ssn VARCHAR(15) UNIQUE NOT NULL,
    medicare_card VARCHAR(15) UNIQUE,
    phone_number VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    province VARCHAR(50),
    postal_code VARCHAR(20),
    state varchar(10) check  (state in ('active','inactive')) default('inactive'),
    bool_state boolean DEFAULT FALSE,
    installment_number INT CHECK (installment_number IN (1, 2, 3)),
    FOREIGN KEY (family_member_id) REFERENCES FamilyMember(family_member_id),
    FOREIGN KEY (current_location_id) REFERENCES ClubLocation(location_id)
);



create table family_member_relation(
family_member_id int NOT NULL,
member_id int NOT NULL,
relationship VARCHAR(20) CHECK (relationship IN ('Father', 'Mother', 'Grandfather', 'Grandmother', 'Tutor', 'Partner', 'Friend', 'Other')) NOT NULL,
start_date DATE NOT NULL,
end_date DATE,
PRIMARY KEY (family_member_id, member_id, start_date),
FOREIGN KEY (member_id) references ClubMembers(member_id),
FOREIGN KEY (family_member_id) REFERENCES FamilyMember(family_member_id)
);

create table payment(
member_id int NOT NULL,
payment_id int AUTO_INCREMENT PRIMARY KEY,
payment_method varchar(15) check (payment_method in ('Credit','Debit','Cash'))NOT NULL,
payment_date date NOT NULL,
payment_amount DECIMAL(10, 2) NOT NULL,
membership_year YEAR NOT NULL,
FOREIGN KEY (member_id) references ClubMembers(member_id)
);



-- 插入 Personnel 数据
INSERT INTO Personnel (first_name, last_name, dob, ssn, medicare_number, address, city, province, postal_code, email, telephone_number, role, mandate)
VALUES 
('John', 'Doe', '1985-06-15', '123-45-6789', 'M123456789', '123 Main St', 'Montreal', 'Quebec', 'H3A 1A1', 'john.doe@example.com', 5141234567, 'General Manager', 'Salaried'),
('Jane', 'Smith', '1990-09-25', '234-56-7890', 'M234567890', '456 Elm St', 'Toronto', 'Ontario', 'M5V 2T6', 'jane.smith@example.com', 4169876543, 'Coach', 'Volunteer'),
('Alice', 'Johnson', '1988-03-10', '345-67-8901', 'M345678901', '789 Pine Ave', 'Vancouver', 'British Columbia', 'V6B 3K9', 'alice.johnson@example.com', 6048765432, 'Secretary', 'Salaried');

-- 插入 ClubLocation 数据
INSERT INTO ClubLocation (name, type, address, city, province, postal_code, phone_number, web_address, capacity, manager_name, manager_id, number_members)
VALUES 
('Downtown Club', 'Head', '500 Club St', 'Montreal', 'Quebec', 'H2X 1Y8', '5145551234', 'www.downtownclub.ca', 200, 'John Doe', 1, 150),
('Uptown Branch', 'Branch', '800 Sports Ave', 'Toronto', 'Ontario', 'M4B 1V3', '4165556789', 'www.uptownbranch.ca', 100, 'Jane Smith', 2, 75);

-- 插入 PersonnelAssignment 数据
INSERT INTO PersonnelAssignment (personnel_id, location_id, start_date, end_date)
VALUES 
(1, 1, '2023-01-01', NULL),
(2, 2, '2023-02-15', NULL);

-- 插入 FamilyMember 数据
INSERT INTO FamilyMember (current_location_id, first_name, last_name, dob, ssn, medicare_number, phone, address, city, province, postal_code, email)
VALUES 
(1, 'Robert', 'Doe', '2010-07-20', '456-78-9012', 'M456789012', '5149998888', '123 Main St', 'Montreal', 'Quebec', 'H3A 1A1', 'robert.doe@example.com'),
(2, 'Emily', 'Smith', '2012-05-14', '567-89-0123', 'M567890123', '4167776666', '456 Elm St', 'Toronto', 'Ontario', 'M5V 2T6', 'emily.smith@example.com');

-- 插入 ClubMembers 数据
INSERT INTO ClubMembers (family_member_id, current_location_id, first_name, last_name, dob, height, weight, age, ssn, medicare_card, phone_number, address, city, province, postal_code, state, bool_state, installment_number)
VALUES 
(1, 1, 'Robert', 'Doe', '2010-07-20', 150.5, 45.2, 13, '789-01-2345', 'M789012345', '5149998888', '123 Main St', 'Montreal', 'Quebec', 'H3A 1A1', 'active', TRUE, 3),
(2, 2, 'Emily', 'Smith', '2012-05-14', 140.0, 40.0, 11, '890-12-3456', 'M890123456', '4167776666', '456 Elm St', 'Toronto', 'Ontario', 'M5V 2T6', 'inactive', FALSE, 2);

-- 插入 family_member_relation 数据
INSERT INTO family_member_relation (family_member_id, member_id, relationship, start_date, end_date)
VALUES 
(1, 1, 'Father', '2023-01-01', NULL),
(2, 2, 'Mother', '2023-02-01', NULL);

-- 插入 payment 数据
INSERT INTO payment (member_id, payment_method, payment_date, payment_amount, membership_year)
VALUES 
(1, 'Credit', '2024-01-10', 500.00, 2024),
(2, 'Cash', '2024-02-15', 450.00, 2024);






 