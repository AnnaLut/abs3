begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('INSCC', '����������� �������', 'CCK', 'FM_YESNO', 0, 
    'MAIN');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
branch_attribute_utl.add_new_attribute_with_set('INSCC','CCK ��������� �������� ��������� ����������� ��� ����������� �������','N',null,null,'/','1');
end;
/
commit;

---------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY0T', '����������� ������������ �1', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY2T', '����������� ������������ �2', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY4T', '����������� ������������ �3', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY6T', '����������� ������������ �4', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY8T', '����������� ������������ �5', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

----------------------------------------
begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY1T', '����������� ������ �1', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY3T', '����������� ������ �2', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY5T', '����������� ������ �3', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY7T', '����������� ������ �4', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY9T', '����������� ������ �5', 'CCK', 'FM_YESNO', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;
----------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY0U', '����� �������� ������������ �1', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY2U', '����� �������� ������������ �2', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY4U', '����� �������� ������������ �3', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY6U', '����� �������� ������������ �4', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY8U', '����� �������� ������������ �5', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

--------------------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY1U', '����� �������� ������ �1', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY3U', '����� �������� ������ �2', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY5U', '����� �������� ������ �3', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY7U', '����� �������� ������ �4', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY9U', '����� �������� ������ �5', 'CCK', '', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

------------------------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY0V', '���� ��������� �������� ������������ �1', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY2V', '���� ��������� �������� ������������ �2', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY4V', '���� ��������� �������� ������������ �3', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY6V', '���� ��������� �������� ������������ �4', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY8V', '���� ��������� �������� ������������ �5', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

------------------------------------------------

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY1V', '���� ��������� �������� ������ �1', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY3V', '���� ��������� �������� ������ �2', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY5V', '���� ��������� �������� ������ �3', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY7V', '���� ��������� �������� ������ �4', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TYPE, NOT_TO_EDIT, 
    CODE)
 Values
   ('ZAY9V', '���� ��������� �������� ������ �5', 'CCK', 'D', 0, 
    'ZAL');
exception
    when dup_val_on_index then null;
end;
/
COMMIT;