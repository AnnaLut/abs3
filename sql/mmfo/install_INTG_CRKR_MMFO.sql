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
prompt  bars_pass  = &&bars_pass
prompt  ...


whenever sqlerror exit
prompt ...
prompt ... connecting as bars
prompt ...


conn  bars@&&dbname/&&bars_pass
whenever sqlerror continue


prompt TABLES
prompt ...Sql\Bars\Table\20policy.sql
@Sql\Bars\Table\20policy.sql
prompt ...Sql\Bars\Table\2nls9760.sql
@Sql\Bars\Table\2nls9760.sql
prompt ...Sql\Bars\Table\2zCOMPEN97.sql
@Sql\Bars\Table\2zCOMPEN97.sql
prompt ...Sql\Bars\Table\3tmp_verify_compen.sql
@Sql\Bars\Table\3tmp_verify_compen.sql
prompt ...Sql\Bars\Table\3tmp_verify_compen_TVBV.sql
@Sql\Bars\Table\3tmp_verify_compen_TVBV.sql
prompt ...Sql\Bars\Table\4tmp_crkr_report.sql
@Sql\Bars\Table\4tmp_crkr_report.sql
prompt ...Sql\Bars\Table\5tmp_crkr_report_tvbv.sql
@Sql\Bars\Table\5tmp_crkr_report_tvbv.sql
prompt ...Sql\Bars\Table\CRKR_CA_TRANSFER.sql
@Sql\Bars\Table\CRKR_CA_TRANSFER.sql

Prompt Data
prompt ...Sql\Bars\Data\1compen_op_field.sql
@Sql\Bars\Data\1compen_op_field.sql


prompt PACKAGES
prompt ...Sql\Bars\Header\ca_compen.pks
@Sql\Bars\Header\ca_compen.pks
prompt ...Sql\Bars\Package\ca_compen.pkb
@Sql\Bars\Package\ca_compen.pkb

prompt Scripts
prompt ...Sql\Bars\script\et_SSB.SQL
@Sql\Bars\script\et_SSB.SQL
prompt ...Sql\Bars\script\et_SSP.SQL
@Sql\Bars\script\et_SSP.SQL
prompt ...Sql\Bars\script\0acc_open_9760.sql
@Sql\Bars\script\0acc_open_9760.sql
prompt ...Sql\Bars\script\0acc_open_9760a.sql
@Sql\Bars\script\0acc_open_9760a.sql


prompt Reports
prompt ...Sql\Bars\Report\_BRS_SBER_CRCA_3102.sql
@Sql\Bars\Report\_BRS_SBER_CRCA_3102.sql
prompt ...Sql\Bars\Report\_BRS_SBER_CRCA_3119.sql
@Sql\Bars\Report\_BRS_SBER_CRCA_3119.sql


spool off

quit

