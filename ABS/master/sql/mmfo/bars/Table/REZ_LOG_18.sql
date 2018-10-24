PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Table/REZ_LOG_18.sql ========*** Run *** ======
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'REZ_LOG_18', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'REZ_LOG_18', 'FILIAL', null, null, null, null );

PROMPT *** Create  table REZ_LOG_18 ***

begin  EXECUTE IMMEDIATE 
     'CREATE TABLE bars.REZ_LOG_18 
         ( Dat01 date, 	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),  
           name_KF varchar2(100), C1 int, C2 int, C3 int)
TABLESPACE BRSMDLD   ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('REZ_LOG_18'); 

PROMPT *** Create  constraint REZ_LOG_18 ***
begin   
 execute immediate '
  ALTER TABLE bars.REZ_LOG_18 ADD CONSTRAINT XPK_PRVNFV9 PRIMARY KEY (Dat01, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI   ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
PROMPT *** Create  grants  REZ_LOG_18 ***
grant SELECT,UPDATE                                                          on REZ_LOG_18       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_LOG_18       to BARS_DM;
grant SELECT,UPDATE                                                          on REZ_LOG_18       to START1;
grant SELECT                                                                 on REZ_LOG_18       to UPLD;


