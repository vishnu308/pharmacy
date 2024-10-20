-- insert first record into orders table 
INSERT INTO orders(order_id, customer_id, pharmacist_id, order_date) 
values (101, 10, 2, sysdate); -- one row inserted


-- insert into order_details table, before that lets check inventory 

select * from inventory;

-- LETS ORDER DRUG WITH ID = 1 ITS  QUANTITY_IN_STOCK IS  100.

SELECT * FROM ORDER_DETAILS;

INSERT INTO order_details(order_details_id, order_id, drug_id, quantity, price, total_price)
values (1001, 101,1,2,10,20); -- one row inserted 

select * from order_details;

-- lets check if the inventory table got updated or not

select * from inventory;

-- Inventory got updated .

-- lets order something more, this time lets order 200 drugs with id 2 , drug  2 quantity_in_stock is 150.

INSERT INTO order_details(order_details_id, order_id, drug_id, quantity, price, total_price)
values (1002, 101,2,200,25,500);

/*
Error starting at line : 27 in command -
INSERT INTO order_details(order_details_id, order_id, drug_id, quantity, price, total_price)
values (1002, 101,2,200,25,500)
Error report -
ORA-20001: Insufficient stock for this drug
ORA-06512: at "VISHNU.INVENTORY_UPDATE", line 17
ORA-04088: error during execution of trigger 'VISHNU.INVENTORY_UPDATE'
*/

--Conclusion:  the trigger is working properly.


-- Problem 2nd:  we have to manually enter the unit_price and total price, lets check if we can automate this task. 

SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER auto_price_fetch
BEFORE INSERT ON order_details
FOR EACH ROW

DECLARE
    v_unit_price NUMBER;

BEGIN
    -- Fetch the unit price from the drugs table
    SELECT price_per_unit 
    INTO v_unit_price
    FROM drugs
    WHERE drug_id = :NEW.drug_id;
    
    -- Set the price and total_price in the order_details row being inserted
    :NEW.price := v_unit_price;
    :NEW.total_price := :NEW.quantity * v_unit_price;

END;
/


-- lets insert a second order
INSERT INTO orders(order_id, customer_id, pharmacist_id, order_date) 
values (102, 6, 2, sysdate); -- one row inserted



INSERT INTO order_details(order_details_id, order_id, drug_id, quantity)
values (1002, 102,6,5); -- one row inserted 

SELECT * FROM order_details; -- the price and total_price are fetched automatically 

select * from drugs where drug_id = 6;

--