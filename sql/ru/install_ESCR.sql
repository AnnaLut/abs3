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

prompt ...Drop_table
@Sql\Bars\Table\drop_main_refer_tables.sql

prompt ...Table
prompt ...ESCR_REG_TYPES.sql
@Sql\Bars\Table\ESCR_REG_TYPES.sql
prompt ...escr_reg_kind.sql
@Sql\Bars\Table\escr_reg_kind.sql
prompt ...ESCR_REG_STATUS.sql
@Sql\Bars\Table\ESCR_REG_STATUS.sql
prompt ...ESCR_EVENTS.sql
@Sql\Bars\Table\ESCR_EVENTS.sql
prompt ...ESCR_REGISTER.sql
@Sql\Bars\Table\ESCR_REGISTER.sql
prompt ...ESCR_REG_MAPPING.sql
@Sql\Bars\Table\ESCR_REG_MAPPING.sql
prompt ...ESCR_REG_OBJ_STATE.sql
@Sql\Bars\Table\ESCR_REG_OBJ_STATE.sql
prompt ...ESCR_REG_HEADER.sql
@Sql\Bars\Table\ESCR_REG_HEADER.sql
prompt ...ESCR_BUILD_TYPES.sql
@Sql\Bars\Table\ESCR_BUILD_TYPES.sql
prompt ...ESCR_REG_BODY.sql
@Sql\Bars\Table\ESCR_REG_BODY.sql
prompt ...ESCR_ERRORS_TYPES.sql
@Sql\Bars\Table\ESCR_ERRORS_TYPES.sql
prompt ...ESCR_MAP_EVENT_TO_GOOD.sql
@Sql\Bars\Table\ESCR_MAP_EVENT_TO_GOOD.sql
prompt ...ESCR_MAP_EVENT_TO_BUILD_TYPE.sql
@Sql\Bars\Table\ESCR_MAP_EVENT_TO_BUILD_TYPE.sql
prompt ...ESCR_GOODS.sql
@Sql\Bars\Table\ESCR_GOODS.sql
prompt ...ESCR_REG_XML_FILES.sql
@Sql\Bars\Table\ESCR_REG_XML_FILES.sql

@Sql\Bars\script\create_errors_tables.sql

@Sql\Bars\type\OBJECT_deal_info.sql

prompt ...Sequence\S_ESCR.sql
@Sql\Bars\Sequence\S_ESCR.sql

prompt ...Function\F_DATE_CHECK.SQL
@Sql\Bars\Function\F_DATE_CHECK.SQL

prompt ...View
@Sql\Bars\View\VW_ESCR_REG_ALL_CREDITS.sql
@Sql\Bars\View\VW_ESCR_REG_HEADER.sql
@Sql\Bars\View\VW_ESCR_REG_BODY.sql
@Sql\Bars\View\VW_ESCR_REF.sql
@Sql\Bars\View\VW_ESCR_INVALID_CREDITS.sql
@Sql\Bars\View\VW_ESCR_REG_CREDIT_COUNT.sql
@Sql\Bars\View\VW_ESCR_REGISTER_LIST.sql


prompt ...del_Data
@Sql\Bars\script\del_data.sql

prompt ...Data
prompt ...Data\ESCR_REG_TYPES.sql
@Sql\Bars\Data\ESCR_REG_TYPES.sql
prompt ...Data\ESCR_REG_KIND.sql
@Sql\Bars\Data\ESCR_REG_KIND.sql
prompt ...Data\ESCR_REG_STATUS.sql
@Sql\Bars\Data\ESCR_REG_STATUS.sql
prompt ...Data\ESCR_EVENTS.sql
@Sql\Bars\Data\ESCR_EVENTS.sql
prompt ...Data\ESCR_BUILD_TYPES.sql
@Sql\Bars\Data\ESCR_BUILD_TYPES.sql
prompt ...Data\ESCR_ERRORS_TYPES.sql
@Sql\Bars\Data\ESCR_ERRORS_TYPES.sql
prompt ...Data\ESCR_MAP_EVENT_TO_GOOD.sql
@Sql\Bars\Data\ESCR_MAP_EVENT_TO_GOOD.sql
prompt ...Data\ESCR_MAP_EVENT_TO_BUILD_TYPE.sql
@Sql\Bars\Data\ESCR_MAP_EVENT_TO_BUILD_TYPE.sql
prompt ...Data\ESCR_GOODS.sql
@Sql\Bars\Data\ESCR_GOODS.sql


@Sql\Bars\Header\PKG_ESCR_REG_UTL.SQL
@Sql\Bars\Package\PKG_ESCR_REG_UTL.SQL

prompt ...Grant
@Sql\Bars\Grant\grants.sql











































































spool off

quit

