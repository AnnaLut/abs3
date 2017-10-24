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
--prompt  sys_pass   = &&sys_pass
prompt  bars_pass  = &&bars_pass
prompt  ...

conn bars/&&bars_pass@&&dbname

whenever sqlerror exit
prompt ...

prompt @sql/bars/TABLE/PARAMS_VALIDATION.sql
@sql/bars/table/PARAMS_VALIDATION.sql
prompt @sql/bars/TABLE/PARAMS_PRIME_LOAD.sql
@sql/bars/table/PARAMS_PRIME_LOAD.sql
prompt @sql/bars/TABLE/cim_risk_bank.sql
@sql/bars/table/cim_risk_bank.sql

prompt -- =======================
prompt -- table tables complete
prompt -- =======================


prompt @sql/bars/type/t_dictionary.sql
@sql/bars/type/t_dictionary.sql
prompt -- =======================
prompt -- create type complete
prompt -- =======================


prompt @sql/bars/view/v_params_prime_load.sql
@sql/bars/view/v_params_prime_load.sql
prompt -- =======================
prompt -- create view complete
prompt -- =======================


prompt @sql/bars/header/gl_ui.pks
@sql/bars/header/gl_ui.pks
prompt -- =======================
prompt -- create header body complete
prompt -- =======================

prompt @sql/bars/package/gl_ui.pkb
@sql/bars/package/gl_ui.pkb
prompt -- =======================
prompt -- create package body complete


prompt @sql/bars/data/PARAMS_PRIME_LOAD.sql
@sql/bars/data/PARAMS_PRIME_LOAD.sql
prompt @sql/bars/data/PARAMS_VALIDATION.sql
@sql/bars/data/PARAMS_VALIDATION.sql

prompt @sql/bars/Function/c_tag.sql
@sql/bars/Function/c_tag.sql

prompt @sql/bars/Scripts/op_rules.sql
@sql/bars/Scripts/op_rules.sql

prompt @\Sql\Bars\Job\INS_RCUKRU_999.job 
@Sql\Bars\Job\INS_RCUKRU_999.job


prompt @sql/bars/Scripts/001param_valid.sql
@sql/bars/Scripts/001param_valid.sql

prompt @sql/bars/Scripts/002op_rulesADD.sql
@sql/bars/Scripts/002op_rulesADD.sql

prompt @sql/bars/Scripts/003fpb1_.sql
@sql/bars/Scripts/003fpb1_.sql

prompt @sql/bars/Scripts/005add468620022017.sql
@sql/bars/Scripts/005add468620022017.sql

prompt @sql/bars/Scripts/OP_RULESaa.sql
@sql/bars/Scripts/OP_RULESaa.sql

prompt -- =======================
prompt -- data insert complete
prompt -- =======================


spool off

quit

