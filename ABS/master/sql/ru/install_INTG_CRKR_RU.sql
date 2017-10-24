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

PROMPT Tables

prompt @sql/bars/table/aP_MIGRAASCO.SQL
@sql/bars/table/aP_MIGRAASCO.SQL
prompt @sql/bars/table/aP_MIGRAASDE.SQL
@sql/bars/table/aP_MIGRAASDE.SQL
prompt @sql/bars/table/aP_MIGRAASME.SQL
@sql/bars/table/aP_MIGRAASME.SQL
prompt @sql/bars/table/COMPEN.SQL
@sql/bars/table/COMPEN.SQL
prompt @sql/bars/table/install.sql
@sql/bars/table/install.sql
prompt @sql/bars/table/crkr_import_users.sql
@sql/bars/table/crkr_import_users.sql
prompt @sql/bars/table/asvo_update_crkr_ffj.sql
@sql/bars/table/asvo_update_crkr_ffj.sql
prompt @sql/bars/table/asvo_update_crkr_err.sql
@sql/bars/table/asvo_update_crkr_err.sql
prompt @sql/bars/table/asvo_update_crkr_compen.sql
@sql/bars/table/asvo_update_crkr_compen.sql
prompt @sql/bars/table/asvo_update_crkr_benef.sql
@sql/bars/table/asvo_update_crkr_benef.sql

Prompt Function 
prompt @sql/bars/function/cpar.sql
@sql/bars/function/cpar.sql
prompt @sql/bars/function/int2hex.sql
@sql/bars/function/int2hex.sql


prompt @sql/bars/procedure/crkr_get_users.sql
@sql/bars/procedure/crkr_get_users.sql

prompt @sql/bars/job/crkr_send_users.sql
@sql/bars/job/crkr_send_users.sql

prompt @sql/bars/header/migraAS_head.sql
@sql/bars/header/migraAS_head.sql
prompt @sql/bars/package/migraAS_body.sql
@sql/bars/package/migraAS_body.sql

prompt @sql/bars/view/prov49.sql
@sql/bars/view/prov49.sql
prompt @sql/bars/view/prov4d.sql
@sql/bars/view/prov4d.sql
prompt @sql/bars/view/v_compen_count.sql
@sql/bars/view/v_compen_count.sql


PROMPT Data
prompt @sql/bars/data/ap_migraasCOins.SQL
@sql/bars/data/ap_migraasCOins.SQL
prompt @sql/bars/data/ap_migraasDEins.SQL
@sql/bars/data/ap_migraasDEins.SQL
prompt @sql/bars/data/ap_migraasMEins.SQL
@sql/bars/data/ap_migraasMEins.SQL
prompt @sql/bars/data/crearmmigv.sql
@sql/bars/data/crearmmigv.sql
prompt @sql/bars/data/full.sql
@sql/bars/data/full.sql
prompt @sql/bars/data/M7980290.sql
@sql/bars/data/M7980290.sql
prompt @sql/bars/data/patchfuncompens.sql
@sql/bars/data/patchfuncompens.sql
prompt @sql/bars/data/patchfuncompensDE.sql
@sql/bars/data/patchfuncompensDE.sql
prompt @sql/bars/data/patchfuncompensM.sql
@sql/bars/data/patchfuncompensM.sql
prompt @sql/bars/data/patchfuncompensME.sql
@sql/bars/data/patchfuncompensME.sql



spool off

quit

