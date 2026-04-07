use dsa5003;

/* 
Scenario 1: Patient Appointment Tracking
Question: Which patients have upcoming scheduled appointments, and with which doctors?
Perspective: Enables efficient scheduling, smooth patient flow, reduced wait times, and better coordination of doctor availability for optimized daily operations.
*/

SELECT 
    p.FirstName, p.LastName, d.DoctorName, d.Specialty, a.AppointmentDate, a.AppointmentTime, a.Status
FROM appointment a
JOIN patient p ON a.PatientID = p.PatientID
JOIN doctor d ON a.DoctorID = d.DoctorID
WHERE a.Status = 'Scheduled' AND MONTH(a.AppointmentDate) = 3
ORDER BY a.AppointmentDate, a.AppointmentTime;



/* 
Scenario 2: Outstanding Payment Follow-Up
Question: Which patients still have unpaid bills (DueAmount > 0)?
Perspective: Supports efficient payment recovery by helping finance track unpaid bills and prioritize follow-up actions.
*/

SELECT 
    p.FirstName, p.LastName, b.TotalAmount, b.PaidAmount, b.DueAmount, b.BillDate
FROM billing b
JOIN appointment a ON b.AppointmentID = a.AppointmentID
JOIN patient p ON a.PatientID = p.PatientID
WHERE b.DueAmount > 0
ORDER BY b.DueAmount DESC;

/* 
Scenario 3: Doctor Workload Analysis
Question: How many appointments does each doctor have in March?
Perspective: Enables management to monitor doctor workload and adjust scheduling for balanced staff utilization.
*/

SELECT 
    d.DoctorName,
    d.Specialty,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM appointment a
JOIN doctor d ON a.DoctorID = d.DoctorID
WHERE a.AppointmentDate BETWEEN '2024-03-01' AND '2024-03-31'
GROUP BY d.DoctorID, d.DoctorName, d.Specialty
ORDER BY TotalAppointments DESC;


/*
Scenario: Monthly Revenue Tracking
Question: How much total revenue did the hospital collect each month?
Perspective: Helps finance and management analyze cash flow trends, identify strong/weak months, plan budgets, and support financial reporting.
*/

SELECT
    DATE_FORMAT(PaymentDate, '%Y-%m') AS Month,
    SUM(AmountPaid) AS Total_Revenue
FROM payment
WHERE PaymentDate IS NOT NULL
GROUP BY DATE_FORMAT(PaymentDate, '%Y-%m')
ORDER BY MIN(PaymentDate);




/* 
Scenario 5: Patient Treatment History
Question: What treatments has a specific patient received?
Business Perspective: Ensures doctors have complete patient history for accurate diagnosis and continuity of care.
*/

SELECT 
    t.TreatmentID, t.Diagnosis, t.TreatmentDetails, t.TreatmentDate, d.DoctorName
FROM treatment t
JOIN appointment a ON t.AppointmentID = a.AppointmentID
JOIN doctor d ON a.DoctorID = d.DoctorID
WHERE a.PatientID = 100
ORDER BY t.TreatmentDate DESC;


/* 
Scenario 6: Low Medicine Stock Alert
Question:Which medicines are low in stock?
Business Perspective: Allows pharmacy to prevent stockouts through proactive reordering of low-quantity medicines.
*/

SELECT 
    MedicineName, StockQuantity
FROM medicine
WHERE StockQuantity < 100
ORDER BY StockQuantity ASC;

/* 
Scenario 7: Patient Full Billing Summary
Question: Show total charge, paid amount, and due for all patients.
Perspective: Gives finance a consolidated view of patient charges, payments, and dues for clear billing management.
*/

SELECT 
    p.FirstName, p.LastName, b.TotalAmount, b.PaidAmount, b.DueAmount, b.BillDate
FROM billing b
JOIN appointment a ON b.AppointmentID = a.AppointmentID
JOIN patient p ON a.PatientID = p.PatientID
ORDER BY b.BillDate DESC;



/* 
Scenario 8: Full Patient Visit Summary
Perspective:Delivers a comprehensive patient journey overview to improve coordination across departments and enhance service quality.
*/

SELECT 
    p.PatientID, p.FirstName, p.Gender, p.Phone, 
    a.AppointmentID, a.AppointmentDate, a.AppointmentTime,
    d.DoctorName, d.Specialty,
    t.TreatmentID,t.Diagnosis, t.TreatmentDetails, t.TreatmentDate,
    m.MedicineName,
    pr.Dosage, pr.Frequency, pr.Days,
    b.BillID, b.TotalAmount, b.PaidAmount,
    pay.PaymentID, pay.PaymentMethod
FROM patient p
LEFT JOIN appointment a ON p.PatientID = a.PatientID
LEFT JOIN doctor d ON a.DoctorID = d.DoctorID
LEFT JOIN treatment t ON a.AppointmentID = t.AppointmentID
LEFT JOIN prescription pr ON t.TreatmentID = pr.TreatmentID
LEFT JOIN medicine m ON pr.MedicineID = m.MedicineID
LEFT JOIN billing b ON a.AppointmentID = b.AppointmentID
LEFT JOIN payment pay ON b.BillID = pay.BillID
WHERE p.PatientID > 110
ORDER BY a.AppointmentDate, t.TreatmentDate, pay.PaymentDate;



/* 
Scenario 9: Patient No-Show Analysis
Question: Which patients booked appointments but never arrived (Status = 'No Show')?
Perspective: By identifying patients who frequently miss appointments, the hospital can apply targeted strategies—such as reminder calls, 
SMS alerts, or controlled overbooking—to minimize time loss and improve operational efficiency.
*/


SELECT
    a.AppointmentID, p.PatientID,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    d.DoctorName, a.AppointmentDate, a.AppointmentTime
FROM appointment a
JOIN patient p ON a.PatientID = p.PatientID
JOIN doctor d ON a.DoctorID = d.DoctorID
WHERE a.Status = 'No-Show'
ORDER BY a.AppointmentDate DESC;
    

/*
Scenario 10: Payment Method Popularity
Question: Which payment method (Cash, Card, Mobile Banking) is used the most?
Perspective: Helps hospital decide which payment systems to invest in or promote.
*/

SELECT 
    PaymentMethod,
    COUNT(*) AS UsageCount
FROM Payment
GROUP BY PaymentMethod
ORDER BY UsageCount DESC;









