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

WHENEVER SQLERROR CONTINUE

prompt ...
prompt ... connecting as bars
prompt ...
conn bars/&&bars_pass@&&dbname

prompt add_policy_mnemonics.sql
@Sql\Bars\Script\add_policy_mnemonics.sql

prompt grc_groups_patch.sql.sql
@sql\Bars\script\grc_groups_patch.sql

prompt add_center_policy_group.sql
@Sql\Bars\Script\add_center_policy_group.sql

prompt fill_etalon_groups
@Sql\Bars\Data\etalon_groups.sql
@Sql\Bars\Data\etalon_groups_acc.sql
@Sql\Bars\Data\etalon_groups_nbs.sql
@Sql\Bars\Data\etalon_ps.sql
@Sql\Bars\Data\etalon_groups_staff_acc.sql
@Sql\Bars\Data\tts_mmfo.sql

prompt fill etalon_list_funcset
@Sql\Bars\Data\etalon_list_funcset.sql

prompt tts_mmfo.sql
@Sql\Bars\Data\tts_mmfo.sql


prompt -- =======================
prompt -- Rebuilding schema ... 
prompt -- =======================
exec dbms_utility.compile_schema(schema=>user, compile_all=>false);

prompt -- =======================
prompt -- Show INVALID objects ... 
prompt -- =======================

column object_name format a30
column object_type format a30
select object_name,object_type
from user_objects
where status <> 'VALID';

prompt -- ===========================================
prompt -- Execution is completed.
prompt -- Check log file for error.
prompt -- ===========================================

spool off

quit
