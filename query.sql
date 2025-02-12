SELECT 
    Personnel.first_name, 
    Personnel.last_name, 
    Personnel.dob, 
    Personnel.ssn, 
    Personnel.medicare_number, 
    Personnel.telephone_number, 
    Personnel.address,
    Personnel.city,
    Personnel.province ,
    Personnel.postal_code ,
    Personnel.email, 
    Personnel.roles, 
    Personnel.mandate
FROM Personnel 
INNER JOIN PersonnelAssignment 
    ON Personnel.personnel_id = PersonnelAssignment.personnel_id
INNER JOIN ClubLocation 
    ON PersonnelAssignment.location_id = ClubLocation.location_id
WHERE ClubLocation.name = 'Downtown Club'