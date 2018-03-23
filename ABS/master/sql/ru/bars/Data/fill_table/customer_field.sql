-- ======================================================================================
-- Module  : 
-- Author  : 
-- Date    : 29/08/2017
-- ======================================================================================
-- нові параметри контрагенту для формування файлу #2K
-- по заявці 5872 Щодо доопрацювання параметрів клієнта (створення нового параметру)
-- На картку клієнта на вкладку Фин.мон необхідно додати наступні доп.реквизиты:
-- 1. SANKC - Обмежувальні заходи (санкції) - 
-- 2. RNBOR - Номер позиції згідно із відповідним додатком до рішення РНБО України.
-- 3. RNBOU - Номер указу Президента України, згідно з яким введено в дію рішення РНБО України.
-- 4. RNBOS - Санкція відповідно до рішення РНБО України
-- 5. RNBOD - Дата введення в дію рішення РНБО України.
--
-- COBUCDMCORP-64
-- ======================================================================================
Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'SANKC';
BEGIN
suda;
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
suda;
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
suda;
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
suda;
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
suda;
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

begin
  Insert
    into CUSTOMER_FIELD
    ( TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK
    , SQLVAL, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD )
  Values
    ( 'EXCLN', 'ІПН є виключенням (не проходить валідацію по алгоритму)', 0, 0, 1, 'V_YESNO', 'N', 0, 'ID'
    , 'select ''0'' from dual', 'GENERAL', 1, 0, 0, 1 );
exception
  when dup_val_on_index then
    update CUSTOMER_FIELD
       set NAME            = 'ІПН є виключенням (не проходить валідацію по алгоритму)'
         , B               = 0
         , U               = 0
         , F               = 1
         , TABNAME         = 'V_YESNO'
         , TABCOLUMN_CHECK = 'ID'
         , SQLVAL          = 'select ''0'' from dual'
         , TYPE            = 'N'
         , OPT             = 0
         , CODE            = 'GENERAL'
         , NOT_TO_EDIT     = 1
         , U_NREZ          = 0
         , F_NREZ          = 0
         , F_SPD           = 1
     where TAG             = 'EXCLN';
end;
/

COMMIT;

prompt add FMPOS reqv
begin
insert into customer_field (TAG, NAME, B, U, F, TABNAME, BYISP, TYPE, OPT, TABCOLUMN_CHECK, SQLVAL, CODE, NOT_TO_EDIT, HIST, PARID, U_NREZ, F_NREZ, F_SPD)
values ('FMPOS', 'Висн. щодо наявн.у кл-та потенц. та реал. фін.можл.для провед. опер.', 1, 1, 1, 'FM_POSS', null, null, null, 'NAME', null, 'FM', 0, null, null, 0, 1, 1);
commit;
exception
when dup_val_on_index then null;
end;
/
