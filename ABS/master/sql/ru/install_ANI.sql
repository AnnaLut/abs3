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


@ANI\Sql\Bars\Data\bmd_n00_mfo.sql 
@ANI\Sql\Bars\Data\bmd_n00_nbs.sql 
@ANI\Sql\Bars\Data\operlist_ani.sql 











































































spool off

quit

