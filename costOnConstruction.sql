CREATE OR REPLACE FUNCTION cost_of_construction()
RETURNS TRIGGER AS $CostonConstruction$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE expenses SET amount=amount+NEW.cost WHERE year=NEW.year;
		RETURN NEW;
	ELSIF TG_OP='UPDATE' THEN
		UPDATE expenses SET amount=amount+NEW.cost-OLD.cost WHERE year=NEW.year;
		RETURN NEW;
	ELSIF TG_OP='DELETE' THEN
		UPDATE expenses SET amount=amount-OLD.cost WHERE year=OLD.year;
		RETURN NEW;
	END IF;
END;
$CostonConstruction$ LANGUAGE 'plpgsql';

CREATE TRIGGER Expenses AFTER INSERT OR UPDATE OR DELETE ON costOnConstruction
FOR EACH ROW EXECUTE PROCEDURE cost_of_construction();