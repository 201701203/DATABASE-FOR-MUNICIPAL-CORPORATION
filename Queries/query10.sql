--List all the departments with their yearly expenses.

select d.dname, r4.year, r4.cost
from department as d
inner join (select departmentid, year, cost 
			from (select r1.cost, s.departmentid, r1.year 
				  from services as s 
				  inner join (select r.resourceid, r.cost, ru.serviceid, r.year
							  from resourcesused as ru
							  inner join costonresource as r 
							  on r.resourceid=ru.resourceid) as r1 
				  on r1.serviceid=s.serviceid) as r2
			union 
			select departmentid, year, cost
			from (select cc.cost, c.departmentid, cc.year 
				  from construction as c
				  inner join costonconstruction as cc
				  on c.constructionid=cc.constructionid) as r3 ) as r4
on r4.departmentid=d.d_id
order by d.d_id,r4.year asc;