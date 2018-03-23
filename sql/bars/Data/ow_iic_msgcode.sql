declare
  l_tabid number:=get_tabid('V_OW_IIC_MSGCODE');
begin   
 Insert into BARS.REFERENCES
   (TABID, TYPE, ROLE2EDIT)
 Values
   (l_tabid, 29, 'OW');
exception when dup_val_on_index then null;
End;
/
commit;


declare
  l_tabid number:=get_tabid('V_OW_IIC_MSGCODE');
begin 
Insert into BARS.REFAPP
   (TABID, CODEAPP, ACODE, APPROVE, REVOKED, 
    GRANTOR)
 Values
   (l_tabid, 'WVIP', 'RW', 1, 0, 1);
exception when dup_val_on_index then null;
end;
/
commit;

exec bpa.alter_policy_info( 'V_OW_IIC_MSGCODE', 'WHOLE' , 'M', 'M', 'M', 'M' ); 
exec bpa.alter_policy_info( 'V_OW_IIC_MSGCODE', 'FILIAL', 'M', 'M', 'M', 'M' );

commit;

begin
   delete from refapp t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from references t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from meta_sortorder t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from meta_columns t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from dyn_filter t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from meta_tables t where t.tabname = 'OW_IIC_MSGCODE';
   delete from policy_table t where t.table_name = 'OW_IIC_MSGCODE';
end;
/
commit;




