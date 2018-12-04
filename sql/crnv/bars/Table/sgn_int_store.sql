SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

prompt create table SGN_INT_STORE

begin
  bpa.alter_policy_info( 'SGN_INT_STORE', 'FILIAL', null, null, null, null );
  bpa.alter_policy_info( 'SGN_INT_STORE', 'WHOLE' , null, null, null, null );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table SGN_INT_STORE
( ref        number(38)     constraint CC_SGNINTSTORE_REF_NN    not null
, rec_id     number(38)     constraint CC_SGNINTSTORE_RECID_NN  not null
, sign_id    number         constraint CC_SGNINTSTORE_SIGNID_NN not null
, constraint PK_SGNINTSTORE primary key (REF, REC_ID) using index tablespace BRSMDLI
, constraint FK_SGNINTSTORE_OPER_REF      foreign key (REF)     references OPER(REF)
, constraint FK_SGNINTSTORE_OPER_VISA_REF foreign key (REC_ID)  references OPER_VISA(SQNC)
, constraint FK_SGNINTSTORE_SGNDATA_REF   foreign key (SIGN_ID) references SGN_DATA(ID)
) tablespace BRSMDLD';

  dbms_output.put_line('Table created.');

exception
  when e_tab_exists
  then null;
end;
/

prompt create index IDX_SGNINTSTORE_SIGNID

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_SGNINTSTORE_SIGNID on SGN_INT_STORE ( SIGN_ID ) tablespace BRSMDLI';
  dbms_output.put_line('Index created.');
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

prompt create index IDX_SGNINTSTORE_RECID

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_SGNINTSTORE_RECID on SGN_INT_STORE ( REC_ID ) tablespace BRSMDLI';
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

comment on table  SGN_INT_STORE         is 'Сховище внутрішніх підписів по документам (OPER_VISA)';

comment on column SGN_INT_STORE.REF     is 'Ідентифікатор документу';
comment on column SGN_INT_STORE.REC_ID  is 'Ідентифікатор запису у OPER_VISA';
comment on column SGN_INT_STORE.SIGN_ID is 'Ідентифікатор підпису';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant select on SGN_INT_STORE to BARS_ACCESS_DEFROLE;
