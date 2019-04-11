-- это старое 
begin EXECUTE IMMEDIATE 'alter TABLE BARS.MONEX_UO add ( NLS_KOM varchar2(15) )' ;
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.MONEX_UO.nls_KOM IS 'Альтерн.рах.суб.агента(викороистовувати для комісії)';


GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.MONEX_UO TO BARS_ACCESS_DEFROLE;
