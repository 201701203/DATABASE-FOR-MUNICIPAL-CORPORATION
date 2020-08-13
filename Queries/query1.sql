--Extract the Name, house number and society of the citizen who has a complaint regarding water management in area having pincode 398965.

select citizen.f_name, citizen.house_no, citizen.society from citizen inner join 
		 (select peoplehavecomplains.citizenid 
		  from peoplehavecomplains 
		   inner join 
		   (select complaintid
			from complains
			where serviceid='1'
			and cstatus='unsolved') as r1
		 	on r1.complaintid=peoplehavecomplains.complaintid) as r2
		  on r2.citizenid=citizen.citizenid
		  where citizen.pincode='398965';