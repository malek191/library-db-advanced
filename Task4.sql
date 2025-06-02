-- Task 4: Create Stored Procedure ProcessReturn to update a loan record to the current date when a book is returned and, if overdue, record a fine.
DELIMITER //

CREATE PROCEDURE ProcessReturn(
    IN p_loan_id VARCHAR(10),  -- Match the length of loan_id in Loans table
    IN p_daily_fine_rate DECIMAL(10, 2),
    OUT p_status INT
)
BEGIN
    DECLARE v_return_date DATE;
    DECLARE v_due_date DATE;
    DECLARE v_fine_amount DECIMAL(10, 2);
    DECLARE v_loan_exists INT;

    -- Check if the loan exists
    SELECT COUNT(*) INTO v_loan_exists
    FROM Loans
    WHERE loan_id = p_loan_id;

    -- If the loan does not exist, return -1 (failure)
    IF v_loan_exists = 0 THEN
        SET p_status = -1;
    ELSE
        -- Get the due_date for the loan
        SELECT due_date INTO v_due_date
        FROM Loans
        WHERE loan_id = p_loan_id;

        -- Set the return_date to the current date
        SET v_return_date = CURDATE();

        -- Update the return_date in the Loans table
        UPDATE Loans
        SET return_date = v_return_date
        WHERE loan_id = p_loan_id;

        -- Check if the book is overdue
        IF v_return_date > v_due_date THEN
            -- Calculate the fine amount
            SET v_fine_amount = DATEDIFF(v_return_date, v_due_date) * p_daily_fine_rate;

            -- Insert the fine into the Fines table
            INSERT INTO Fines (loan_id, amount, paid_date)
            VALUES (p_loan_id, v_fine_amount, NULL);
        END IF;

        -- Return 0 (success)
        SET p_status = 0;
    END IF;
END //

DELIMITER ;
