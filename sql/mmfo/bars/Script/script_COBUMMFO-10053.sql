begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME,TYPE,  NOT_TO_EDIT, CODE, CUST_TYPE )
 Values
   ('LIZASUM', '����������� ���� ������� �������� ������', 'CCK', 'FM_YESNO', 'C', 0, 'ZAL', 2);
exception
    when dup_val_on_index then null;
end;
/
COMMIT;


begin
Insert into BARS.CC_TAG
   (TAG, NAME, TAGTYPE, TABLE_NAME,TYPE,  NOT_TO_EDIT, CODE, CUST_TYPE )
 Values
   ('LIZSUM', '������� �������� ������', 'CCK', null, 'N', 0, 'ZAL', 2);
exception
    when dup_val_on_index then null;
end;
/
COMMIT;

begin
update BARS.CC_TAG 
  set CODE = 'ZAL'
where TAG in ('LIZSUM','LIZASUM');
end;
/
COMMIT;