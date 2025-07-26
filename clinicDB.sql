-- PATIENTS TABLE
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);

-- DOCTORS TABLE
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- SPECIALIZATIONS TABLE
CREATE TABLE Specializations (
    specialization_id INT PRIMARY KEY AUTO_INCREMENT,
    specialty_name VARCHAR(100) UNIQUE NOT NULL
);

-- DOCTOR_SPECIALIZATION TABLE (M:M Junction)
CREATE TABLE Doctor_Specialization (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- APPOINTMENTS TABLE
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- PRESCRIPTIONS TABLE (1:1 with Appointments)
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT UNIQUE,
    medication_details TEXT NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);


--MOCK DATA FOR THE FOR CLINIC SYSTEM

-- Insert Patients
INSERT INTO Patients (name, date_of_birth, gender, phone) VALUES
('Amina Ali', '1985-03-21', 'Female', '0712345678'),
('John Mwangi', '1992-11-10', 'Male', '0723456789'),
('Fatima Noor', '2001-05-17', 'Female', '0734567890');

-- Insert Doctors
INSERT INTO Doctors (name, phone, email) VALUES
('Dr. Hassan Abdi', '0745678901', 'h.abdi@clinic.com'),
('Dr. Jane Wambui', '0756789012', 'j.wambui@clinic.com');

-- Insert Specializations
INSERT INTO Specializations (specialty_name) VALUES
('Cardiology'),
('Pediatrics'),
('Dermatology');

-- Link Doctors to Specializations
INSERT INTO Doctor_Specialization (doctor_id, specialization_id) VALUES
(1, 1),  -- Dr. Hassan → Cardiology
(2, 2),  -- Dr. Jane → Pediatrics
(2, 3);  -- Dr. Jane → Dermatology

-- Insert Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason) VALUES
(1, 1, '2025-07-28 10:00:00', 'Chest pain and fatigue'),
(2, 2, '2025-07-28 14:00:00', 'Skin rash'),
(3, 2, '2025-07-29 09:30:00', 'Child vaccination');

-- Insert Prescriptions
INSERT INTO Prescriptions (appointment_id, medication_details) VALUES
(1, 'Atenolol 50mg once daily for blood pressure'),
(2, 'Hydrocortisone cream twice daily'),
(3, 'MMR vaccine, oral rehydration salts');
