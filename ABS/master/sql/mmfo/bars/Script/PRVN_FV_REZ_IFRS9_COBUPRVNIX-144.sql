
begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 add (DELTA_FV_CCY  NUMBER(24,2)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN PRVN_FV_REZ_IFRS9.DELTA_FV_CCY IS 'Переоцінка';

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (BARS_BRANCH_ID   VARCHAR2(30)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (EIR   NUMBER(13,8)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (FV_ADJ_AMORT   NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (FV_ADJ_BALANCE   NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (GENERAL_FEE_AMORT   NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (GENERAL_FEE_BALANCE   NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (MODIF_AMORT   NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (MODIF_BALANCE   NUMBER) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (RNK_CLIENT   VARCHAR2(30)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV_REZ_IFRS9 modify (UNIQUE_BARS_IS   VARCHAR2(30)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

