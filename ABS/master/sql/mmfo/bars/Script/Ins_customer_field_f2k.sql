-- 13/06/2017  
-- нові параметри контрагенту для формування файлу #2K
-- по заявці 5872 Щодо доопрацювання параметрів клієнта 
--                (створення нового параметру)	
--На картку клієнта на вкладку Фин.мон необхідно додати наступні доп.реквизиты:
--1. SANKC - Обмежувальні заходи (санкції) - 
--2. RNBOR - Номер позиції згідно із відповідним додатком до рішення РНБО України.
--3. RNBOU - Номер указу Президента України, згідно з яким введено в дію рішення РНБО України.
--4. RNBOS - Санкція відповідно до рішення РНБО України
--5. RNBOD - Дата введення в дію рішення РНБО України.

exec bc.home;

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'SANKC';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('SANKC', 'Обмежувальні заходи (санкції) (Так/Ні) ', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNBOR';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('RNBOR', 'Номер позиції згідно із відповідним додатком (для рішення РНБО)', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNBOU';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('RNBOU', 'Номер указу Президента України (для рішення РНБО)', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNBOS';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('RNBOS', 'Санкція відповідно до рішення РНБО України', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNBOD';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK, CODE, NOT_TO_EDIT)
 Values
   ('RNBOD', 'Дата введення в дію рішення РНБО України', 1, 1, 1, 
    null, 'S', 1, null, 
    'FM', 0);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/


