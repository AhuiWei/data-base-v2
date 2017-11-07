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

insert into S values('S1','����','20','���');
insert into S values('S2','ʢ��','10','����');
insert into S values('S3','������','30','����');
insert into S values('S4','��̩ʢ','30','���');
insert into S values('S5','Ϊ��','30','�Ϻ�');

insert into P values('P1','��ĸ','��','12');
insert into P values('P2','���','��','17');
insert into P values('P3','��˿��','��','14');
insert into P values('P4','��˿��','��','14');
insert into P values('P5','͹��','��','40');
insert into P values('P6','����','��','30');

insert into J values('J1','����','����');
insert into J values('J2','һ��','����');
insert into J values('J3','���ɳ�','���');
insert into J values('J4','�촬��','���');
insert into J values('J5','������','��ɽ');
insert into J values('J6','���ߵ�','����');
insert into J values('J7','�뵼��','�Ͼ�');

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
WHERE SPJ.PNO = P.PNO AND JNO = 'J1' AND COLOR = '��';
--3-4
select DISTINCT JNO
from P,S,SPJ
WHERE SPJ.SNO = S.SNO AND 
SPJ.PNO = P.PNO AND 
P.COLOR != '��' AND
S.CITY != '���';
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
S.CITY = '�Ϻ�';
--3-11
select DISTINCT J.JNAME
FROM S,SPJ,J
WHERE S.SNO = SPJ.SNO AND J.JNO = SPJ.JNO AND
S.CITY = '�Ϻ�';
--3-12
select DISTINCT SPJ.JNO
FROM S,SPJ
WHERE S.SNO = SPJ.SNO AND
S.CITY != '���';
--3-13
select S.SNO,S.SNAME,P.PNO,P.PNAME,J.JNO,J.JNAME,SPJ.QTY
FROM S,P,J,SPJ
WHERE S.SNO = SPJ.SNO AND P.PNO = SPJ.PNO AND J.JNO = SPJ.JNO;
--3-14
select SNO,PNO,SUM(QTY)
FROM SPJ
GROUP BY SNO,PNO;

--4.1��ȫ����ɫ�������ɫ��Ϊ��ɫ
update p
set color='��'
where COLOR='��';
commit work;

select *
from p;

--4.2������J3�ĳ��и�Ϊ�Ϻ�
update J
set CITY='�Ϻ�'
where JNO='J3';
commit work;

select *
from J;

--4.3��S5����J4�����P6��Ϊ��S3��Ӧ
update SPJ
set SNO='S3'
where SNO='S5' and PNO='P6';
commit work;

select *
from SPJ;

--4.4�ӹ�Ӧ�̹�ϵ��ɾ��S2��Ԫ�飬���ӹ�Ӧ�����ϵ��ɾ����ӦԪ��(ע��ԭ��ɾ��˳��)��
delete from SPJ
where SNO='S2';

delete from S
where SNO='S2';

select *
from S;

--4.5�뽫S2�򹤳���ĿJ6��Ӧ200��P4�������Ϣ���뵽��Ӧ��ϵ�У�
insert into S values('S2', 'ʢ��',10��'����');    --����ǰһ�����Ѿ���S2�ӹ�Ӧ�̱�S��ɾ������ˣ���Ҫ�ڴ˴��������²��롣
insert into SPJ values('S2','P4','J6',200);

select *
from SPJ;

--4.6�뽫S6�򹤳���ĿJ8��Ӧ500��P7�������Ϣ���뵽��Ӧ��ϵ���漰����4���������ԭɫ������˳�����¡�
insert into S values('S6',NULL, NULL, NULL);
insert into P values('P7',NULL, NULL, NULL);
insert into J values('J8', NULL, NULL);
insert into SPJ values('S6','P7','J8', 500);
commit work;
select *
from SPJ;

--TP2-5.1��ÿһ��ϵ����ѧ����ƽ�����䣬���ѽ���������ݿ�
create table AveAge  --�����±�
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

--TP2-5.2���������ѧϵȫ��ѧ���ĳɼ���0
update SC
set GRADE=0
where SNO in (select SNO from STUDENT where SDEPT='cs');

select *
from SC;

--TP2-5.3ɾ���������ѧϵ����ѧ����ѡ�μ�¼
delete from SC
where SNO IN
(select SNO 
from STUDENT
WHERE SDEPT='cs'
);

--TP2-5.4ɾ��ĳѧ������Ϣ����ѡ����Ϣ��(ע�����������ԣ�����ɾ��)
delete from SC where SNO = 's1';

delete from student where SNO='s1';
