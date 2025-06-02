-- Task 3: Create Stored Procedure IssueLoan to insert a new loan record for a member, ensuring that the book is available.

DELIMITER //

CREATE PROCEDURE IssueLoan(
    IN p_member_id VARCHAR(10),
    IN p_book_id VARCHAR(10),
    IN p_loan_date DATE,
    IN p_due_date DATE,
    OUT p_status INT
)
BEGIN
    DECLARE v_loan_id INT;
    DECLARE v_active_loan_count INT;
    DECLARE v_book_exists INT;
    DECLARE v_member_exists INT;

    -- Check if the book exists
    SELECT COUNT(*) INTO v_book_exists
    FROM Books
    WHERE book_id = p_book_id;

    -- Check if the member exists
    SELECT COUNT(*) INTO v_member_exists
    FROM Members
    WHERE member_id = p_member_id;

    -- If the book or member does not exist, return -2 (failure)
    IF v_book_exists = 0 OR v_member_exists = 0 THEN
        SET p_status = -2;
    ELSE
        -- Check if the book is already issued (i.e., has an active loan)
        SELECT COUNT(*) INTO v_active_loan_count
        FROM Loans
        WHERE book_id = p_book_id AND return_date IS NULL;

        -- If the book is already issued, return -1 (failure)
        IF v_active_loan_count > 0 THEN
            SET p_status = -1;
        ELSE
            -- Compute loan_id as the maximum loan_id + 1
            SELECT COALESCE(MAX(CAST(loan_id AS UNSIGNED)), 0) + 1 INTO v_loan_id
            FROM Loans;

            -- Set loan_date to current date if NULL
            IF p_loan_date IS NULL THEN
                SET p_loan_date = CURDATE();
            END IF;

            -- Set due_date to loan_date + 14 days if NULL
            IF p_due_date IS NULL THEN
                SET p_due_date = DATE_ADD(p_loan_date, INTERVAL 14 DAY);
            END IF;

            -- Insert the new loan record
            INSERT INTO Loans (loan_id, book_id, member_id, loan_date, due_date, return_date)
            VALUES (v_loan_id, p_book_id, p_member_id, p_loan_date, p_due_date, NULL);

            -- Return 0 (success)
            SET p_status = 0;
        END IF;
    END IF;
END //

DELIMITER ;
