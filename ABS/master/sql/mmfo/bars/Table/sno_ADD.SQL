exec bars.bpa.alter_policy_info( 'SNO_GPP', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'SNO_GPP', 'FILIAL', null, null, null, null );

begin EXECUTE IMMEDIATE 'CREATE TABLE BARS.SNO_GPP(  ND     NUMBER,  FDAT   DATE,  SUMP1  NUMBER,  ACC    NUMBER,  DAT31  DATE) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('SNO_GPP'); 
commit;
/
