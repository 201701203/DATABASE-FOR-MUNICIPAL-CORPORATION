--Find out which employees have penalties? Also show their Citizen ID and Income.

select c.citizenid,c.f_name, c.income, SUM(r2.amount)
from citizen as c
inner join (select r1.owner, r1.amounts
			from employee as e
			inner join (select pr.owner,p.propertyid,p.amount
						from penalty as p
						inner join property as pr
						on pr.proid=p.propertyid) as r1
			on r1.owner=e.citizenid ) as r2
on c.citizenid=r2.owner
group by c.f_name, c.citizenid, c.income;