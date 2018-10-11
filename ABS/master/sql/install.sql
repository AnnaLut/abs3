@params.sql

@params.sql

set verify off
set echo off
set trimspool on
set serveroutput on size 1000000
spool log\install_(&&dbname).log
set lines 3000
set SQLBL on
set timing on
set escchar @


define release_name=Release_2.1.39.2
prompt...
prompt ...
prompt ... loading params
prompt ...
@params.sql
whenever sqlerror exit
prompt ...
prompt ... connecting as bars 
prompt ...
conn bars@&&dbname/&&bars_pass
whenever sqlerror continue

prompt ... 
prompt ... invalid objects before install
prompt ... 

select owner, object_name, object_type         
from all_objects a where a.status = 'INVALID' and a.owner in ('BARS','BARSUPL','BARS_DM','DM','MGW_AGENT','PFU','SBON','SYS','BARSTRANS','BARS_INGR','MSP', 'CDB', 'IBMESB', 'NBU_GATEWAY')
order by owner, object_type;


prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn barsaq@&&dbname/&&barsaq_pass  
whenever sqlerror continue                           


@mmfo\barsaq\Table\ibank_acc.sql
@mmfo\barsaq\Script\ibank_acc_grant.sql
@mmfo\barsaq\Package\rpc_sync.sql
@mmfo\barsaq\Package\data_import.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

--@mmfo\bars\Data\upd_operlist.sql
--@mmfo\bars\Sequence\CORP2_REL_CUST_SEQ.sql
--@mmfo\bars\Table\CORP2_REL_CUSTOMERS.sql
--@mmfo\bars\Table\CORP2_ACC_USERS.sql
--@mmfo\bars\Table\CORP2_ACC_VISA_COUNT.sql
--@mmfo\bars\Table\CORP2_ACSK_CERTIFICATE_REQ.sql
--@mmfo\bars\Table\CORP2_ACSK_REGISTRATION.sql
--@mmfo\bars\Table\CORP2_CUST_REL_USERS_MAP.sql
--@mmfo\bars\Table\CORP2_MODULES.sql
--@mmfo\bars\Table\CORP2_FUNCTIONS.sql
--@mmfo\bars\Table\CORP2_MODULE_FUNCTIONS.sql
--@mmfo\bars\Table\CORP2_REL_CUSTOMERS_ADDRESS.sql
--@mmfo\bars\Table\CORP2_USER_FUNCTIONS.sql
--@mmfo\bars\Table\CORP2_USER_MODULES.sql
--@mmfo\bars\Table\CORP2_USER_VISA_STAMPS.sql
--@mmfo\bars\Table\corp2_limits.sql
--@mmfo\bars\Table\corp2_user_limit.sql
--@mmfo\bars\View\v_corp2_accounts.sql


prompt @mmfo\bars\Data\error\mod_doc.sql  
@mmfo\bars\Data\error\mod_doc.sql  

prompt @mmfo\bars\Table\sdo_autopay_rules.sql  
@mmfo\bars\Table\sdo_autopay_rules.sql  

prompt @mmfo\bars\Table\sdo_autopay_rules_fields.sql  
@mmfo\bars\Table\sdo_autopay_rules_fields.sql  

prompt @mmfo\bars\Table\sdo_autopay_rules_desc.sql  
@mmfo\bars\Table\sdo_autopay_rules_desc.sql  

prompt @mmfo\bars\Function\sdo_autopay_check_corp2.sql  
@mmfo\bars\Function\sdo_autopay_check_corp2.sql  

prompt @mmfo\bars\Script\insert_sdo_auto_rules.sql  
@mmfo\bars\Script\insert_sdo_auto_rules.sql  

prompt @mmfo\bars\Grant\grant_barsaq.sql  
@mmfo\bars\Grant\grant_barsaq.sql  

prompt @mmfo\bars\Package\sdo_autopay.sql
@mmfo\bars\Package\sdo_autopay.sql

prompt @mmfo\bars\Data\bmd\sdo_autopay_rules.sql  
@mmfo\bars\Data\bmd\sdo_autopay_rules.sql  

prompt @mmfo\bars\Data\bmd\sdo_autopay_rules_desc.sql  
@mmfo\bars\Data\bmd\sdo_autopay_rules_desc.sql  

prompt @mmfo\bars\Data\bmd\sdo_autopay_rules_fields.sql  
@mmfo\bars\Data\bmd\sdo_autopay_rules_fields.sql  

prompt @mmfo\bars\Script\add_sdo_function.sql  
@mmfo\bars\Script\add_sdo_function.sql  


prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn barsaq@&&dbname/&&barsaq_pass  
whenever sqlerror continue                           

prompt @mmfo\barsaq\Table\doc_import.sql 
@mmfo\barsaq\Table\doc_import.sql 
prompt @mmfo\barsaq\Package\bars_docsync.sql  
@mmfo\barsaq\Package\bars_docsync.sql  
prompt @mmfo\barsaq\Package\data_import.sql  
@mmfo\barsaq\Package\data_import.sql  
prompt @mmfo\barsaq\View\v_doc_import_auto.sql  
@mmfo\barsaq\View\v_doc_import_auto.sql  





spool off
quit
