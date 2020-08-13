--extract the name and conta t no of the company-person whose construction is halted.

select contactpersonname, contactno 
from company 
		inner join ( select r3.company_name 
					from (select r2.phaseno,r2.company_name 
						  from (phase natural join construction) as r2
						  where r2.phasename='Halted') as r3) as r4
					on company.companyname=r4.company_name;