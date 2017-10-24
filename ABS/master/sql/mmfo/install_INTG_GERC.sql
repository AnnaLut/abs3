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

prompt bars/Script/user_GERCTEST.sql
@bars/Script/user_GERCTEST.sql

prompt bars/Table/GERC_AUDIT.sql
@bars/Table/GERC_AUDIT.sql

prompt bars/Table/GERC_StateCodes.sql
@bars/Table/GERC_StateCodes.sql

prompt bars/Table/GERC_ORDERS.sql
@bars/Table/GERC_ORDERS.sql

prompt bars/Table/GERC_SIGNS.sql
@bars/Table/GERC_SIGNS.sql

prompt bars/Table/GERC_TTS.sql
@bars/Table/GERC_TTS.sql

prompt bars/Data/tts/G01.sql
@bars/tts/G01.sql

prompt bars/tts/G02.sql
@bars/Data/tts/G02.sql

prompt bars/Data/tts/G03.sql
@bars/Data/tts/G03.sql

prompt bars/Data/tts/G04.sql
@bars/Data/tts/G04.sql

prompt bars/Data/tts/G06.sql
@bars/Data/tts/G06.sql


prompt bars/Package/GERC_PAYMENTS.sql
@bars/Package/GERC_PAYMENTS.sql

prompt bars/Type/type_client_address.sql
@bars/Type/type_client_address.sql

prompt bars/Type/type_client_address.sql
@bars/Type/type_client_requisites.sql
















































spool off

quit

