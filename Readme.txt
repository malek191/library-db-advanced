Malek Moussa
NZ85414

Summary of Learning:
--------------------
• I learned how to create and use stored procedures in MariaDB to automate database tasks.

• I gained experience in writing triggers to enforce business rules, such as preventing invalid updates to the `Loans` table.

• I practiced debugging SQL errors, such as foreign key constraint violations and data type mismatches.

• I improved my understanding of SQL query optimization and error handling.



Challenges Faced and How They Were Addressed:
---------------------------------------------
1. Foreign Key Constraint Errors:
   - I encountered errors when inserting records into the `Loans` table due to missing `book_id` or `member_id` values in the referenced tables.
   - I addressed this by validating the existence of `book_id` and `member_id` before performing the insert operation in the stored procedure.

2. Trigger Errors:
   - While testing the `EnforceReturnDate` trigger, I initially struggled to understand why updates were failing.
   - I resolved this by carefully reviewing the trigger logic and testing with both valid and invalid data to ensure the trigger behaved as expected.

3. Debugging SQL Errors:
   - I faced issues with data type mismatches (e.g., `VARCHAR` length errors) when calling stored procedures.
   - I fixed this by ensuring that the input parameters matched the column definitions in the database tables.



Additional Input for Grader:
----------------------------
✦ Folders are numbered Task1-5, with each folder containing the Task.sql file and the Examples.sql file for that specific task.

✦ The SQL dump folder contains a file with all the commands for a full import, if preferred.