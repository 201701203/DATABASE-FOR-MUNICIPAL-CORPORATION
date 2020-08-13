create or replace function compute_penalty() returns void as $body$
declare 
	pro1 property%rowtype;
	val float;
	size int;
begin

	for pro1 in select * from property loop
		val:= pro1.tax;
		if pro1.paidstatus = 'unpaid' then
			val = val + val*0.1;
			BEGIN  
				size = count(penaltyid);
				insert into penalty (penaltyid,amount,propertyid) values(size+1,val,pro1.proid); 
			END;  
		end if;
		update property set tax = val  where pro1.proid=proid;
	end loop;

end
$body$ language 'plpgsql';
select * from compute_penalty();	