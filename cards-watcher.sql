CREATE TABLE Banks (
    id SERIAL PRIMARY KEY, -- unique bank id
    bank_name VARCHAR(50) NOT NULL -- bank name
);

CREATE TABLE PaymentStatus (
    id SERIAL PRIMARY KEY, -- unique status id
    status_name VARCHAR(50) NOT NULL -- name of the status (success, pending, overdue)
);

CREATE TABLE Currencies (
    id SERIAL PRIMARY KEY, -- unique currency id
    currency_name VARCHAR(50) NOT NULL -- currency name
);

CREATE TABLE Users (
    id SERIAL PRIMARY KEY, -- unique user id
    user_name VARCHAR(50), -- name/nickname of the user's choice
    login VARCHAR(50) NOT NULL, -- login
    password VARCHAR(200) -- password
);


CREATE TABLE CreditCards (
    id SERIAL PRIMARY KEY, -- unique credit card id
    id_user INTEGER NOT NULL REFERENCES Users(id) ON DELETE CASCADE, -- user identifier
    id_bank INTEGER NOT NULL, -- bank id
    id_currency INTEGER NOT NULL, -- currency id
    card_name VARCHAR(100) NOT NULL, -- card name
    last_four_digit VARCHAR(4) NOT NULL, -- last 4 digits of the map
    limit_amount NUMERIC(10, 2) NOT NULL, -- fund limit set by the bank
    total_debit NUMERIC(10, 2) NOT NULL, -- Total debt amount
    grace_period INTEGER NOT NULL, -- number of days of grace period
    interest_rate NUMERIC(5, 2) NOT NULL, -- interest rate on the card
    statement_day INTEGER NOT NULL CHECK (statement_day >= 1 AND statement_day <= 31), -- Day of the month on which the statement is generated
    FOREIGN KEY (id_user) REFERENCES Users(id),
    FOREIGN KEY (id_bank) REFERENCES Banks(id),
    FOREIGN KEY (id_currency) REFERENCES Currencies(id)
);

CREATE TABLE CreditCardPayments (
    id SERIAL PRIMARY KEY, -- unique payment id
    credit_card_id INTEGER NOT NULL REFERENCES CreditCards(id) ON DELETE CASCADE, -- unique credit card id
    dt_first_payment DATE NOT NULL, -- date of the first payment within the grace period
    bank_dt_payment DATE NOT NULL, -- payment date specified by the bank
    recommend_payment_dt DATE NOT NULL, -- recommended payment date
    calc_dt_full_repayment DATE NOT NULL, -- calculated date of repayment of the entire debt
    amount NUMERIC(10, 2) NOT NULL, -- payment amount
    payment_dt DATE, -- the user indicated that he made the payment on the date
    payment_status_id INTEGER NOT NULL, -- payment status
    description TEXT, -- user comment
    FOREIGN KEY (credit_card_id) REFERENCES CreditCards(id),
    FOREIGN KEY (payment_status_id) REFERENCES PaymentStatus(id)
);