--Which department has complaints left unsolved or in progress? Also count the number of complaints

select d.dname,count(r1.complaintid)
from department as d
inner join (select s.departmentid,c.cstatus,c.complaintid
			from services as s
			inner join complains as c
			on s.serviceid=c.serviceid
			where cstatus='unsolved' or cstatus='progress') as r1
on r1.departmentid=d.d_id
group by d.dname;