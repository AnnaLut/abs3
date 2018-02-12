begin
 bpa.remove_policies( 'OW_IIC_MSGCODE');
end;
/

commit;

begin
   delete from refapp t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from references t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from meta_sortorder t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from meta_columns t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from dyn_filter t where t.tabid = (select t.tabid from meta_tables t where t.tabname = 'OW_IIC_MSGCODE');
   delete from meta_tables t where t.tabname = 'OW_IIC_MSGCODE';
end;
/
commit;




