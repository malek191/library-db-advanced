-- Task 3 Examples

-- Successful
CALL IssueLoan('#21', 'A8', '2023-10-01', '2023-10-15', @status);
SELECT @status AS status;
-- Expected Output 0
-- DELETE FROM Loans WHERE loan_id = '1'; //Clean up

-- Failure (Book unavailable)
CALL IssueLoan('#22', 'A8', '2023-10-01', '2023-10-15', @status);
SELECT @status AS status;
-- Expected Output -1

--  Failure (Book or Member Does Not Exist)
CALL IssueLoan('#99', 'B999', '2023-10-01', '2023-10-15', @status);
SELECT @status AS status;
-- Expected Output -2