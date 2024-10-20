-- Customer Table 

CREATE TABLE customer(
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(30),
    last_name VARCHAR2(30),
    contact_number NUMBER,
    address VARCHAR2(100)
);



-- Pharmacist Table

CREATE TABLE pharmacist(
    pharmacist_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(30),
    last_name VARCHAR2(30),
    contact_number NUMBER,
    email VARCHAR2(60),
    address VARCHAR2(160),
    licence_number VARCHAR2(50)
);



-- DRUGS

CREATE TABLE drugs(
    drug_id NUMBER PRIMARY KEY,
    drug_name VARCHAR2(50),
    description VARCHAR2(150),
    price_per_unit NUMBER,
    expiry_date DATE
);



-- INVENTORY TABLE

CREATE TABLE inventory(
    inventory_id NUMBER PRIMARY KEY,
    drug_id NUMBER,
    quantity_in_stock NUMBER,
    reorder_level NUMBER,
    last_updated DATE,
    FOREIGN KEY (drug_id) REFERENCES drugs(drug_id)
);



-- orders table

CREATE TABLE orders(
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    pharmacist_id NUMBER,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (pharmacist_id) REFERENCES pharmacist(pharmacist_id)
);





-- orderdetails table


CREATE TABLE order_details(
    order_details_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    drug_id NUMBER,
    quantity NUMBER,
    price NUMBER,
    total_price NUMBER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (drug_id) REFERENCES drugs(drug_id)
);




