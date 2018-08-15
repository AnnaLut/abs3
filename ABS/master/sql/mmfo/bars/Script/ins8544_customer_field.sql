--������ �볺���,  ������� �����ii      (customer_field_codes.CODE ='SANKC')

--   �������������� ��������� ��� "������" �������
--5. RNB1R - ����� ������� ����� �� ��������� �������� �� ������ ���� ������.
--6. RNB1U - ����� ����� ���������� ������, ����� � ���� ������� � �� ������ ���� ������.
--7. RNB1S - ������� �������� �� ������ ���� ������            -�� ���i����� SPR_RNBO_CODES
--8. RNB1D - ���� �������� � �� ������ ���� ������.

exec bc.home;

Prompt INSERT INTO CUSTOMER_FIELD TAG LIKE 'RNB1R';
BEGIN
Insert into BARS.CUSTOMER_FIELD
   (TAG, NAME, B, U, F, TABNAME, TYPE, OPT, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD)
 Values
   ('RNB1R', '����� ������� ����� �� ��������� �������� (��� ������ ����)', 0, 1, 1, 
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
   ('RNB1U', '����� ����� ���������� ������ (��� ������ ����)', 0, 1, 1, 
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
   ('RNB1S', '������� �������� �� ������ ���� ������', 0, 1, 1, 
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
   ('RNB1D', '���� �������� � �� ������ ���� ������', 0, 1, 1, 
    null, 'S', 1, 'SANKC', 0, 1, 1, 1);
COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/


