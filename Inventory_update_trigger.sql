SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER inventory_update 
AFTER INSERT ON order_details 
FOR EACH ROW

DECLARE
    current_stock NUMBER;  -- Declare a variable to store the current stock

BEGIN
    -- Update the inventory table to reduce the stock quantity
    UPDATE inventory 
    SET inventory.quantity_in_stock = inventory.quantity_in_stock - :NEW.quantity
    WHERE inventory.drug_id = :NEW.drug_id;

    -- Retrieve the updated stock quantity
    SELECT quantity_in_stock INTO current_stock
    FROM inventory
    WHERE drug_id = :NEW.drug_id;

    -- Check if the updated stock is less than zero, and raise an error if it is
    IF current_stock < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for this drug');
    END IF;

END;
/