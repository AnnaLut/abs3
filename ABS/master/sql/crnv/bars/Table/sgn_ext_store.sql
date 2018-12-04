SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

prompt create table SGN_EXT_STORE

begin
  bpa.alter_policy_info( 'SGN_EXT_STORE', 'FILIAL', null, null, null, null );
  bpa.alter_policy_info( 'SGN_EXT_STORE', 'WHOLE' , null, null, null, null );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table SGN_EXT_STORE
( REF        number(38)     constraint CC_SGNEXTSTORE_REF_NN    not null
, SIGN_ID    number         constraint CC_SGNEXTSTORE_SIGNID_NN not null
, constraint PK_SGNEXTSTORE primary key (REF) using index tablespace BRSMDLI
, constraint UK_SGNEXTSTORE unique(REF, SIGN_ID) using index tablespace BRSMDLI
, constraint FK_SGNEXTSTORE_OPER_REF    foreign key (ref) references OPER(REF)
, constraint FK_SGNEXTSTORE_SGNDATA_REF foreign key (SIGN_ID) references SGN_DATA(ID)
) tablespace BRSMDLD';

  dbms_output.put_line('Table created.');

exception
  when e_tab_exists
  then null;
end;
/

prompt create index IDX_SGNEXTSTORE_SIGNID

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_SGNEXTSTORE_SIGNID on SGN_EXT_STORE ( SIGN_ID ) tablespace BRSMDLI';
  dbms_output.put_line('Index created.');
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

begin
  bpa.alter_policies('SGN_INT_STORE');
end;
/

commit;

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  SGN_EXT_STORE         is 'Сховище СЕП підписів по документам (OPER)';

comment on column SGN_EXT_STORE.REF     is 'Ідентифікатор документу';
comment on column SGN_EXT_STORE.SIGN_ID is 'Ідентифікатор підпису';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant select on SGN_INT_STORE to BARS_ACCESS_DEFROLE;
grant select on SGN_EXT_STORE to TOSS;
