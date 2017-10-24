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


whenever error exit
prompt ...
prompt ... connecting as bars
prompt ...

custtype.sql 
rezid.sql 
codcagent.sql 
country.sql 
prinsider.sql 
tgr.sql 
freq.sql 
stmt.sql 
fs.sql 
ise.sql 
oe.sql 
sed.sql 
sp_k050.sql 
ved.sql 


basey.sql 
tabval$global.sql 
tabval$local.sql 
tabval.sql
--dir_rrp.sql 
--pm_rrp.sql 
banks$base.sql 
--banks$settings.sql 
--banks.sql 

customer.sql 
customer_update.sql 
customer_field_codes.sql 
customer_field.sql 
customerw.sql 
customerw_update.sql 
customerp.sql 
ADDRESS_HOME_TYPE.sql 
ADDRESS_HOMEPART_TYPE.sql 
ADDRESS_LOCALITY_TYPE.sql 
ADDRESS_ROOM_TYPE.sql 
ADDRESS_STREET_TYPE.sql 
customer_address_type.sql 
customer_address.sql 
customer_extern.tbl 
customer_extern_update.sql 
customer_bin_data.sql 
cust_rel.sql 
trustee_type.sql 
trustee_document_type.sql 
customer_rel.sql 
customer_rel_update.sql 
customer_image_types.sql 
customer_images.sql 
passp.sql 
person.sql 
person_update.sql 
corps.sql 
corps_update.sql 
corps_acc.sql 
custbank.sql 
custbank_update.sql 
dwh_log.sql

acc_par.sql 
tmp_acchist.sql 

tiu_cus.sql 
tiu_cusa.sql 
tiu_cusb.sql 
taiud_customerw_update.sql 
taiud_customerextern_update.sql 
taiud_customerrel_update.sql 
taiud_person_update.sql 
taiud_corps_update.sql 
taiud_custbank_update.sql 

customerpv.sql 
v_customer.sql


spool off

quit

