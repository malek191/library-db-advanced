-- Task 1: Create a function ActiveLoanAccount to return the number of active (i.e., not yet returned) loans for a given member. 

-- Set the delimiter to $$ to handle multi-line statements:
DELIMITER $$ 
CREATE FUNCTION ActiveLoanAccount(member_id VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE loan_count INT;
    SELECT COUNT(*) INTO loan_count
    FROM Loans
    WHERE Loans.member_id = member_id AND return_date IS NULL;
    RETURN loan_count;
END$$
DELIMITER ;