SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

prompt create table SGN_DATA

begin
  bpa.alter_policy_info( 'SGN_DATA', 'FILIAL', null, null, null, null );
  bpa.alter_policy_info( 'SGN_DATA', 'WHOLE' , null, null, null, null );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table SGN_DATA
( ID             number         constraint cc_sgndata_id_nn       not null
, SIGN_TYPE      varchar2(3)    constraint cc_sgndata_signtype_nn not null
, KEY_ID         varchar2(256)  constraint cc_sgndata_keyid_nn    not null
, CREATING_DATE  date           constraint cc_sgndata_crdate_nn   not null
, SIGN_HEX       clob           constraint cc_sgndata_signhex_nn  not null
, constraint PK_SGNDATA primary key (id) using index tablespace BRSBIGI
, constraint FK_SGNDATA_SGNTYPE_ID foreign key (sign_type) references SGN_TYPE(id)
) tablespace BRSBIGD';

  dbms_output.put_line('Table created.');

exception
  when e_tab_exists
  then null;
end;
/

begin
  bpa.alter_policies('SGN_DATA');
end;
/

commit;

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  SGN_DATA is 'Сховище данних з ЕЦП';

comment on column SGN_DATA.ID            is 'Ідентифікатор підпису';
comment on column SGN_DATA.SIGN_TYPE     is 'Тип ЕЦП';
comment on column SGN_DATA.KEY_ID        is 'Ідентифікатор ключа';
comment on column SGN_DATA.CREATING_DATE is 'Дата створення підпису';
comment on column SGN_DATA.SIGN_HEX      is 'Підпис в представленні HEX';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant select on SGN_DATA to BARS_ACCESS_DEFROLE;
grant select on SGN_DATA to TOSS;