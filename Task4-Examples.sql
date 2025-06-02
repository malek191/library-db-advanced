-- Task 1 Examples

-- Successful Return (Not Overdue)
CALL ProcessReturn('aok#458', 1.00, @status);
SELECT @status AS status;
-- Returns 0

-- Successful Return (Overdue)
CALL ProcessReturn('aok#727', 1.00, @status);
SELECT @status AS status;
-- Returns 0

-- Failure (Loan Does Not Exist)
CALL ProcessReturn('invalid', 1.00, @status);  -- Must use a valid VARCHAR(10) input
SELECT @status AS status;
-- Returns -1