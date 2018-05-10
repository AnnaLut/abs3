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
prompt  bars_intgr_pass  = &&bars_intgr_pass
prompt  ...


whenever sqlerror exit
prompt ...
prompt ... connecting as bars_intgr
prompt ...


conn  bars_intgr@&&dbname/&&bars_intgr_pass
whenever sqlerror continue


@bars_intgr/Table/intgr_stats.sql

@bars_intgr/Table/clientfo2.sql
@bars_intgr/Table/client_address.sql
@bars_intgr/Table/accounts.sql

@bars_intgr/Table/imp_object.sql
@bars_intgr/Table/imp_object_dependency.sql
@bars_intgr/Table/imp_object_mfo.sql

@bars_intgr/Sequence/s_stats.sql

@bars_intgr/Data/imp_object.sql
@bars_intgr/Data/imp_object_dependency.sql
@bars_intgr/Data/imp_object_mfo.sql

@bars_intgr/Package/xrm_import.sql

--@bars_intgr/Data/reset_obj_idupd.sql

@bars_intgr/Grant/select_to_ibmesb.sql

@bars_intgr/Job/xrm_clear_datamarts.sql
@bars_intgr/Job/xrm_import_delta.sql







































































spool off

quit

