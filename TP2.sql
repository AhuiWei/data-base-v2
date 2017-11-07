DROP TABLE S CASCADE CONSTRAINT;
DROP TABLE P CASCADE CONSTRAINT;
DROP TABLE J CASCADE CONSTRAINT;
DROP TABLE SPJ CASCADE CONSTRAINT;

create table S
(
	SNO char(3) primary key,
	SNAME char(10),
	STATUS char(2),
	CITY char(10)
);

create table P
(
	PNO char(3) primary key,
	PNAME char(10),
	COLOR char(4),
	WEIGHT int
);

create table J
(
	JNO char(3) primary key,
	JNAME char(10),
	CITY char(10)
);

create table SPJ
(
	SNO char(3),
	PNO char(3),
	JNO char(3),
	QTY int,
	primary key (SNO,PNO,JNO),
	foreign key (SNO) references S (SNO),
	foreign key (PNO) references P (PNO),
	foreign key (JNO) references J (JNO)
);

insert into S values('S1','精益','20','天津');
insert into S values('S2','盛锡','10','北京');
insert into S values('S3','东方红','30','北京');
insert into S values('S4','丰泰盛','30','天津');
insert into S values('S5','为民','30','上海');

insert into P values('P1','螺母','红','12');
insert into P values('P2','螺楦','绿','17');
insert into P values('P3','螺丝刀','蓝','14');
insert into P values('P4','螺丝刀','红','14');
insert into P values('P5','凸轮','蓝','40');
insert into P values('P6','齿轮','红','30');

insert into J values('J1','三建','北京');
insert into J values('J2','一汽','长春');
insert into J values('J3','弹簧厂','天津');
insert into J values('J4','造船厂','天津');
insert into J values('J5','机车厂','唐山');
insert into J values('J6','无线电','常州');
insert into J values('J7','半导体','南京');

insert into SPJ values('S1','P1','J1','200');
insert into SPJ values('S1','P1','J3','100');
insert into SPJ values('S1','P1','J4','700');
insert into SPJ values('S1','P2','J1','100');
insert into SPJ values('S2','P3','J1','400');
insert into SPJ values('S2','P2','J4','200');
insert into SPJ values('S2','P3','J4','500');
insert into SPJ values('S2','P3','J5','400');
insert into SPJ values('S2','P5','J1','400');
insert into SPJ values('S2','P5','J2','100');
insert into SPJ values('S3','P1','J1','200');
insert into SPJ values('S3','P3','J1','200');
insert into SPJ values('S4','P2','J1','100');
insert into SPJ values('S4','P2','J3','300');
insert into SPJ values('S4','P6','J4','200');
insert into SPJ values('S5','P2','J4','100');
insert into SPJ values('S5','P3','J1','200');
insert into SPJ values('S5','P6','J2','200');
insert into SPJ values('S5','P6','J4','500');

--3-1
select SNO
from SPJ
where JNO = 'J1';
--3-2
select SNO
from SPJ
where JNO = 'J1' AND PNO = 'P1';
--3-3
select SPJ.SNO
from SPJ,P
WHERE SPJ.PNO = P.PNO AND JNO = 'J1' AND COLOR = '红';
--3-4
select DISTINCT JNO
from P,S,SPJ
WHERE SPJ.SNO = S.SNO AND 
SPJ.PNO = P.PNO AND 
P.COLOR != '红' AND
S.CITY != '天津';
--3-5
select JNO
FROM SPJ
WHERE SNO = 'S3'
GROUP BY JNO
HAVING COUNT(*)>=6;
--3-6
select SNAME,CITY
FROM S;
--3-7
select PNAME,COLOR,WEIGHT
FROM P;
--3-8
select DISTINCT JNO
FROM SPJ
WHERE SNO = 'S1';
--3-9
select P.PNAME,SPJ.QTY
FROM SPJ,P
WHERE SPJ.PNO = P.PNO AND
JNO = 'J2';
--3-10
select DISTINCT PNO
FROM S,SPJ
WHERE S.SNO = SPJ.SNO AND
S.CITY = '上海';
--3-11
select DISTINCT J.JNAME
FROM S,SPJ,J
WHERE S.SNO = SPJ.SNO AND J.JNO = SPJ.JNO AND
S.CITY = '上海';
--3-12
select DISTINCT SPJ.JNO
FROM S,SPJ
WHERE S.SNO = SPJ.SNO AND
S.CITY != '天津';
--3-13
select S.SNO,S.SNAME,P.PNO,P.PNAME,J.JNO,J.JNAME,SPJ.QTY
FROM S,P,J,SPJ
WHERE S.SNO = SPJ.SNO AND P.PNO = SPJ.PNO AND J.JNO = SPJ.JNO;
--3-14
select SNO,PNO,SUM(QTY)
FROM SPJ
GROUP BY SNO,PNO;

--4.1将全部红色零件的颜色改为蓝色
update p
set color='蓝'
where COLOR='红';
commit work;

select *
from p;

--4.2将工程J3的城市改为上海
update J
set CITY='上海'
where JNO='J3';
commit work;

select *
from J;

--4.3由S5供给J4的零件P6改为由S3供应
update SPJ
set SNO='S3'
where SNO='S5' and PNO='P6';
commit work;

select *
from SPJ;

--4.4从供应商关系中删除S2的元组，并从供应情况关系中删除相应元组(注意原则删除顺序)；
delete from SPJ
where SNO='S2';

delete from S
where SNO='S2';

select *
from S;

--4.5请将S2向工程项目J6供应200个P4零件的信息加入到供应关系中；
insert into S values('S2', '盛锡',10，'北京');    --由于前一问中已经将S2从供应商表S中删除，因此，需要在此处将其重新插入。
insert into SPJ values('S2','P4','J6',200);

select *
from SPJ;

--4.6请将S6向工程项目J8供应500个P7零件的信息加入到供应关系。涉及到向4个表中添加原色操作，顺序如下。
insert into S values('S6',NULL, NULL, NULL);
insert into P values('P7',NULL, NULL, NULL);
insert into J values('J8', NULL, NULL);
insert into SPJ values('S6','P7','J8', 500);
commit work;
select *
from SPJ;

--TP2-5.1对每一个系，求学生的平均年龄，并把结果存入数据库
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

--TP2-5.4删除某学生的信息及其选课信息。(注：参照完整性，级联删除)
delete from SC where SNO = 's1';

delete from student where SNO='s1';
