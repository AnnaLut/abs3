exec bars.bpa.alter_policy_info( 'ND_ACC_OLD', 'WHOLE' , null, null, null, null ); 

exec bars.bpa.alter_policy_info( 'ND_ACC_OLD', 'FILIAL', null, null, null, null );

begin  EXECUTE IMMEDIATE 'CREATE TABLE bars.ND_ACC_OLD (nd number, acc number)  ';
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('ND_ACC_OLD'); 

commit;


begin EXECUTE IMMEDIATE 'ALTER TABLE bars.ND_ACC_OLD add  CONSTRAINT XPK_NDACCOLD  PRIMARY KEY  (nd,acc) ' ;
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   -- ORA-02260: table can have only one primary key
end;
/