set verify off
set echo off
set serveroutput on size 1000000
spool INTG_DPA/log/install.log
set lines 3000


prompt...
prompt ...
prompt ... loading params
prompt ...

@INTG_DPA/params.sql

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


prompt ...@INTG_DPA\Sql\Bars\Table\dpa_lob.sql 
@INTG_DPA\Sql\Bars\Table\dpa_lob.sql 
prompt ...@INTG_DPA\Sql\Bars\Table\dpa_params.sql
@INTG_DPA\Sql\Bars\Table\dpa_params.sql
prompt ...@INTG_DPA\Sql\Bars\View\v_cvk_ca.sql 
@INTG_DPA\Sql\Bars\View\v_cvk_ca.sql 
prompt ...@INTG_DPA\Sql\Bars\View\v_dpa_cv.sql 
@INTG_DPA\Sql\Bars\View\v_dpa_cv.sql 
prompt ...@INTG_DPA\Sql\Bars\Package\bars_dpa.pkb 
@INTG_DPA\Sql\Bars\Package\bars_dpa.pkb 
prompt ...@INTG_DPA\Sql\Bars\Header\bars_dpa.pks 
@INTG_DPA\Sql\Bars\Header\bars_dpa.pks 
prompt ...@INTG_DPA\Sql\Bars\Data\operlist_dpafiles.sql 
@INTG_DPA\Sql\Bars\Data\operlist_dpafiles.sql 
prompt ...@INTG_DPA\Sql\Bars\Data\branch_attributes.sql
@INTG_DPA\Sql\Bars\Data\branch_attributes.sql
prompt ...@INTG_DPA\Sql\Bars\Data\fill_dpa_params.sql
@INTG_DPA\Sql\Bars\Data\fill_dpa_params.sql









































































spool off

quit

