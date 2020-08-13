--Find out which citizens have penalties? Also show their Citizen ID and Income, number of penalties and Total_Amount.

select c.citizenid,c.f_name, c.income, count(r1.amount) as No_of_penalties, SUM(r1.amount) as Total_Amount
from citizen as c
inner join (select pr.owner,p.propertyid,p.amount
			from penalty as p
			inner join property as pr
			on pr.proid=p.propertyid) as r1
on c.citizenid=r1.owner
group by c.f_name, c.citizenid, c.income
order by No_of_penalties desc;