use dsa5003;


CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Phone VARCHAR(20),
    Address VARCHAR(255),
    RegistrationDate DATE
);

describe patient;

CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    DoctorName VARCHAR(150),
    Specialty VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(150)
);

CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Treatment (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    Diagnosis VARCHAR(255),
    TreatmentDetails TEXT,
    TreatmentDate DATE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

CREATE TABLE Medicine (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    MedicineName VARCHAR(150),
    Description VARCHAR(255),
    UnitPrice DECIMAL(10,2),
    StockQuantity INT
);

CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    TreatmentID INT,
    MedicineID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Days INT,
    FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID),
    FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID)
);

CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    TotalAmount DECIMAL(10,2),
    PaidAmount DECIMAL(10,2),
    DueAmount DECIMAL(10,2),
    BillDate DATE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);


CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT,
    PaymentMethod VARCHAR(50),
    PaymentDate DATE,
    AmountPaid DECIMAL(10,2),
    FOREIGN KEY (BillID) REFERENCES Billing(BillID)
);

