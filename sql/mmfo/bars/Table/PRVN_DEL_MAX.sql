PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_DEL_MAX.sql =========*** Run *** ======
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'PRVN_DEL_MAX', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'PRVN_DEL_MAX', 'FILIAL', null, null, null, null );

PROMPT *** Create  table PRVN_DEL_MAX ***

begin  EXECUTE IMMEDIATE 'CREATE TABLE bars.PRVN_DEL_MAX 
( KF VARCHAR2(6) , DEL_SDF number, DEL_SDM number, DEL_SDI number,DEL_SDA number, DEL_SNA number, DEL_SRR number)' ;           
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('PRVN_DEL_MAX'); 

PROMPT *** Create  constraint PRVN_DEL_MAX ***
begin    execute immediate ' ALTER TABLE bars.PRVN_DEL_MAX ADD CONSTRAINT XPK_PRVNDELMAX PRIMARY KEY (KF)';
exception when others then   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/

begin EXECUTE IMMEDIATE 'alter table PRVN_DEL_MAX add (DEL_REZ_SUM number, DEL_REZ_PRC number) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/


PROMPT *** Create  grants  PRVN_DEL_MAX ***

grant SELECT,UPDATE, insert , delete     on PRVN_DEL_MAX       to BARS_ACCESS_DEFROLE;

