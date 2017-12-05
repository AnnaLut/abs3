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
prompt  ...


whenever sqlerror exit
prompt ...
prompt ... connecting as bars
prompt ...


conn  bars@&&dbname/&&bars_pass
whenever sqlerror continue


prompt PACKAGES
prompt ...Bars\Header\PAY_IMMOBILE.pks 
@Bars\Header\PAY_IMMOBILE.pks 

prompt ...Bars\Package\PAY_IMMOBILE.pkb
@Bars\Package\PAY_IMMOBILE.pkb

prompt Procedures
prompt ...Bars\Procedure\P_BATCH_SET.prc
@Bars\Procedure\P_BATCH_SET.prc

spool off

quit

