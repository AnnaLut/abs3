--Картка клієнта, вкладка 'Санкції', додаткові реквізити:
--1. SANKC - Обмежувальні заходи (санкції) - 
--2. RNBOR - Номер позиції згідно із відповідним додатком до рішення РНБО України.
--3. RNBOU - Номер указу Президента України, згідно з яким введено в дію рішення РНБО України.
--4. RNBOS - Санкція відповідно до рішення РНБО України
--5. RNBOD - Дата введення в дію рішення РНБО України.

Prompt   INSERT INTO CUSTOMER_FIELD_CODES  'SANKC'
BEGIN
suda;
Insert into BARS.CUSTOMER_FIELD_CODES
   ( CODE, NAME, ORD )
 select 'SANKC','Санкції', max(ord)+1
   from CUSTOMER_FIELD_CODES
  where ord<90;

COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

update BARS.CUSTOMER_FIELD
   set CODE ='SANKC',
       NAME ='1.Обмежувальні заходи (санкції) (Так/Ні) ',
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


