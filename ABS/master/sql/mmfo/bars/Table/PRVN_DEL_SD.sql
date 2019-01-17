PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_DEL_SD.sql ====*** Run *** ======
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'PRVN_DEL_SD', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'PRVN_DEL_SD', 'FILIAL', null, null, null, null );

PROMPT *** Create  table PRVN_DEL_SD ***

begin  EXECUTE IMMEDIATE
 'CREATE TABLE bars.PRVN_DEL_SD ( 
 KF VARCHAR2(6) , 
 ND number, 
 Tip char(3), 
 OST number, 
 B number, 
 SV number, 
 SA number, 
 XA number, 
 ref number )' ;           
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/


exec  bars.bpa.alter_policies('PRVN_DEL_SD'); 

PROMPT *** Create  constraint PRVN_DEL_SD ***
begin    execute immediate ' ALTER TABLE bars.PRVN_DEL_SD ADD CONSTRAINT XPK_PRVNDELSD PRIMARY KEY (KF, ND, TIP)';
exception when others then   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

