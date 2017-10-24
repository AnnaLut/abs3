set verify off
set echo off
set serveroutput on size 1000000
spool log\install.log
set lines 3000


prompt...
prompt ...
prompt ... loading params
prompt ...

@params.sql

prompt  ...
prompt  dbname     = &&dbname
prompt  sys_pass   = &&sys_pass
prompt  bars_pass  = &&bars_pass
prompt  ...


whenever sqlerror exit
prompt ...
prompt ... connecting as bars
prompt ...


conn  bars@&&dbname/&&bars_pass
whenever sqlerror continue

prompt 1.1 Table
@sql\bars\table\bms_tmp_msg_uids.sql
@sql\bars\table\user_messages_types.sql
@sql\bars\table\user_messages.sql

prompt 1.2 View
@sql\bars\view\v_user_messages.sql

prompt 1.3 Sequence
@sql\bars\Sequence\s_user_messages.sql

prompt 1.4 Header
@sql\bars\Header\bms.pkg

prompt 1.5 Package
@sql\bars\Package\bms.pkb

prompt 1.6 PROCEDURE
@Sql\Bars\Procedure\bars_notifier_receive.sql
@Sql\Bars\Procedure\bars_notifier_send.sql

prompt finish 

spool off

exit