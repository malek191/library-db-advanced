-- Task 2: Calculate Fine to compute the overdue fine for a specific loan
-- Instructions were unclear on this part, so fines are ONLY calculated if payment has not been made yet.

DELIMITER $$

CREATE FUNCTION CalculateFine(loan_id_param VARCHAR(10), daily_fine_rate DECIMAL(4,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE fine_amount DECIMAL(10,2);
    DECLARE loan_due_date DATE;
    DECLARE return_date DATE;
    DECLARE overdue_days INT;

    -- Get loan details
    SELECT due_date, return_date INTO loan_due_date, return_date
    FROM Loans
    WHERE loan_id = loan_id_param;

    -- If return_date is NULL, consider the current date for overdue calculation
    IF return_date IS NULL THEN
        SET return_date = CURDATE();
    END IF;

    -- Calculate overdue days
    SET overdue_days = DATEDIFF(return_date, loan_due_date);

    -- ONLY If overdue, calculate fine
    IF overdue_days > 0 THEN
        SET fine_amount = overdue_days * daily_fine_rate;
    ELSE
        SET fine_amount = 0.00;
    END IF;

    -- Return calculated fine
    RETURN fine_amount;
END$$

DELIMITER ;
