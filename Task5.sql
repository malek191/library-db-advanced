-- Task 5 Examples

-- EXAMPLE 1
-- Invalid return_date
UPDATE Loans
SET return_date = '2025-01-09'  -- Earlier than loan_date = '2025-01-10'
WHERE loan_id = 'aok#306';
-- Output:
-- ERROR 1644 (45000): Return date cannot be earlier than the loan date.


-- EXAMPLE 2
-- Valid return_date
UPDATE Loans
SET return_date = '2025-01-25'  -- Later than loan_date = '2025-01-10'
WHERE loan_id = 'aok#306';
-- Output:
-- Query OK, 1 row affected (0.002 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

-- Example 2 Clean up:
-- UPDATE Loans
-- SET return_date = '2025-03-16'  -- Original return_date
-- WHERE loan_id = 'aok#306';