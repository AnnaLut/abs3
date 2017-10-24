SET DEFINE OFF;
begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''CARD'', ''������� �������'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''CURRENT'', ''����������� �������'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''DEPOSIT'', ''�������� �������'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''LOAN'', ''������� �������'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''OTHER'', ''���� �������'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

COMMIT;
