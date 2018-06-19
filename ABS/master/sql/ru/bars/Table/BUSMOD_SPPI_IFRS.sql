prompt ---------------------------------------------------------------
prompt 0.TABLE CREATE TABLE bars.BUSMOD_SPPI_IFRS
prompt ---------------------------------------------------------------

begin  EXECUTE IMMEDIATE 'drop TABLE bars.BUSMOD_SPPI_k9 ' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   -- ORA-00942: table or view does not exist
end;
/

exec bars.bpa.alter_policy_info( 'BUSMOD_SPPI_IFRS', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'BUSMOD_SPPI_IFRS', 'FILIAL', null, null, null, null );

begin  EXECUTE IMMEDIATE 'CREATE TABLE bars.BUSMOD_SPPI_IFRS(  BUS_MOD int,  SPPI VARCHAR2(5), IFRS VARCHAR2 (15) ) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('BUSMOD_SPPI_IFRS'); 

begin EXECUTE IMMEDIATE 'ALTER TABLE bars.BUSMOD_SPPI_IFRS add  CONSTRAINT XPK_BUSMODSPPIFRS  PRIMARY KEY  (BUS_MOD, SPPI ) ' ;
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   -- ORA-02260: table can have only one primary key
end;
/
