create schema Municipal_Corporation;

set search_path to Municipal_Corporation;

Create table citizen
(
	citizenID integer primary key,
	F_name varchar(20) not null,
	M_name varchar(20),
	L_name varchar(20) not null,
	Gender char(1) not null,
	DoB date not null,
	House_no varchar(10) not null,
	Society text,
	Pincode varchar(6) not null,
	Income integer
);

create table contacts
(
	citizenID integer,
	contact_no char(12),
	foreign key(citizenID) references citizen(citizenID) on delete cascade,
	primary key(citizenID,contact_no)
);

create table RelatedTo
(
	CitizenA integer,
	CitizenB integer,
	foreign key(CitizenA) references Citizen(CitizenID)
	on delete cascade on update cascade,
	foreign key(CitizenB) references Citizen(CitizenID)
	on delete cascade on update cascade,
	relation varchar(10) not null,
	primary key(CitizenA,CitizenB)
);


create table Welfare_scheme
(
	schemeNo integer primary key,
	schemeName text not null,
	Family_Income_Limit integer,
	lowerage integer,
	upperage integer,
	Description text
);

create table taken
(
	citizenID integer,
	schemeid integer,
	foreign key(CitizenID) references Citizen(CitizenID)
	on delete cascade on update cascade,
	foreign key(SchemeID) references welfare_scheme(schemeNo)
	on delete cascade on update cascade,
	primary key(CitizenID,SchemeID)
);


create table property
(
	ProID integer primary key,
	type varchar(20) not null,
	span float not null,
	TAX float not null,
	DueDate date not null,
	paidStatus varchar(20) DEFAULT 'Unpaid',
	owner integer,
	foreign key(owner) references Citizen(CitizenID)
	on delete cascade on update cascade
);


create table Payment
(
	PaymentID integer primary key,
	method varchar(15) not null,
	amount float not null,
	pDate date not null,
	paidby integer,
	Property integer,
	foreign key(paidBy) references Citizen(CitizenID)
	on delete cascade on update cascade,
	foreign key(Property) references Property(ProID)
	on delete cascade on update cascade
);

create table Penalty
(
	PenaltyID integer primary key,
	description text,
	amount float not null,
	PropertyID integer,
	foreign key(PropertyID) references Property(ProID)
	on delete cascade on update cascade
);

create table department
(
	D_ID integer primary key,
	Dname varchar(30) not null
);

create table services
(
	ServiceID integer primary key,
	Name varchar(40) not null,
	Service_charge float not null,
	Description text,
	departmentid integer,
	foreign key(DepartmentID) references department(D_ID)
	on delete cascade on update cascade
);

create table PropertyUsesServices
(
	proid integer,
	serviceid integer,
	Units integer,
	foreign key(ProID) references property(ProID)
	on delete cascade on update cascade,
	foreign key(ServiceID) references Services(ServiceID)
	on delete cascade on update cascade,
	primary key(ProID,ServiceID)
);

create table Complains
(
	ComplaintID integer primary key,
	description text,
	cDate date not null,
	serviceid integer,
	cstatus varchar(10),
	foreign key(ServiceID) references Services(ServiceID)
	on delete cascade on update cascade
);

create table peopleHaveComplains
(
	citizenid integer,
	complaintid integer,
	foreign key(CitizenID) references Citizen(CitizenID)
	on delete cascade on update cascade,
	foreign key(ComplaintID) references complains(ComplaintID)
	on delete cascade on update cascade,
	primary key(CitizenID,ComplaintID)
);

create table Employee
(
	ssn integer primary key,
	salary integer not null,
	joining_date date,
	superssn integer,
	citizenid integer,
	departmentid integer,
	foreign key(superssn) references Employee(ssn)
	on delete cascade on update cascade,
	foreign key(CitizenID) references Citizen(CitizenID)
	on delete cascade on update cascade,
	foreign key(DepartmentID) references department(D_ID)
	on delete cascade on update cascade
);

create table dependents
(
	essn integer,
	foreign key(essn) references Employee(ssn)
	on delete cascade on update cascade,
	name varchar(20),
	gender char(1) not null,
	DoB date not null,
	Relation varchar(20) not null,
	primary key(essn,name)
);

create table privilege
(
	pName varchar(40) primary key,
	Description text not null
);

create table DependentsHave
(
	essn integer,
	name varchar(20),
	pname varchar(40),
	foreign key(essn,name) references dependents(essn,name)
	on delete cascade on update cascade,
	foreign key(pName) references privilege(pName)
	on delete cascade on update cascade,
	primary key(essn,Name,pName)
);


create table Expenses
(
	Year integer primary key,
	amount integer
);

create table Resources
(
	Resource_ID integer primary key,
	type varchar(30) not null,
	Quantity integer not null,
	Description text
);

create table ResourcesUsed
(
	serviceid integer,
	resourceid integer,
	foreign key(ServiceID) references Services(ServiceID)
	on delete cascade on update cascade,
	foreign key(ResourceID) references Resources(Resource_ID)
	on delete cascade on update cascade,
	primary key(serviceID,ResourceID)
);

create table costOnResource
(
	year integer,
	resourceid integer,
	foreign key(year) references expenses(year)
	on delete cascade on update cascade,
	foreign key(ResourceID) references Resources(Resource_ID)
	on delete cascade on update cascade,
	cost integer not null,
	primary key(year,ResourceID)
);

create table company
(
	CompanyName varchar(40) primary key,
	contactPersonName varchar(40) not null,
	contactNo varchar(15) not null
);


create table Phase
(
	PhaseNO integer primary key,
	PhaseName varchar(40) not null
);


create table construction
(
	constructionID integer primary key,
	Cname varchar(40) not null,
	S_date Date not null,
	E_date Date,
	company_name varchar(40),
	departmentid integer,
	PhaseNo integer,
	foreign key(company_name) references company(CompanyName)
	on delete cascade on update cascade,
	foreign key(DepartmentID) references department(D_ID)
	on delete cascade on update cascade,	
	foreign key(PhaseNo) references Phase(PhaseNo)
	on delete cascade on update cascade
);

create table costOnConstruction
(
	constructionid integer,
	year integer,
	foreign key(ConstructionID) references Construction(ConstructionID)
	on delete cascade on update cascade,
	foreign key(year) references expenses(year)
	on delete cascade on update cascade,
	cost integer not null,
	primary key(year,ConstructionID)
);

create table PublicProperty
(
	PPID integer primary key,
	PPname varchar(40) not null,
	Type text not null,
	Street text,
	Landmark text not null,
	Pincode char(6) not null,
	established integer,
	foreign key(Established) references construction(constructionID)
	on delete cascade on update cascade
);

create table PPmaintain
(
	ppid integer,
	departmentid integer,
	foreign key(PPID) references PublicProperty(PPID)
	on delete cascade on update cascade,
	foreign key(DepartmentID) references department(D_ID)
	on delete cascade on update cascade,
	primary key(PPID,DepartmentID)
);

create table Renovation_Rebuild
(
	ppid integer,
	constructionid integer,
	foreign key(PPID) references PublicProperty(PPID)
	on delete cascade on update cascade,
	foreign key(ConstructionID) references construction(constructionID)
	on delete cascade on update cascade,
	primary key(PPID,ConstructionID)
);