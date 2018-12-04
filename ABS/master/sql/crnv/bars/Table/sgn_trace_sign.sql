SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

prompt create table SGN_TRACE_SIGN

begin
  bpa.alter_policy_info('SGN_TRACE_SIGN', 'FILIAL', null, null, null, null);
  bpa.alter_policy_info('SGN_TRACE_SIGN', 'WHOLE', null, null, null, null);
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate '
create table SGN_TRACE_SIGN
( CR_DATE              timestamp(6) default localtimestamp not null
, USER_ID              number(38)
, REF                  number(38)
, VISA_LEVEL           number(3)
, KEY_ID               varchar2(256)
, SIGN_MODE            varchar2(20)
, BUFFER_TYPE          varchar2(3)
, BUFFER_HEX           clob
, BUFFER_BIN           clob
, SIGN_HEX             clob
, VERIFY_STATUS        number(3)
, VERIFY_ERROR         varchar2(4000)
) tablespace BRSSMLD';

  dbms_output.put_line('Table created.');

exception
  when e_tab_exists
  then null;
end;
/

begin
  bpa.alter_policies('SGN_TRACE_SIGN');
end;
/

commit;

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table SGN_TRACE_SIGN is 'Діагностика роботи підписів';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant select on SGN_TRACE_SIGN to BARS_ACCESS_DEFROLE;
