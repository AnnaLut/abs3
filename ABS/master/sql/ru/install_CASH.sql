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


whenever error exit
prompt ...
prompt ... connecting as bars
prompt ...

prompt ... лотореи
@\CASH\Sql\Table\branch_operlot.sql
@\CASH\Sql\Data\bmd_branch_operlot.sql
@\CASH\Sql\Procedure\p_lot1.sql
@\CASH\Sql\Data\operlist_lotery.sql


spool off

quit

