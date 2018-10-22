prompt ... =========================================
prompt ... === depersonalization v0.1 11.10.2018
prompt ... =========================================

set serveroutput on size 1000000
col cur_time new_value g_cur_time
select to_char(sysdate, 'yyyymmddhh24mi') as cur_time from dual;
spool log\050_depersonalization_&g_cur_time.log
set lines 3000
set time on
set timing on

prompt ... === start of depersonalization 

prompt ... === depersonalization.dep_customer_update;          
exec depersonalization.dep_customer_update;
prompt ... === depersonalization.dep_customer_rel;             
exec depersonalization.dep_customer_rel;
prompt ... === depersonalization.dep_customer_rel_update;      
exec depersonalization.dep_customer_rel_update;
prompt ... === depersonalization.dep_customer_address;         
exec depersonalization.dep_customer_address;
prompt ... === depersonalization.dep_customer_address_update;  
exec depersonalization.dep_customer_address_update;
prompt ... === depersonalization.dep_person;                   
exec depersonalization.dep_person;
prompt ... === depersonalization.dep_person_update;            
exec depersonalization.dep_person_update;
prompt ... === depersonalization.dep_customerw;                
exec depersonalization.dep_customerw;
prompt ... === depersonalization.dep_customerw_update;         
exec depersonalization.dep_customerw_update;
prompt ... === depersonalization.dep_accounts;                 
exec depersonalization.dep_accounts;
prompt ... === depersonalization.dep_accounts_update;          
exec depersonalization.dep_accounts_update;
prompt ... === depersonalization.dep_arc_rrp;                  
exec depersonalization.dep_arc_rrp;
prompt ... === depersonalization.dep_oper;                     
exec depersonalization.dep_oper;
prompt ... === depersonalization.dep_opldok;                   
exec depersonalization.dep_opldok; 
prompt ... === depersonalization.dep_ead_docs;                 
exec depersonalization.dep_ead_docs;
prompt ... === depersonalization.dep_customer_images;          
exec depersonalization.dep_customer_images;
prompt ... === depersonalization.dep_operw;                    
exec depersonalization.dep_operw;

prompt ... === depersonalization.dep_customer;                 
exec depersonalization.dep_customer;

prompt ... === finish of depersonalization 

spool off
quit
