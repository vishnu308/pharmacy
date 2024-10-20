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
