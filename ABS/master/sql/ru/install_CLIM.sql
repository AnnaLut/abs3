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

-- Modification �1
-- Modification �2.1
-- Modification �2.2
-- Modification �2.3


spool off

quit

