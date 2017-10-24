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


prompt +==============================================
prompt | Conecting as BARSUPL to database &&1 
prompt +==============================================

conn barsupl@&&1/&&4

prompt -> @data\add_kf_uplsql_10_11.sql
@Sql\barsupl\data\add_kf_uplsql_10_11.sql











































































spool off

quit

