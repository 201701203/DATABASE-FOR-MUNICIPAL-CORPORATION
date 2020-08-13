--Calculate the percentage of citizens have taken welfare scheme who are eligible

select schemeno,schemename,(et)*100/ee as ratio from
(
	select count(citizenid) as ee,schemeno,schemename from
	(
		select citizenid,EXTRACT(YEAR FROM age(cast(dob as date))) as age,family_income from
		(
			select inc.citizenA,sum(income) as family_income
				from
				(
					(select citizenA,citizenB,income from ((select citizenA,citizenB from citizen join relatedto on citizenA=citizenID) as r1 join citizen on citizen.citizenid=r1.citizenb))
						union
					(select citizenid as citizenA,citizenid,income from citizen as c1 natural join citizen as c2)
				)as inc
			group by inc.citizenA
		) 
		as fc join citizen on fc.citizenA=citizenid
	)
	as f1 join welfare_scheme on (family_income < family_income_limit and age > lowerage and age < upperage) group by schemeno
) as r11
natural join
( 
	select count(citizenid) as et,schemeid as schemeno from taken group by schemeid
) as r12