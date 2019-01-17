PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_DEL_REZ.sql =========*** Run *** ======
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'PRVN_DEL_REZ', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'PRVN_DEL_REZ', 'FILIAL', null, null, null, null );

PROMPT *** Create  table PRVN_DEL_REZ ***

begin  EXECUTE IMMEDIATE 'CREATE TABLE bars.PRVN_DEL_REZ 
   ( fdat date,
     KF   VARCHAR2(6), 
     kv   integer, 
     rez  number, 
     ost  number,
     DEL  number)' ;           
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('PRVN_DEL_REZ'); 

COMMENT ON COLUMN BARS.PRVN_DEL_REZ.fdat        IS 'Звітна дата';
COMMENT ON COLUMN BARS.PRVN_DEL_REZ.KF          IS 'Код філіала';
COMMENT ON COLUMN BARS.PRVN_DEL_REZ.KV          IS 'Код валюти';
COMMENT ON COLUMN BARS.PRVN_DEL_REZ.REZ         IS 'Сформований резерв';
COMMENT ON COLUMN BARS.PRVN_DEL_REZ.OST         IS 'Проведений  резерв';
COMMENT ON COLUMN BARS.PRVN_DEL_REZ.DEL         IS 'Відхилення';

PROMPT *** Create  constraint PRVN_DEL_REZ ***
begin    execute immediate ' ALTER TABLE bars.PRVN_DEL_REZ ADD CONSTRAINT XPK_PRVNDELMAX PRIMARY KEY (fdat, KF, KV)';
exception when others then   if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


PROMPT *** Create  grants  PRVN_DEL_REZ ***

grant SELECT,UPDATE, insert , delete     on PRVN_DEL_REZ       to BARS_ACCESS_DEFROLE;

