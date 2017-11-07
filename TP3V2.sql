drop table student;
drop table Course;
drop table sc;

create table student(
sno char(5) primary key,           
sname varchar(10) unique,          
ssex char(2) not null,              
sage number(3) default 0,           
sdept varchar(10));

create table Course(
cno char(3) primary key,          
cname varchar2(15) not null,            
cpno char(3),              
ccredit number(1));  


create table sc(
sno char(5),
cno char(3) ,            
grade number(3) check (grade<=100 and grade>=0),
primary key(sno,cno),
CONSTRAINT FK_sno  
  FOREIGN KEY (sno)
  REFERENCES student(sno),
  CONSTRAINT FK_cno  
  FOREIGN KEY (cno)
  REFERENCES course(cno)
  );
 
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s1', 'sn1', 'm', '19', 'cs');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s2', 'sn2', 'f', '20', 'cs');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s3', 'sn3', 'm', '20', 'is');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s4', 'sn4', 'm', '10', 'is');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s5', 'sn5', 'f', '22', 'en');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s6', 'ssn6', 'm', '23', 'is');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s7', 'ssn7', 'f', '22', 'cs');
  
INSERT INTO COURSE (CNO, CNAME, CCREDIT) VALUES ('c01', 'cn1', '2');
INSERT INTO COURSE (CNO, CNAME, CPNO, CCREDIT) VALUES ('c02', 'cn2', 'c01', '1');
INSERT INTO COURSE (CNO, CNAME, CPNO, CCREDIT) VALUES ('c03', 'cn3', 'c01', '2');
INSERT INTO COURSE (CNO, CNAME, CPNO, CCREDIT) VALUES ('c04', 'cn4', 'c02', '1.5');
INSERT INTO COURSE (CNO, CNAME, CPNO, CCREDIT) VALUES ('c05', 'cn5', 'c01', '2.5');

INSERT INTO SC (SNO, CNO, GRADE) VALUES ('s1', 'c01', '80');
INSERT INTO SC (SNO, CNO, GRADE) VALUES ('s1', 'c02', '85');
INSERT INTO SC (SNO, CNO, GRADE) VALUES ('s2', 'c01', '90');
INSERT INTO SC (SNO, CNO, GRADE) VALUES ('s2', 'c03', '88');
INSERT INTO SC (SNO, CNO, GRADE) VALUES ('s3', 'c02', '89');
INSERT INTO SC (SNO, CNO, GRADE) VALUES ('s3', 'c03', '90');
INSERT INTO SC (SNO, CNO, GRADE) VALUES ('s4', 'c01', '92');

--2-1
create view INFORMATION(SNO, SNAME, SSEX, SAGE, SDEPT)
as
select *
from STUDENT where SDEPT = 'is';
select * from INFORMATION;
insert into INFORMATION (SNO, SNAME, SSEX, SAGE, SDEPT) values ('s7', 'ssn7', 'f', '22', 'cs');

--2-2
create view INFORMATION2(SNO, SNAME, SSEX, SAGE, SDEPT)
as
select *
from STUDENT where SDEPT = 'is'
with check option;
select * from INFORMATION2;
insert into INFORMATION2 (SNO, SNAME, SSEX, SAGE, SDEPT) values ('s7', 'ssn7', 'f', '22', 'cs');

--2-3
create view ISCSB
as 
select student.SNO, student.SNAME, student.SSEX, student.SAGE, student.SDEPT,sc.CNO,sc.GRADE
from student,sc
where student.sno = sc.sno and sc.cno = 'c01' and sc.GRADE >= 90 and sc.CNO = 'is';
select * from ISCSB;

--2-4
create view SG(sno,avg_grade)
as 
select sno,avg(grade)
from sc
group by sno;
select * from SG;

--2-5
create view GOODSC
as
select sno,cno,grade
from sc
where grade >
(select avg(grade) 
from sc);

--3-1
select *
from INFORMATION
where SAGE < 20;

--3-2
select *
from ISCSB
where grade >= 90;

--3.3
select *
from SG
where avg_grade>=90;

--3.4
create view CS_KC
as 