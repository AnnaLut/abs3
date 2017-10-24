--������ �볺���, ������� '�������', �������� ��������:
--1. SANKC - ����������� ������ (�������) - 
--2. RNBOR - ����� ������� ����� �� ��������� �������� �� ������ ���� ������.
--3. RNBOU - ����� ����� ���������� ������, ����� � ���� ������� � �� ������ ���� ������.
--4. RNBOS - ������� �������� �� ������ ���� ������
--5. RNBOD - ���� �������� � �� ������ ���� ������.

Prompt   INSERT INTO CUSTOMER_FIELD_CODES  'SANKC'
BEGIN
suda;
Insert into BARS.CUSTOMER_FIELD_CODES
   ( CODE, NAME, ORD )
 select 'SANKC','�������', max(ord)+1
   from CUSTOMER_FIELD_CODES
  where ord<90;

COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

update BARS.CUSTOMER_FIELD
   set CODE ='SANKC',
       NAME ='1.����������� ������ (�������) (���/ͳ) ',
       B =0,
       U_NREZ =1,
       F_NREZ =1,
       F_SPD =1
 where tag ='SANKC';

update BARS.CUSTOMER_FIELD
   set CODE ='SANKC',
       B =0,
       U_NREZ =1,
       F_NREZ =1,
       F_SPD =1
 where tag in ('RNBOR','RNBOU','RNBOS','RNBOD');

commit;


