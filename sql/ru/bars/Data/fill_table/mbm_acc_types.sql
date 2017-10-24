SET DEFINE OFF;
begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''CARD'', ''Карткові рахунки'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''CURRENT'', ''Розрахункові рахунки'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''DEPOSIT'', ''Депозитні рахунки'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''LOAN'', ''Кредитні рахунки'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin
  execute immediate 
'Insert into BARS.MBM_ACC_TYPES
   (TYPE_ID, NAME)
 Values
   (''OTHER'', ''Інші рахунки'')';
exception
  when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

COMMIT;
