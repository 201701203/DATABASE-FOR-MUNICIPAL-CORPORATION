CREATE OR REPLACE FUNCTION payment_Ef()
RETURNS TRIGGER AS $paymentef$
BEGIN
	UPDATE property SET tax='0' WHERE proid=NEW.property;
	UPDATE property SET	paidstatus='paid' WHERE proid=NEW.property;
	RETURN NEW;
END;
$paymentef$ LANGUAGE 'plpgsql';

CREATE TRIGGER property AFTER INSERT ON payment
FOR EACH ROW EXECUTE PROCEDURE payment_Ef();