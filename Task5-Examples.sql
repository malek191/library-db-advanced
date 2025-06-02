-- Task 5: Create Trigger EnforceReturnDate to prevent updating a loan record with a return date earlier than the loan date. This should cause insert to fail.

DELIMITER //

CREATE TRIGGER EnforceReturnDate
BEFORE UPDATE ON Loans
FOR EACH ROW
BEGIN
    -- Check if the new return_date is earlier than the loan_date
    IF NEW.return_date < NEW.loan_date THEN
        -- Raise an error and prevent the update
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Return date cannot be earlier than the loan date.';
    END IF;
END //

DELIMITER ;
