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

-- Modification ¹1
@\OVR\Sql\Bars\Table\1_ovrn_tbl.sql
@\OVR\Sql\Bars\Data\2_ovrn_dat.sql 
@\OVR\Sql\Bars\Data\OVRN_BMD.sql 
@\OVR\Sql\Bars\Data\_BRS_SBR_OVR_LIM.sql 
@\OVR\Sql\Bars\Trigger\TAU_ACCOUNTS_OVER.sql 
@\OVR\Sql\Bars\Header\OVRN.pks 
@\OVR\Sql\Bars\Package\OVRN.pkb 
@\OVR\Sql\Bars\View\4_ovrn_vie.sql 

-- Modification ¹2.1
-- Modification ¹2.2
-- Modification ¹2.3


spool off

quit

