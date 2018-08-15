--Картка клієнта,  вкладка Санкцii      (customer_field_codes.CODE ='SANKC')

--   дополнительные параметры для "второй" санкции
--5. RNB1R - Номер позиції згідно із відповідним додатком до рішення РНБО України.
--6. RNB1U - Номер указу Президента України, згідно з яким введено в дію рішення РНБО України.
--7. RNB1S - Санкція відповідно до рішення РНБО України            -по довiднику SPR_RNBO_CODES
--8. RNB1D - Дата введення в дію рішення РНБО України.

exec bc.home;

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNB1R';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD)
 Values
   ('RNB1R', 'Номер позиції згідно із відповідним додатком (для рішення РНБО)', 0, 1, 1, 
    null, 'S', 1, 'SANKC', 0, 1, 1, 1 );
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNB1U';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD)
 Values
   ('RNB1U', 'Номер указу Президента України (для рішення РНБО)', 0, 1, 1, 
    null, 'S', 1, 'SANKC', 0, 1, 1, 1);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNB1S';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD)
 Values
   ('RNB1S', 'Санкція відповідно до рішення РНБО України', 0, 1, 1, 
    'SPR_RNBO_CODES', 'S', 1, 'SANKC', 0, 1, 1, 1);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNB1D';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD)
 Values
   ('RNB1D', 'Дата введення в дію рішення РНБО України', 0, 1, 1, 
    null, 'S', 1, 'SANKC', 0, 1, 1, 1);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/


