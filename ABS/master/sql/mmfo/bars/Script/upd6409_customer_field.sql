--������ �볺���, �������� ��������, ������� '����':
-- ISSPE - �������� ����� -SPE -���/ͳ- 

exec bc.home;

Prompt   INSERT INTO CUSTOMER_FIELD   tag 'ISSPE'
BEGIN

    Insert into BARS.CUSTOMER_FIELD
       (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK,
        SQLVAL, CODE, NOT_TO_EDIT, HIST, U_NREZ, F_NREZ, F_SPD)
     Values
       ('ISSPE', '�������� ����� - SPE', 0, 1, 0, 
        'V_YESNO', 'N', 1, 'ID', 
        'select ''0'' from dual',
        'OTHERS', 0, 0, 1, 0, 0);

COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/


