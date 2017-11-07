drop table student;

drop table Course;

drop table SC;

--2.1
CREATE TABLE student
(SNO CHAR(5) NOT NULL PRIMARY KEY,
SNAME VARCHAR2(10) UNIQUE,
SSEX CHAR(2) NOT NULL,
SAGE NUMBER(3) DEFAULT 0,
SDEPT VARCHAR2(10));

--student
--(SNO,SNAME,SSEX,SAGE,SDEPT);
--2.2
CREATE TABLE Course
(CNO CHAR(10) NOT NULL,
CNAME VARCHAR2(15) NOT NULL,
CPNO CHAR(10),
CCREDIT NUMBER(1));

--2.3
CREATE TABLE SC
(SNO CHAR(5) NOT NULL,
CNO CHAR(10) NOT NULL,
GRADE NUMBER(3));

--2.4
DESC student;

--2.5
select * from cat;

--3.1
alter table student
add jiguan varchar2(20);

--3.2
alter table student
add timeschool date;

--3.3
alter table Course
modify CNO CHAR(2);
alter table Course
modify CPNO CHAR(2);

alter table SC
modify CNO CHAR(2);

--3.4
alter table student
DROP UNIQUE(SNAME);

--4
CREATE UNIQUE INDEX STUNAME ON student (sname ASC);
CREATE UNIQUE INDEX COURNAME ON Course (CNAME ASC);
CREATE INDEX GRA ON SC(GRADE DESC);
CREATE INDEX SCCNO ON SC(CNO ASC);

--5


--6
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s1', 'sn1', 'm', '19', 'cs');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s2', 'sn2', 'f', '20', 'cs');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s3', 'sn3', 'm', '20', 'is');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s4', 'sn4', 'm', '10', 'is');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s5', 'sn5', 'f', '22', 'en');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s6', 'ssn6', 'm', '23', 'is');
INSERT INTO STUDENT (SNO, SNAME, SSEX, SAGE, SDEPT) VALUES ('s7', 'ssn7', 'f', '22', 'cs');
  
INSERT INTO COURSE (CNO, CNAME, CPNO, CCREDIT) VALUES ('c01', 'cn1','c02',1);
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


--7.1
select * from student;

--7.2
select * from course;

--7.3
select * from sc;

--TP2-5.1对每一个系，求学生的平均年龄，并把结果存入数据库
drop table AveAge;
create table AveAge  --创建新表
(ADEPT VARCHAR2(10),
AVAGE  NUMBER(3) DEFAULT 0
);

select AVG(SAGE)
from student
where SDEPT='cs'
group by SDEPT;

select AVG(SAGE)
from student
where SDEPT='is'
group by SDEPT;

select AVG(SAGE)
from student
where SDEPT='en'
group by SDEPT;

insert into AveAge values('cs',20.33 );
insert into AveAge values('is',17.67);
insert into AveAge values('en',20.00);

select *
from AveAge;

--TP2-5.2将计算机科学系全体学生的成绩置0
update SC
set GRADE=0
where SNO in (select SNO from STUDENT where SDEPT='cs');

select *
from SC;

--TP2-5.3删除计算机科学系所有学生的选课记录
delete from SC
where SNO IN
(select SNO 
from STUDENT
WHERE SDEPT='cs'
);
select * from SC;

--TP2-5.4删除某学生的信息及其选课信息。(注：参照完整性，级联删除)
delete from SC where SNO = 's1';

delete from student where SNO='s1';

select * from student;