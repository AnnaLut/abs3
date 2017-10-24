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

prompt @bars/table/mway_log.sql
@bars/table/mway_log.sql

prompt @bars/table/mway_mapping_branch.sql
@bars/table/mway_mapping_branch.sql

prompt @bars/header/bmway_mgr.prs
@bars/header/bmway_mgr.prs

prompt @bars/package/bmway_mgr.prb
@bars/package/bmway_mgr.prb

prompt @bars/data/MWAY_MAPPING_BRANCH.sql
@bars/data/MWAY_MAPPING_BRANCH.sql

prompt @bars/data/patch.sql
@bars/data/patch.sql


prompt ...
prompt ... connecting as mgw_agent
prompt ...

whenever sqlerror exit 
conn mgw_agent&&dbname/&&agent_pass
whenever sqlerror continue

prompt @mgw_agent/Procedure/omg_enqueue_str.prc
@mgw_agent/Procedure/omg_enqueue_str.prc

prompt @mgw_agent/Procedure/omg_notify.prc
@mgw_agent/Procedure/omg_notify.prc

prompt @mgw_agent/Script/alistener_reg.sql
@mgw_agent/Script/alistener_reg.sql


spool off

quit

