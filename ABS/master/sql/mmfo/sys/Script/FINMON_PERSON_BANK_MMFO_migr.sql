begin
  execute immediate 'alter table finmon.person_oper_nostro drop constraint R_POPERN_PBANK';
exception
  when others then
    if sqlcode = -2443 then null; else raise; end if;
end;
/
begin
  execute immediate 'alter table finmon.person_oper drop constraint R_POPER_PBANK';
exception
  when others then
    if sqlcode = -2443 then null; else raise; end if;
end;
/
begin
  execute immediate 'alter table finmon.person_bank drop constraint XPK_PERSON_BANK';
exception
  when others then
    if sqlcode = -2443 then null; else raise; end if;
end;
/
begin
  execute immediate 'drop index FINMON.XPK_PERSON_BANK';
exception
  when others then
    if sqlcode = -1418 then null; else raise; end if;
end;
/
begin
  execute immediate 'drop index FINMON.XAK_BANK_BANKCODE';
exception
  when others then
    if sqlcode = -1418 then null; else raise; end if;
end;
/
begin
  execute immediate 'alter table FINMON.PERSON_BANK add BRANCH_ID varchar2(15)';
exception
  when others then
    if sqlcode = -1430 then null; else raise; end if;
end;
/
begin 
  update finmon.person_bank set branch_id = '1';
  execute immediate 'alter table finmon.person_bank modify branch_id not null';
exception
  when others then
    rollback;
    if sqlcode = -1442 then null; else raise; end if;
end;
/
begin
  execute immediate 'create unique index FINMON.XPK_PERSON_BANK on FINMON.PERSON_BANK(id, branch_id) tablespace brsdyni compute statistics';
exception
  when others then
    if sqlcode = -955 then null; else raise; end if;
end;
/
begin
  execute immediate 'create unique index FINMON.XAK_BANK_BANKCODE on FINMON.PERSON_BANK(bank_idcode, branch_id) tablespace brsdyni compute statistics';
exception
  when others then
    if sqlcode = -955 then null; else raise; end if;
end;
/
begin
  execute immediate 'alter table FINMON.PERSON_BANK add constraint XPK_PERSON_BANK primary key(ID, BRANCH_ID)';
exception
  when others then
    if sqlcode = -2260 then null; else raise; end if;
end;
/
begin
  execute immediate 'alter table finmon.person_oper_nostro add constraint R_POPERN_PBANK foreign key(pbank_id, branch_id) references FINMON.PERSON_BANK(id, branch_id) enable novalidate';
exception
  when others then
    if sqlcode = -2275 then null; else raise; end if;
end;
/
begin
  execute immediate 'alter table finmon.person_oper add constraint R_POPER_PBANK foreign key(pbank_id, branch_id) references FINMON.PERSON_BANK(id, branch_id) enable novalidate';
exception
  when others then
    if sqlcode = -2275 then null; else raise; end if;
end;
/
create or replace trigger FINMON.TBI_PERSON_BANK_BRANCH
BEFORE INSERT
ON FINMON.PERSON_BANK
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin
    :new.BRANCH_ID := get_branch_id;
end;
/

BEGIN
  SYS.DBMS_RLS.DROP_POLICY (
    object_schema    => 'FINMON'
    ,object_name     => 'PERSON_BANK'
    ,policy_name     => 'GET_FM_POLICIES');
exception when others then
  if sqlcode = -28102 then null; else raise; end if;
END;
/

BEGIN
  SYS.DBMS_RLS.ADD_POLICY     (
    object_schema          => 'FINMON'
    ,object_name           => 'PERSON_BANK'
    ,policy_name           => 'GET_FM_POLICIES'
    ,function_schema       => 'FINMON'
    ,policy_function       => 'FM_POLICIES.GET_FM_POLICIES'
    ,statement_types       => 'SELECT'
    ,policy_type           => dbms_rls.dynamic
    ,long_predicate        => FALSE
    ,update_check          => FALSE
    ,static_policy         => FALSE
    ,enable                => TRUE );
exception when others then
  if sqlcode = -28101 then null; else raise; end if;
END;
/
