SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

prompt create table SGN_TYPE

begin
  bpa.alter_policy_info('SGN_TYPE', 'FILIAL', null, 'E', 'E', 'E');
  bpa.alter_policy_info('SGN_TYPE', 'WHOLE', null, null, null, null);
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table SGN_TYPE
( ID         varchar2(3)  constraint cc_sngtype_id_nn       not null
, NAME       varchar2(60) constraint cc_sngtype_name_nn     not null
, IS_ACTIVE  varchar2(1)  constraint cc_sngtype_isactive_nn not null
, constraint PK_SGNTYPE primary key (id) using index tablespace BRSSMLI
, constraint CC_SGNTYPE_ID check (id=upper(id))
, constraint CC_SGNTYPE_ISACTIVE check (is_active in (''Y'',''N''))
) tablespace BRSSMLD';

  dbms_output.put_line('Table created.');

exception
  when e_tab_exists
  then null;
end;
/

begin
  bpa.alter_policies('SGN_TYPE');
end;
/

commit;

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  SGN_TYPE           is 'Типи ЕЦП';

comment on column SGN_TYPE.ID        is 'Ід. типу ЕЦП';
comment on column SGN_TYPE.NAME      is 'Назва типу ЕЦП';
comment on column SGN_TYPE.IS_ACTIVE is 'Ознака. Y - діючий, N - не діючий';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant select on SGN_TYPE to BARS_ACCESS_DEFROLE;
