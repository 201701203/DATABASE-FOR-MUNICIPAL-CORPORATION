--Extract the area with the money spent on public propert and arrange them in descending order

select r1.pincode, SUM(r1.cost) as s from
(select p.pincode, c.constructionid, c.cost
from publicproperty as p
inner join costonconstruction as c
on p.established=c.constructionid) as r1
group by r1.pincode
order by s desc;