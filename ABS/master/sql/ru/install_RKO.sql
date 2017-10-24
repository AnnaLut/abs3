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

@Sql\Bars\Table\t_rko_signatory.sql
@Sql\Bars\Sequence\s_rko_signatory.sql
@Sql\Bars\View\v_rko_signatory.sql
@Sql\Bars\View\v_rko_cust_signatory.sql
@Sql\Bars\Procedure\p_rko_signatory.sql
@Sql\Bars\Function\f_get_rko_posfio.sql
@Sql\Bars\Data\err.sql
@Sql\Bars\Data\meta_rko_signatory.sql
@Sql\Bars\Data\ref_rko_sign_ARM.sql








































































spool off

quit

