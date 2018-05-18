BEGIN
  Insert into BARS.CC_TAG_CODES
   (CODE, NAME, ORD)
  Values
   ('SPEC', '���� ������.������(����)', 2);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

COMMIT;

BEGIN
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('CIG_D13', 'CIG_D13 ������ ��������', 'CCK', 'CIG_D13', 0, 
    'SPEC');
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/
BEGIN
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('CIG_D16', 'CIG_D16 ���������� ������ ��������', 'CCK', 'CIG_D16', 0, 
    'SPEC');
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/
BEGIN
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('CIG_D17', 'CIG_D17 ��� ������������ �� ��������', 'CCK', 'CIG_D17', 0, 
    'SPEC');
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/
COMMIT;