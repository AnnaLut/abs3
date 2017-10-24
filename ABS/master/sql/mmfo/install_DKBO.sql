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



prompt @View/W4_DEAL_WEB.sql
@sql/bars/View/W4_DEAL_WEB.sql

prompt @View/W4_DKBO_WEB.sql
@sql/bars/View/W4_DKBO_WEB.sql

prompt @Header/pkg_dkbo_utl.sql
@sql/bars/Header/pkg_dkbo_utl.sql
prompt @Header/attribute_utl.sql
@sql/bars/Header/attribute_utl.sql

prompt @Package/pkg_dkbo_utl.sql
@sql/bars/Package/pkg_dkbo_utl.sql
prompt @Package/attribute_utl.sql
@sql/bars/Package/attribute_utl.sql

prompt @Job/DKBO_CLOSE.sql
@sql/bars/Job/DKBO_CLOSE.sql









































































spool off

quit

