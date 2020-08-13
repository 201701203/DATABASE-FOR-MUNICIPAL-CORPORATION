create or replace function compute_tax() returns void as $body$
declare 
	pro1 property%rowtype;
	pro2 propertyusesServices%rowtype;
	ser  services%rowtype;
	val float;
begin

	for pro1 in select * from property loop
		val:= pro1.tax;
		if pro1.type = 'House' then
			val = val + pro1.span*1.6;
		else
			val = val + pro1.span*3.0;
		end if;

		for pro2 in select * from propertyusesServices loop
			if pro1.proid = pro2.proid then
				for ser in select * from services loop
					if pro2.serviceid = ser.serviceid then
						val = val + pro2.units*ser.service_charge;
					end if;
				end loop;
			end if;
		end loop;
		update property set tax = val  where pro1.proid=proid;
	end loop;

end
$body$ language 'plpgsql';
select * from compute_tax();