begin EXECUTE IMMEDIATE 'alter table bars.prvn_flow_deals_const  add ( NDo number) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_CONST.NDo IS 'Ðופ םמגמדמ ÊÄ ';
