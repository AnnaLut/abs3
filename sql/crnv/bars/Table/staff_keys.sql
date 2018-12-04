SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

prompt create table STAFF_KEYS

begin
  bpa.alter_policy_info('STAFF_KEYS', 'FILIAL', null, 'E', 'E', 'E');
  bpa.alter_policy_info('STAFF_KEYS', 'WHOLE', null, null, null, null);
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table STAFF_KEYS
( USER_ID    number(38)    constraint cc_staffkeys_userid_nn  not null
, KEY_TYPE   varchar2(3)   constraint cc_staffkeys_keytype_nn not null
, KEY_ID     varchar2(256) constraint cc_staffkeys_keyid_nn   not null
, constraint PK_STAFFKEYS primary key (USER_ID, KEY_TYPE, KEY_ID) using index tablespace BRSSMLI
, constraint FK_STAFFKEYS_STAFF    foreign key (USER_ID)  references STAFF$BASE(ID)
, constraint FK_STAFFKEYS_SGNTYPES foreign key (KEY_TYPE) references SGN_TYPE(ID)
) tablespace BRSSMLD';

  dbms_output.put_line('Table created.');

exception
  when e_tab_exists
  then null;
end;
/

begin
  bpa.alter_policies('STAFF_KEYS');
end;
/

commit;

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  STAFF_KEYS          is '';

comment on column STAFF_KEYS.USER_ID  is 'Ід. користувача';
comment on column STAFF_KEYS.KEY_TYPE is 'Тип ЕЦП';
comment on column STAFF_KEYS.KEY_ID   is 'Ід.';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant select on STAFF_KEYS to BARS_ACCESS_DEFROLE;
