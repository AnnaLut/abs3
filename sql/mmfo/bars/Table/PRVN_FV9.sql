PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Table/PRVN_FV9.sql ========*** Run *** ======
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'PRVN_FV9', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'PRVN_FV9', 'FILIAL', null, null, null, null );

PROMPT *** Create  table PRVN_FV9 ***

begin  EXECUTE IMMEDIATE 
     'CREATE TABLE bars.PRVN_FV9 
         ( Dat01 date, 	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),  
           name_KF varchar2(100), ID_CALC_SET number, 
           p01 int, p02 int, p03 int, p04 int, p05 int, 
           p06 int, p07 int, p08 int, p09 int, p10 int, p11 int)
TABLESPACE BRSMDLD   ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('PRVN_FV9'); 

begin
 execute immediate   'alter table PRVN_FV9 add (p10 int) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV9 add (p11 int) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

begin
 execute immediate   'alter table PRVN_FV9 add (p12 int) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

PROMPT *** Create  constraint PRVN_FV9 ***
begin   
 execute immediate '
  ALTER TABLE bars.PRVN_FV9 ADD CONSTRAINT XPK_PRVNFV9 PRIMARY KEY (Dat01, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI   ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
CREATE OR REPLACE PUBLIC SYNONYM PRVN_FV9_RO FOR BARS.PRVN_FV9;

PROMPT *** Create  grants  PRVN_FV9 ***
grant SELECT,UPDATE                                                          on PRVN_FV9       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_FV9       to BARS_DM;
grant SELECT,UPDATE                                                          on PRVN_FV9       to START1;
grant SELECT                                                                 on PRVN_FV9       to UPLD;


