------------------------------
exec bars.bpa.alter_policy_info( 'BUSMOD_SPPI_K9', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'BUSMOD_SPPI_K9', 'FILIAL', null, null, null, null );

begin  EXECUTE IMMEDIATE 'CREATE TABLE bars.BUSMOD_SPPI_K9(  BUS_MOD int,  SPPI VARCHAR2(5),  K9 int ) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/
exec  bars.bpa.alter_policies('BUSMOD_SPPI_K9'); 

begin EXECUTE IMMEDIATE 'ALTER TABLE bars.BUSMOD_SPPI_K9 add  CONSTRAINT XPK_BUSMOD_SPPI_K9  PRIMARY KEY  (BUS_MOD, SPPI ) ' ;
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   -- ORA-02260: table can have only one primary key
end;
/