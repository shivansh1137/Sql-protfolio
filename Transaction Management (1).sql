CREATE DATABASE banking_system;
USE banking_system;

CREATE TABLE account (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    balance INT
);

CREATE TABLE bank_transaction (
    txn_id INT PRIMARY KEY,
    from_account INT,
    to_account INT,
    amount INT,
    txn_date DATE
);

-- Fixed: Use single quotes for strings and commas between value sets
INSERT INTO account VALUES
(101, 'Ravi', 5000),
(102, 'Neha', 3000),
(103, 'Manjeet', 6000),
(104, 'Suresh', 4500);

-- Scenario 1: Successful Transfer (COMMIT)
START TRANSACTION;
UPDATE account SET balance = balance - 1000 WHERE account_id = 101;
UPDATE account SET balance = balance + 1000 WHERE account_id = 102;
INSERT INTO bank_transaction VALUES (1, 101, 102, 1000, CURDATE());
COMMIT;

-- Scenario 2: Failed/Invalid Transfer (ROLLBACK)
START TRANSACTION;
UPDATE account SET balance = balance - 7000 WHERE account_id = 101;
INSERT INTO bank_transaction VALUES (2, 101, 102, 7000, CURDATE());
-- We rollback because Ravi doesn't have 7000 (Insufficient funds logic)
ROLLBACK;

SELECT * FROM account;
SELECT * FROM bank_transaction;